*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    BuiltIn

*** Variables ***
${BASE}    http://127.0.0.1:5000

*** Keywords ***
Pretty Print JSON
    [Arguments]    ${data}
    ${pretty}=    Evaluate    __import__('json').dumps(${data}, indent=2, ensure_ascii=False)
    Log To Console    ${pretty}
    Log    ${pretty}    level=INFO

*** Test Cases ***
List posts returns 200
    Create Session    api    ${BASE}
    ${r}=    GET On Session    api    url=/posts    expected_status=any
    Should Be Equal As Integers    ${r.status_code}    200
    ${items}=    Convert To List    ${r.json()}
    Should Be True    len(${items}) > 0

Create post returns 201
    Create Session    api    ${BASE}
    ${body}=    Create Dictionary    title=hello    body=from_robot    userId=1
    Log To Console    === Request JSON ===
    Pretty Print JSON    ${body}

    ${r}=    POST On Session    api    url=/posts    json=${body}    expected_status=any
    Log To Console    Status: ${r.status_code}
    Should Be Equal As Integers    ${r.status_code}    201

    ${resp}=    Set Variable    ${r.json()}
    Log To Console    === Response JSON ===
    Pretty Print JSON    ${resp}

    Dictionary Should Contain Key    ${resp}    id
