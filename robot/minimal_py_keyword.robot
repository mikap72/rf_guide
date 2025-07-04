*** Settings ***
Library    Browser
Library    ../python/CustomKeywords.py

*** Variables ***
@{SEARCH_TERMS}    robot framework    browser library    test automation

*** Test Cases ***
Test Custom Keyword With Array
    [Documentation]    Test that demonstrates custom Python keyword accepting array
    New Browser    chromium    headless=False
    New Page    https://www.google.com
    
    # Use custom keyword that accepts array
    Search Multiple Terms    ${SEARCH_TERMS}
    
    # Verify we're still on Google
    Get Title    ==    Google
    
    Close Browser

*** Keywords ***
Search Multiple Terms
    [Arguments]    ${terms}
    [Documentation]    Wrapper keyword that calls Python custom keyword
    Process Search Terms    ${terms}