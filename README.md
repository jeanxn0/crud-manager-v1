# GameStore — CRUD Manager

Aplicação acadêmica Java Servlets/JSP + MySQL, com catálogo de jogos, login para clientes e painel do administrador.

## Requisitos da avaliação
- **CRUD 1: Jogos** — título (text), descrição (textarea), lançamento (date), preço (number) e responsável (select baseado em `users`, chave estrangeira).
- **CRUD 2: Vendas** — jogo (select baseado em `jogos`, chave estrangeira), quantidade (text com pattern numérico), valor total (number), data/hora (datetime-local) e pagamento (radio).
- Ambos oferecem listagem, cadastro, edição, exclusão e paginação; seus DAOs estão no `DAOFactory`.
- Os cadastros originais de usuários, empresas e posts permanecem paginados.
- Login e cadastro de clientes com hash de senha PBKDF2, filtro de autorização e proteção CSRF.

## Preparar banco de dados
No MySQL, execute **nesta ordem**:
1. `schema.sql` — cria tabelas originais e novas.
2. `catalogo-demo.sql` — povoa 42 jogos com capas locais.
3. `migration-compras.sql` — vincula pedidos de clientes à tabela `contas`.
4. `mais-jogos.sql` — insere 28 jogos adicionais, totalizando até 70 títulos sem duplicar os existentes.

Se as tabelas já existem, os scripts foram escritos para preservar os registros; `migration-compras.sql` é idempotente. Não execute `schema.sql` nem scripts de dados em um ambiente que não tenha backup.

## Configuração
Configure variáveis de ambiente antes de iniciar o Tomcat:
- `CRUD_DB_URL`: JDBC URL MySQL no formato `jdbc:mysql://HOST:PORTA/crud_manager?sslMode=REQUIRED`
- `CRUD_DB_USER` e `CRUD_DB_PASSWORD`: credenciais do MySQL
- `CRUD_LOGIN`: nome de usuário administrador
- `CRUD_PASSWORD_HASH`: hash PBKDF2 do administrador, no formato `base64(salt):base64(chave)` (600000 iterações PBKDF2WithHmacSHA256, salt de 16 bytes e chave de 32 bytes).

Não salve senhas diretamente no repositório. Use Tomcat com Jakarta Servlet 5, Java 17+ e o conector MySQL/JSTL incluídos em `WEB-INF/lib`.

## Caminhos
- `/login` / `/register`: autenticação e cadastro.
- `/catalogo`: catálogo com pesquisa, filtros e formulário de compra.
- `/minhas-compras`: pedidos da conta do cliente.
- `/dashboard`: painel administrativo.
- `/jogos`, `/vendas`, `/users`, `/companies`, `/posts`: cadastros exclusivos do administrador.

O botão **Comprar** registra um pedido com status `PENDENTE`, não faz cobrança real e não entrega licença digital. O administrador pode editar o pedido para `PAGO` ou `CANCELADO` na página de Vendas.

Os jogos adicionais usam imagens do CDN público da Steam como fallback. É necessária conexão à internet para que essas capas sejam exibidas.

## Teste manual
1. Criar conta de cliente e entrar.
2. Comprar um jogo e confirmar que aparece em Minhas compras como PENDENTE.
3. Entrar como administrador, abrir Vendas e mudar o status para PAGO.
4. Entrar novamente como cliente e confirmar status atualizado.
5. Confirmar CRUDs e paginação em todas as listagens.

**Nota:** o banco de dados e o Tomcat precisam estar rodando; os scripts SQL não são executados automaticamente ao alterar o GitHub.
