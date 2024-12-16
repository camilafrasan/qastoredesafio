*** Settings ***
Library  SeleniumLibrary

*** Test Cases ***
Cenário 1: Efetivar pedido com produto aplicando desconto FRETEGRATIS para produtos até R$ 100
    [Tags]    regressivo    comdesconto
    Acessar o endereço da loja
    Given que os itens foram incluídos de acordo com o produto
    And foi aplicado o desconto válido FRETEGRATIS
    When o cupom for aplicado
    Then é exibido o valor do frete zerado

Cenário 2: Efetivar pedido com produto sem aplicar desconto
    [Tags]    regressivo    semdesconto
    Acessar o endereço da loja
    Given que os itens foram incluídos de acordo com o produto
    When o usuário finalizar a compra
    Then é exibido o valor original junto ao frete sem aplicação de descontos

*** Keywords ***
Acessar o endereço da loja
    Open Browser  https://qastoredesafio.lojaintegrada.com.br  chrome

que os itens foram incluídos de acordo com o produto
    Click Element    xpath=//*[@id="google-fashion"]/body/div[2]/header/div/div/div[1]/div/ul/li[2]/a/strong
    Wait Until Element Is Visible    xpath=//*[@id="Componente_22_3"]
    Sleep    10s
    Click Element    xpath=//*[@id="listagemProdutos"]/ul/li/ul/li[1]/div/div[3]/a[2]

foi aplicado o desconto válido FRETEGRATIS
    Input Text    xpath=//*[@id="usarCupom"]    FRETEGRATIS

o cupom for aplicado
    Click Button    xpath=//*[@id="carrinho-mini"]/table[2]/tbody/tr[2]/td/form/div/div/div/button

é exibido o valor do frete zerado
    Page Should Contain    Frete Grátis

o usuário finalizar a compra
    Click Button    xpath=//*[@id="corpo"]/div/div[1]/div/form/div/div[1]/button

é exibido o valor original junto ao frete sem aplicação de descontos
    ${subtotal}=    Set Variable    xpath=//*[@id="corpo"]/div/div[1]/div/div[2]/table/tbody/tr[3]/td[2]/div/strong
    ${total}=    Set Variable    xpath=//*[@id="corpo"]/div/div[1]/div/div[2]/table/tbody/tr[6]/td/div[1]/strong
    Should Be True    ${subtotal} = ${total}
