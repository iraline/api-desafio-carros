
# API-Stellantis

Uma API simples para demonstrar algumas requisições da solução elaborada para o desafio `Desafio Connect Stellantis.`
Com os dados fornecidos pela empresa, foram idealizados alguns métodos que podem ajudar tanto
o público geral como os atuais usuários. A seguir tem as ideias mais destrinchadas.

# Sobre o projeto

*Para o público geral:*

No momento de comprar um carro, muitas pessoas buscam primeiramente por economia e melhor custo benefício.
O consumo de combustível que é informado pelas empresas nem sempre é preciso, pois geralmente
essas medições são realizadas em cenários ideais. A média do consumo pode variar dependendo da
cidade, pois o tráfego e a sinalização delas são distintas. 

Baseado nisso, foi pensado em uma solução onde fosse possível proporcionar
ao público geral informações sobre o consumo médio dos modelos de veículos, sendo possível
filtrar por estado.

Um exemplo simples de aplicação: Inicialmente poderia ser utilizado o valor disponibilizado
pela empresa. Após um certo tempo, quando houvesse uma maior circulação dos veículos
de determinado modelo, a informação na aplicação seria atualizada.

*Para usuários do Uconnect:*

Para quem for cliente e possuir o aplicativo Uconnect, foi idealizada uma
nova feature para os aplicativos. Com a coleta do nível de gasolina, é
possível gerar um histórico de abastecimento do veículo, possibilitando o usuário 
realizar uma melhor gestão de abastecimento.

*API*

Todos os métodos que podem ser utilizados para possibilitar aos usuários
as informações citadas acima, foram desenvolvidos em uma só API. A forma que
deve ser utilizada será informada no tópico _Sobre a API_.

![image](https://user-images.githubusercontent.com/22120173/193704171-a4a6319e-9e91-4692-a973-0280236a07e6.png)

## Configurando o ambiente

Pré-requisitos: 

    - Ruby-3.1.2 
    - Rails 7.0.4

### Rodando localmente

Após realizar o clone do repositório em sua máquina, abra um terminal na
pasta do projeto e insira:

`bundle install`

Após isto basta digitar `rails s` no terminal e pronto, a API já esta rodando.

OBS: Apesar de ter uma estrutura de model e schema no código, não estão sendo
utilizadas. Os dados estão sendo puxados das planilhas fornecidas(Foram editadas
para possuir uma menor quantidade de dados, para facilitar a manipulação) que
estão na pasta `app/assets`

## Sobre a API

Com a API, atualmente, é possível realizar 3 requisições:
```
1 - GET /api/v1/consume_mode
2 - GET /api/v1/consume_state
3 - GET /api/v1/fuel_history
```

Com a API você consegue verificar o *real* consumo médio de um determinado 
modelo de veículo, verificar o *real* consumo médio de um determinado modelo
de veículo em um estado e consegue pegar o histórico de abastecimento de um 
veículo. 

#### 1 - GET /api/v1/consume_mode

Esta requisição é responsável por retornar o consumo médio de um modelo de veículo.

Esta requisição recebe até 3 parâmetros, sendo dois deles obrigatórios.

```
model - Modelo do carro (nome maiusculo)
year - Ano do carro 
year_period [opcional] - De qual ano você quer saber o consumo médio.

Caso year_period não seja preenchido, pegará de todos os anos.
```

Exemplo de requisição e retorno

![image](https://user-images.githubusercontent.com/22120173/193705127-d632f755-228a-4163-90bf-ac3bc3799cb2.png)

#### 2 - GET /api/v1/consume_state

Esta requisição é responsável por retornar o consumo médio de um modelo de veículo em
um estado e ano especifico.

Esta requisição recebe 4 parâmetros obrigatórios.

```
model - Modelo do carro (nome maiusculo)
year - Ano do carro 
state - Nome do estado (Primeira letra maiúscula. Ex: Rio de Janeiro)
year_period - De qual ano você quer saber o consumo médio.
```
Exemplo de requisição e retorno

![image](https://user-images.githubusercontent.com/22120173/193708657-85b4ba0b-b8c3-465c-a903-6678dc427b38.png)

OBS: O código desta requisição não está performático e o _state_ de cada evento
é consultado. Como todos os eventos do ano são consultados, é uma requisição que 
demora.
#### 3 - GET /api/v1/fuel_history

Esta requisição é responsável por retornar o histórico de abastecimento de um veículo
especifico. Ele retorna uma lista com a data/hora do evento e a quantidade combustível
abastecido(aproximado).

Esta requisição recebe 1 parâmetro obrigatório.

```
vin - Vin do veículo
```

Exemplo de requisição e retorno

![image](https://user-images.githubusercontent.com/22120173/193707487-81b1dfe3-d547-4986-b594-4fd9fe383a29.png)


### GIF mostrando o funcionamento da API
![Demonstracao_API](https://user-images.githubusercontent.com/22120173/193710233-e39aeb56-ab1c-4ccf-b83d-d89c6fa3ffd1.gif)

#### Algumas melhorias a serem realizadas
    - Testes, testes e mais testes (rspec)
    - Tratativa de erros
    - Junção dos métodos que envolve consumo médio de gasolina
    - Adaptar a resposta dos métodos para um retorno no formato json
    

