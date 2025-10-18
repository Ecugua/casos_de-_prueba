*** Settings ***
Library    SeleniumLibrary
Resource   ../resources/common.resource
Test Teardown    Run Keywords    Screenshot If Failed    AND    Close Browser

*** Test Cases ***
Google search shows Robot Framework site
    Open Chrome To    https://www.google.com
    Wait Until Element Is Visible    name:q    10s
    Input Text    name:q    robot framework
    Press Keys     name:q    ENTER
    Wait Until Page Contains    robotframework.org    20s
