*** Settings ***
Library    OperatingSystem
Library    SeleniumLibrary
Library    BuiltIn

*** Keywords ***
Screenshot If Failed
    Run Keyword If    '${TEST STATUS}'=='FAIL'
    ...    Capture Page Screenshot    ${OUTPUT DIR}${/}screenshots${/}${TEST NAME}-${TEST STATUS}-${START TIME}.png


*** Test Cases ***
Robot Framework homepage loads
    Open Chrome To    https://robotframework.org
    Wait Until Page Contains    Robot Framework    30s

