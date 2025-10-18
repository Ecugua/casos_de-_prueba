*** Settings ***
Library    DatabaseLibrary

*** Variables ***
${DBPATH}    sample.db

*** Test Cases ***
Create table, insert and query using SQLite
    Connect To Database    sqlite3    ${DBPATH}
    Execute Sql String    CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT);
    Execute Sql String    DELETE FROM users;
    Execute Sql String    INSERT INTO users(name) VALUES ('Alice');
    Execute Sql String    INSERT INTO users(name) VALUES ('Bob');
    @{rows}=    Query    SELECT name FROM users ORDER BY name;
    Length Should Be    ${rows}    1
    Should Be Equal    ${rows[0][0]}    Alice
    Should Be Equal    ${rows[1][0]}    Bob
    Disconnect From Database
