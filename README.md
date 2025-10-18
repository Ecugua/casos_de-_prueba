Objetivo
Aplicar Robot Framework en distintos contextos de testing: Web (Selenium), API (RequestsLibrary), Base de Datos (DatabaseLibrary) e integración con Jenkins, generando reportes y evidencias.

Requisitos
Python 3.10+
Google Chrome (o Edge) instalado
Jenkins (si se integra CI)


Instalación (local)
py -m pip install -U robotframework robotframework-seleniumlibrary selenium
py -m pip install -U robotframework-requests robotframework-databaselibrary
py -m pip install robotframework-databaselibrary psycopg2-binary


Estructura del proyecto
.
├─ tests/
│  ├─ 01_web_google.robot        # Prueba web con SeleniumLibrary
│  ├─ 02_api_reqres.robot        # Pruebas API (GET/POST) con RequestsLibrary
│  └─ 03_db_sqlite.robot         # Prueba DB con DatabaseLibrary (SQLite)
├─ resources/
│  └─ common.resource            # Keywords comunes (abrir navegador, capturas)
└─ Jenkinsfile                    # Pipeline de CI (opcional)


Descripción de pruebas
1) Web – SeleniumLibrary

Abre https://robotframework.org y valida contenido visible.

Reutiliza Open Chrome To y Screenshot If Failed desde resources/common.resource.

2) API – RequestsLibrary

GET http://jsonplaceholder.typicode.com/posts ⇒ espera 200 y lista no vacía.

POST http://jsonplaceholder.typicode.com/posts ⇒ espera 201 y campo id en respuesta.

Se usa un endpoint HTTP público para evitar bloqueos/captchas/proxy en redes estrictas.

3) Base de Datos – DatabaseLibrary (SQLite)

Crea tabla, inserta filas y valida resultados con Query.

Driver sqlite3 (no requiere instalación extra).




Ejecución local

Desde la raíz del proyecto:

robot -d results tests