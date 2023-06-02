*** Settings ***
Documentation  Basic Amazon Shopping Functionality
Library  SeleniumLibrary
Resource  ../../Resources/CommonFunctionality.robot
Variables  ../../Resources/Webelements.py


Test Setup  Given the user wants to browse Amazon
Test Teardown  Then the user wants to stop browsing

*** Variables ***
${search_text}  computer
@{search_pref}  Featured  Price: Low to high  Price: High to low  Avg. Customer review  Newest arrivals
# Choose your search preference, indicate the index below
${index}  4
${sortby}  ${search_pref}[${index}]

#Created a dummy account for amazon.co.uk
${USER}  cemojo4564@onlcool.com
${key}  password


*** Test Cases ***
Scenario: An user wants to search for a product
    [Documentation]  This test case verifies the basic search functionality of amazon.co.uk
    [Tags]  Functional

    When the user searches for a product
    Then the search results should contain items corresponding to the product
    When the user wants to sort the search results in a particular order
    Then the search results should be sorted accordingly

Scenario: An user wants to click on the first search result
    [Documentation]  This test verifies that the first search result is clickable
    [Tags]  Functional

    When the user searches for a product
    Then the user should be able to click on the first search result and land on the product page

Scenario: An user wants to add an item to the cart
    [Documentation]  This test verifies that an item can be added to the cart
    [Tags]  Functional

    When the user searches for a product
    Then they should be able to put an item to the cart
    And they should see that the item has been put into the basket

Scenario: An user wants to sign in and out of their account
   [Documentation]  This test verifies the log in/out functionalities
   [Tags]  Functional

    When the user wants to sign in
    And enters their credentials correctly
    Then they should be signed in
    When an user wants to sign out
    Then they should be signed out


*** Keywords ***
When the user searches for a product
    Input Text  ${Searchbox}  ${search_text}
    Press Keys  ${SearchButton}  RETURN

Then the search results should contain items corresponding to the product
    Page Should Contain  results for "${search_text}"

When the user wants to sort the search results in a particular order
    Select From List By Index  ${sortpreference}  ${index}

Then the search results should be sorted accordingly
    Select From List By Index  ${sortpreference}  ${index}
    Page Should Contain  Sort by:${sortby}

Then the user should be able to click on the first search result and land on the product page
    ${FirstResultName}  Get Text  ${firstresult}
    Click Element  ${firstelementlink}
    ${ClickedName}  Get Text  ${producttitle}
    Should Be Equal As Strings    ${FirstResultName}  ${ClickedName}

Then they should be able to put an item to the cart
    Click Element  ${firstelementlink}
    Click Element  ${addtocartbox}

And they should see that the item has been put into the basket
    Page Should Contain  Added to Basket

When the user wants to sign in
    Click Element  ${signinentry}

And enters their credentials correctly
    Input Text  ${emailbox}  ${USER}
    Click Element  ${continuebutton}
    Input text  ${passwordbox}  ${key}
    Click Element  ${signinbutton}

They should be signed in
    Wait Until Page Contains  Buy Again

When an user wants to sign out
    Mouse Over  ${accountinfo}
    Click Element  ${signoutbutton}

Then they should be signed out
    Wait Until Page Contains  Sign in