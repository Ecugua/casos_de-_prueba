*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary

*** Keywords ***
Screenshot If Failed
    Run Keyword If    '${TEST STATUS}'=='FAIL'    Capture Page Screenshot

Open Chrome To
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window

Screenshot If Failed
    Run Keyword If    '${TEST STATUS}'=='FAIL'
    ...    ${name}=    Evaluate    "${TEST NAME}".replace(" ", "_")
    ...    ${ts}=      Get Time    epoch
    ...    Capture Page Screenshot    ${OUTPUT DIR}${/}screenshots${/}${name}-${TEST STATUS}-${ts}.png