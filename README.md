# Loja de Games

Projeto Java Web da Avaliação 2, baseado no CRUD Manager. Usa Java 21, Tomcat 11, JSP/JSTL e MySQL 8.

## Executar no Eclipse

1. Execute `schema.sql` no MySQL Workbench.
2. Importe a pasta como **Existing Projects into Workspace** e associe o runtime Tomcat 11.
3. Nas configurações de execução do Tomcat (**Environment**), defina as variáveis abaixo.
4. Inicie o servidor e abra `http://localhost:8080/crud-manager/` (ajuste conforme o contexto publicado no Eclipse).
5. Entre, cadastre um usuário responsável, cadastre um jogo e registre uma venda.

| Variável | Valor |
|---|---|
| `CRUD_DB_URL` | `jdbc:mysql://localhost:3306/crud_manager` |
| `CRUD_DB_USER` | Usuário do MySQL |
| `CRUD_DB_PASSWORD` | Senha do MySQL |
| `CRUD_LOGIN` | Nome escolhido para o administrador |
| `CRUD_PASSWORD_HASH` | Hash gerado pelo comando abaixo |

O administrador é configurado no servidor. Os usuários cadastrados pela aplicação são os responsáveis selecionáveis no formulário de Jogos.

Com Python instalado, execute no terminal para gerar o hash da senha do administrador. A senha é digitada sem aparecer na tela. Copie a saída para `CRUD_PASSWORD_HASH`.

```sh
python -c "import base64,getpass,hashlib,secrets; s=secrets.token_bytes(16); p=getpass.getpass('Senha: '); h=hashlib.pbkdf2_hmac('sha256',p.encode(),s,600000); print(base64.b64encode(s).decode()+':'+base64.b64encode(h).decode())"
```

As listagens exibem até dez registros por página. Jogos com vendas vinculadas só podem ser excluídos após a remoção dessas vendas.

## Catálogo e contas

Execute também `catalogo-demo.sql` depois de `schema.sql` para inserir os 42 jogos de demonstração com capas locais da Steam. Os preços são ilustrativos. A vitrine pública fica em `/catalogo` e oferece busca por título e filtro por plataforma.

A página `/register` cadastra clientes por e-mail. Clientes autenticados voltam ao catálogo. A conta administrativa configurada no Tomcat continua acessando os CRUDs.
