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
5. `migration-perfil-e-vinculos.sql` — atualiza `contas` (nome e sexo), `posts` e `companies` para usar clientes cadastrados como responsáveis; preserva registros existentes.

Se as tabelas já existem, os scripts foram escritos para preservar os registros; `migration-compras.sql` é idempotente. Não execute `schema.sql` nem scripts de dados em um ambiente que não tenha backup.

## Configuração do banco e login
A conexão MySQL continua configurável por `CRUD_DB_URL`, `CRUD_DB_USER` e `CRUD_DB_PASSWORD`. Não são variáveis de LOGIN: servem só para conectar ao banco. Se não forem definidas, o projeto usa `jdbc:mysql://localhost:3306/crud_manager`, usuário `root` e senha vazia.

**Administrador temporário local:** entre em `http://localhost:8080/NOME-DA-APLICACAO/login` usando **usuário `admin` e senha `admin`**. Não é necessário configurar `CRUD_LOGIN` ou `CRUD_PASSWORD_HASH`. O projeto cria a tabela `administradores` e gera a primeira conta automaticamente no MySQL (se o usuário do banco tiver permissão de criação), sempre que o primeiro acesso for feito pelo `localhost`.

Ao entrar pela primeira vez, a aplicação exige **trocar a senha** (mínimo 12 caracteres). A senha nova fica armazenada no banco com PBKDF2; `admin/admin` deixa de funcionar. Por segurança, a senha temporária é aceita apenas de `127.0.0.1` / `::1`, não pela rede ou internet. Se a tabela já existe, as credenciais NÃO são redefinidas. Se a conexão ou permissão MySQL falhar, o login exibe mensagem explicativa.

O login agora apresenta uma tela gamer responsiva com visual próprio e cenário de Cyberpunk 2077. A imagem em alta definição é carregada online, com capa local de reserva.

Use Tomcat com Jakarta Servlet 5+, Java 17+ e as bibliotecas presentes em `WEB-INF/lib`. Não disponibilize a aplicação publicamente com senhas de teste.

## Caminhos
- `/login` / `/register`: autenticação e cadastro.
- `/catalogo`: catálogo com pesquisa, filtros e formulário de compra.
- `/minhas-compras`: pedidos da conta do cliente.
- `/dashboard`: painel administrativo, com total de clientes.
- `/users` e `/clientes`: lista para administradores com as contas da tabela `contas`, incluindo nome, sexo, e-mail, pesquisa e paginação. Não exibe senhas nem hashes.
- `/usuarios-internos`: CRUD de responsáveis antigos, preservado para a chave estrangeira de Jogos.
- `/jogos`, `/vendas`, `/companies`, `/posts`: cadastros exclusivos do administrador.

### Clientes x usuários internos
O cadastro da loja (`/register`) pede **nome, sexo, e-mail e senha**, salvando tudo na tabela `contas` (a senha apenas como hash). No painel administrativo, **Usuários** (`/users`) mostra estas contas, inclusive com nome e sexo. O endereço antigo `/clientes` continua funcionando.

**Posts e Empresas** agora usam um `<select>` dinâmico dessas contas da loja. O novo vínculo é `conta_id`, uma chave estrangeira para `contas.id`. Os vínculos antigos em `user_id` são mantidos para exibir registros existentes; ao editar um registro antigo, escolha uma conta da loja para converter o vínculo. O CRUD original da tabela `users` continua separado em **Responsáveis dos jogos** (`/usuarios-internos`), pois `jogos.usuario_id` depende dele.

**Atualização do banco:** a aplicação tenta criar as colunas/chaves ausentes automaticamente quando acessa os cadastros, se o usuário MySQL tiver permissão de `ALTER TABLE`. Caso não tenha, execute `migration-perfil-e-vinculos.sql` no banco correto antes de utilizar o novo cadastro. Este script é reexecutável e não remove registros. Contas antigas continuam válidas, mas nome/sexo delas podem aparecer como "Não informado" até completar o perfil.

O botão **Comprar** registra um pedido com status `PENDENTE`, não faz cobrança real e não entrega licença digital. O administrador pode editar o pedido para `PAGO` ou `CANCELADO` na página de Vendas.

Os jogos adicionais usam imagens do CDN público da Steam como fallback. É necessária conexão à internet para que essas capas sejam exibidas.

## Teste manual
1. Acessar `/login` pelo localhost e entrar com `admin/admin`; definir senha nova e confirmar abertura do dashboard.
2. Criar conta de cliente e entrar.
3. Comprar um jogo e confirmar que aparece em Minhas compras como PENDENTE.
4. Entrar como administrador, abrir Vendas e mudar o status para PAGO.
5. Entrar novamente como cliente e confirmar status atualizado.
6. Confirmar CRUDs e paginação em todas as listagens.

**Nota:** o banco de dados e a aplicação precisam estar rodando. As tabelas principais e os jogos ainda dependem dos scripts SQL da seção anterior. A tabela `administradores` pode ser criada automaticamente pelo login inicial local, sem exigir script específico. Uma atualização no GitHub não atualiza automaticamente a cópia já implantada no servidor.
