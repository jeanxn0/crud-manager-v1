# Loja de Games

Projeto Java Web da Avaliação 2, baseado no CRUD Manager. Usa Java 21, Tomcat 11, JSP/JSTL e MySQL 8.

## Executar no Eclipse

1. No MySQL Workbench, execute `schema.sql` e depois `catalogo-demo.sql`. Se já tem o banco da versão anterior, execute os dois scripts atualizados na mesma ordem.
2. Importe a pasta como **Existing Projects into Workspace** e associe o runtime Tomcat 11.
3. Nas configurações de execução do Tomcat (**Environment**), defina as variáveis abaixo.
4. Inicie o servidor e abra `http://localhost:8080/crud-manager/` (ajuste conforme o contexto publicado no Eclipse).
5. Abra `/catalogo` para ver a vitrine ou entre com o administrador para gerenciar Jogos e Vendas.

| Variável | Valor |
|---|---|
| `CRUD_DB_URL` | `jdbc:mysql://localhost:3306/crud_manager` |
| `CRUD_DB_USER` | Usuário do MySQL |
| `CRUD_DB_PASSWORD` | Senha do MySQL |
| `CRUD_LOGIN` | Nome escolhido para o administrador |
| `CRUD_PASSWORD_HASH` | Hash gerado pelo comando abaixo |

As duas últimas variáveis configuram o administrador. O cadastro público em `/register` cria contas de clientes. Os responsáveis pelos jogos são escolhidos no cadastro administrativo de Usuários.

Com Python instalado, execute no terminal para gerar o hash da senha do administrador. A senha é digitada sem aparecer na tela. Copie a saída para `CRUD_PASSWORD_HASH`.

```sh
python -c "import base64,getpass,hashlib,secrets; s=secrets.token_bytes(16); p=getpass.getpass('Senha: '); h=hashlib.pbkdf2_hmac('sha256',p.encode(),s,600000); print(base64.b64encode(s).decode()+':'+base64.b64encode(h).decode())"
```

As listagens exibem até dez registros por página. Jogos com vendas vinculadas só podem ser excluídos após a remoção dessas vendas.

## Catálogo e contas

A vitrine pública em `/catalogo` tem 42 jogos de demonstração com capas locais da Steam e preços ilustrativos. A busca por título pode ser combinada com os filtros PC, PS4, PS5, Xbox One, Xbox Series e Nintendo Switch.

A página `/register` cadastra clientes por e-mail. Clientes autenticados voltam ao catálogo. A conta administrativa configurada no Tomcat continua acessando os CRUDs.


## Avaliação 2

| Requisito | Implementação |
|---|---|
| CRUD de Jogos | Título, descrição, lançamento, preço e responsável selecionado entre os usuários |
| CRUD de Vendas | Jogo selecionado no catálogo, quantidade, valor, data e hora, status do pagamento |
| Estrutura dos CRUDs | Tabelas com chaves estrangeiras, modelos Java, DAOs no `DAOFactory`, Servlets, páginas JSP e links no menu |
| Login | Cadastro de clientes com hash PBKDF2, autenticação por sessão, filtro de acesso e logout |
| Paginação | Até 10 registros por página em Usuários, Empresas, Posts, Jogos e Vendas |

Para demonstrar o projeto, entre como administrador, cadastre um jogo com um usuário responsável e registre uma venda escolhendo esse jogo. Abra uma listagem com mais de 10 registros para mostrar a paginação.
