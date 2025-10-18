*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/common.resource
Suite Setup       Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown     Run Keywords    Screenshot If Failed    AND    Close Browser

*** Test Cases ***
Robot Framework homepage loads
    Open Chrome To    https://www.google.com
    Wait Until Element Is Visible    name:q    10s
    Input Text    name:q    robot framework
    Press Keys     name:q    ENTER
    Wait Until Page Contains    robotframework.org    20s


