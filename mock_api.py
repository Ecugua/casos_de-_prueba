from flask import Flask, jsonify, request
import json, os, tempfile, shutil

app = Flask(__name__)

# Ruta absoluta y carga inicial desde db.json
BASE_DIR = os.path.dirname(__file__)
DB_PATH = os.path.join(BASE_DIR, "db.json")

with open(DB_PATH, "r", encoding="utf-8") as f:
    _db = json.load(f)
posts = list(_db.get("posts", []))  # en memoria

@app.get("/posts")
def list_posts():
    user_id = request.args.get("userId")
    result = posts
    if user_id is not None:
        result = [p for p in posts if str(p.get("userId")) == str(user_id)]
    return jsonify(result), 200

@app.post("/posts")
def create_post():
    body = request.get_json(silent=True) or {}
    # asignar id incremental
    new_id = (max([p["id"] for p in posts]) if posts else 0) + 1
    body["id"] = new_id
    posts.append(body)

    # --- PERSISTIR EN DISCO (escritura atómica) ---
    tmp_fd, tmp_path = tempfile.mkstemp(dir=BASE_DIR, suffix=".tmp")
    try:
        with os.fdopen(tmp_fd, "w", encoding="utf-8") as tmp:
            json.dump({"posts": posts}, tmp, ensure_ascii=False, indent=2)
        shutil.move(tmp_path, DB_PATH)  # reemplaza el archivo de forma segura
    finally:
        # Si algo falla antes del move, limpia el temp
        if os.path.exists(tmp_path):
            try:
                os.remove(tmp_path)
            except OSError:
                pass
    # ----------------------------------------------

    return jsonify(body), 201

if __name__ == "__main__":
    # OJO: debug=False para evitar doble ejecución del reloader que puede confundir
    app.run(host="127.0.0.1", port=5000, debug=False)
