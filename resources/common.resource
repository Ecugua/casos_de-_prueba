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
