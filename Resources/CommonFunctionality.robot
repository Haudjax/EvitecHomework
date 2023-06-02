*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Given the user wants to browse Amazon
    Open Browser  https://www.amazon.co.uk  chrome

Then the user wants to stop browsing
    Close Browser

