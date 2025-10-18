*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/common.resource
Suite Setup       Set Screenshot Directory    ${OUTPUT DIR}${/}screenshots
Test Teardown     Run Keywords    Screenshot If Failed    AND    Close Browser

*** Test Cases ***
Robot Framework homepage loads
    Open Chrome To    https://robotframework.org
    Wait Until Page Contains    Robot Framework    30s


