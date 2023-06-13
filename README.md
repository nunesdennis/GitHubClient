# GitHubClient

## O Desafio 
O desafio consiste na implementação de uma aplicação iOS que deverá consumir a API pública do Github, que disponibiliza informações sobre os usuários e seus repositórios, onde o aplicativo deverá permitir a listagem de usuários, busca de usuário por nome de usuário e visualização das informações de um usuário específico, bem como a listagem de seus repositórios. 

## Descrição 
A aplicação deverá consumir um serviço para realizar tais operações. Segue a URL da API: 

https://api.github.com 

● Para listar os usuários, a aplicação deverá consumir o seguinte endereço: 

https://api.github.com/users 

Este endereço lista apenas alguns usuários. Isto pode servir como uma massa de dados para a tela de listagem dos usuários da aplicação. 

● Para obter informações específicas de um usuário, basta acessar o seguinte endereço: 

https://api.github.com/users/torvalds 

● Para listar os repositórios de um usuário específico, a aplicação deverá acessar o seguinte endereço: 

https://api.github.com/users/torvalds/repos 

● Para obter mais informações sobre a API: 

https://developer.github.com/v3/ 

## Dicas 
• É sempre bom avisar ao usuário quando uma operação está em andamento. 
• A API pode retornar erros, por isso pense em como apresentar isso ao usuário. 
• Faça testes automatizados. 
• Explore a API antes de começar qualquer coisa. 
• Tire um tempo para entender tudo e faça um planejamento. Um bom projeto é fruto de um bom planejamento 
