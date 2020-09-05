*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  String 

*** Test Cases ***

# Taso 1 ja Taso 2
Open Foodie
    Open Browser    https://www.foodie.fi  chrome
    maximize browser window
    Sleep           2s
    Click Link      Hyväksy kaikki evästeet

Find recipe
    Click Link                         Reseptit
    Input Text                         id=multisearch-query    avokadopasta
    Click Button                       id=multisearch-btn
    Wait Until Page Contains Element   //*[@id="recipelist"]/ul/li[1]
    Click Element                      //*[@id="recipelist"]/ul/li[1]

Add incredients to shoppinglist
    Wait Until Page Contains Element   //*[@id="recipe_actions"]/div[1]/div/div/i
    Click Element                      //*[@id="recipe_actions"]/div[1]/div/div/i
    Sleep    5s

Open shoppinglist
    Click Element                      //*[@id="topmenu-shoppinglist"]/a

Close
    Close Browser

# Taso 3

Open Foodie
    Open Browser         https://www.foodie.fi  chrome
    maximize browser window
    Sleep                2s
    Click Button         Hyväksy kaikki evästeet

| Add more products to shoppinglist                     |
|  |  ${contents}=  |  Get File                         |   tuotteet.txt
|  |  @{lines}=     |  Split to Lines                   |   ${contents}
|  |  FOR           | ${line}                           | IN                    | @{lines}
|  |                | Input Text                        | id=multisearch-query  | ${line}
|  |                | Click Button                      | id=multisearch-btn
|  |                | Wait Until Page Contains          | Hakutulokset "${line}"
|  |                | Click Element                     | class=img-responsive
|  |                | Wait Until Page Contains Element  | xpath=//span[contains(text(), "Lisää")]
|  |                | Click Element                     | xpath=//span[contains(text(), "Lisää")] 
|  |                | Wait Until Page Contains Element  | xpath=//span[contains(text(), "Poista")] 
|  |                | Wait Until Element is Enabled     | class=close 
|  |                | Click Button                      | class=close 
|  |  END

Open shoppinglist
    Click Element                      //*[@id="topmenu-shoppinglist"]/a

Close
    Close Browser
