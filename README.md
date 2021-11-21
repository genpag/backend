# Considerações:

Muito obrigado por esta oportunidade de ter realizado este teste, desde já afirmo que foi desafiador e estusiasmante realizar-lo.

# Sobre o teste:

- Eu alterei o usuário e senha do postgres para que funcionasse no meu ambiente que já estava montado previamente.
- Consegui cumprir com os requisitos que foram listados no teste.
- Removi algumas coisas que vejo como desnecessárias para uma API(Claro que o ideal seria criar um projeto com as clausulas: --no-html, --no-assets)
- Acabei aprendendo algumas coisas novas.

# Estrutura dos endpoints:

### 1. Criação de uma conta(account):
> Para criar uma conta submeta uma requsição do tipo POST com uma estrutura parecida com a seguir:
```
--Exemplo de URL: http://localhost:4000/api/accounts/

{
 "account": { --Obrigatório
  "name": "José da Silva Sauro", --Obrigatório
  "cpf": "99999999999", --Obrigatório
  "address": { --Obrigatório
   "state": "GO", --Opicional se ´postal_code´ for válido e retornar a informação
   "city": "Goiânia", --Opicional se ´postal_code´ for válido e retornar a informação
   "neighborhood": "Campinas", --Opicional se ´postal_code´ for válido e retornar a informação
   "postal_code": "74503111", --Obrigatório
   "street": "74503111", --Opicional se ´postal_code´ for válido e retornar a informação
   "complement": "de 8683 a 9435 - lado ímpar", --Opicional
   "number": 123 --Opicional
  }
 }
}
```
> Atente-se que:
- ***cpf*** é único.
- será feita uma busca no *https://viacep.com.br/* usando o ***postal_code*** que irá preencher informações que faltam menos o ***number***.
- sempre retornará as informações da conta criada contendo o ***id***.

### 2. Amostragem de uma conta(account):
> Para consultar uma conta submeta uma requsição do tipo GET:
```
--Exemplo de URL: http://localhost:4000/api/accounts/:id
```

> Atente-se que:
- sempre retornará as informações da conta cadastrada contendo o ***id*** caso a mesma exista.
- estrutura parecida com o exemplo de criação.

### 3. Alteração de uma conta(account):
> Para alterar uma conta submeta uma requsição do tipo PUT com uma estrutura parecida com a seguir:
```
--Exemplo de URL: http://localhost:4000/api/accounts/:id

{
 "account": { --Obrigatório
  "name": "José da Silva Sauro", --Opcional
  "address": { --Opcional
   "state": "GO", --Opicional
   "city": "Goiânia", --Opicional
   "neighborhood": "Campinas", --Opicional
   "postal_code": "74503111", --Opcional
   "street": "74503111", --Opicional
   "complement": "de 8683 a 9435 - lado ímpar", --Opicional
   "number": 123 --Opicional
  }
 }
}
```
> Atente-se que:
- ***cpf*** não pode ser alterado(retornará erro caso seja feita a tentativa de alteração).
- será feita uma busca no *https://viacep.com.br/* usando o ***postal_code*** que irá alterar informações que faltam menos o ***number***.
- sempre retornará as informações da conta alterada contendo o ***id***.

### 4. Deleçao de uma conta(account):
> Para deletar uma conta submeta uma requsição do tipo DELETE:
```
--Exemplo de URL: http://localhost:4000/api/accounts/:id
```
> Atente-se que:
- sempre retornará as informações da conta deletada contendo o ***id*** caso a mesma exista.

### 5. Listagem de uma conta com/sem limit e/ou offset:
> Para listar as contas submeta uma requsição do tipo GET:
```
--Exemplos de URL: 
--http://localhost:4000/api/accounts/
--http://localhost:4000/api/accounts?limit=50&offset=10
--http://localhost:4000/api/accounts?limit=50
--http://localhost:4000/api/accounts?offset=10
```
> Atente-se que:
- sempre retornará uma lista contendo as informações das contas cadastradas contendo o ***id***.
- parametro ***limit*** representa a quantidade que deve ser retornada e é opcional.
- parametro ***offset*** representa a partir de qual ***account*** deve ser retornado e é opcional.
