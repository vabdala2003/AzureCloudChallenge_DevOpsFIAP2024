# Clonagem do Repositório
# Clone o repositório usando o seguinte comando:
  git clone https://github.com/vabdala2003/AzureCloudChallenge_DevOpsFIAP2024.git
  Acompanhe a criação dos WebApps conforme descrito no vídeo de instruções.

# Criação do Ambiente
# Criar Grupo de Recursos
az group create --name AppResourcesChallenge --location eastus

# Criar Plano de Serviço
az appservice plan create --name AppPlanJarvis --resource-group AppResourcesChallenge --sku B1 --is-linux

# Criar WebApp Java
Acesse "Serviços de Aplicativos" e clique em "Criar".
Selecione "Aplicativo Web" e utilize a inscrição existente.
Utilize o grupo de recursos já criado.
Nomeie o aplicativo e selecione o runtime Java 11.
Escolha "Windows" como sistema operacional e "Brazil South" como região.
Na seção de implantação, habilite a autenticação básica.
Revise as configurações e clique em "Criar". Aguarde a conclusão do processo.

# Criar WebApp Python
az webapp create --resource-group AppResourcesChallenge --plan AppPlanJarvis --name PyAIJarvis --runtime "PYTHON:3.12"

# Criar Servidor e Banco de Dados Azure
# Criar Servidor SQL:
az sql server create --name sqlserverjarvis-westus --resource-group AppResourcesChallenge --location westus --admin-user adminuser --admin-password Fiap@987!
# Criar Banco de Dados SQL:
az sql db create --resource-group AppResourcesChallenge --server sqlserverjarvis-westus --name bdjarvischallenge --service-objective S0

# Deploys
# Deploy Java
Acesse o aplicativo Java no portal do Azure e vá para "Configurações Avançadas".
Acesse o console e execute cd site/wwwroot.
Faça o upload do arquivo .jar da pasta clonada anteriormente na interface do Kudu. Aguarde a conclusão do upload.

# Deploy da AI em Python
az webapp deploy --resource-group AppResourcesChallenge --name PyAIJarvis --src-path AppsDeploy/AI_Python/python_ai.zip --type zip

# Deploy SQL (script.sql)
# Execute o comando:
sqlcmd -S tcp:sqlserverjarvis-westus.database.windows.net,1433 -d bdjarvischallenge -U adminuser -P Fiap@987! -i AppsDeploy/DDL_SQL/script.sql
# Se ocorrer um erro, siga os próximos passos:
  Adicione a regra de firewall:
  az sql server firewall-rule create --resource-group AppResourcesChallenge --server sqlserverjarvis-westus --name AllowLocalIP --start-ip-address (ip mostrado no comando anterior) --end-ip-address (ip mostrado no comando anterior)

Reexecute o script SQL:
sqlcmd -S tcp:sqlserverjarvis-westus.database.windows.net,1433 -d bdjarvischallenge -U adminuser -P Fiap@987! -i AppsDeploy/DDL_SQL/script.sql

# Verifique as tabelas:
sqlcmd -S tcp:sqlserverjarvis-westus.database.windows.net,1433 -d bdjarvischallenge -U adminuser -P Fiap@987! -Q "SELECT * FROM INFORMATION_SCHEMA.TABLES"
Instale o SQL Server se necessário.

# Testes
Teste a API localmente usando o Insomnia, não esqueça de rodar a api na IDE de preferência:

Cadastro de Cliente
POST: http://localhost:8080/cliente/register
{
  "nome": "Lucas Oliveira",
  "cpf": "12345678901",
  "rg": "987654321",
  "dataNascimento": "1990-03-15",
  "senha": "senha4"
}
Login para Obter Token
POST: http://localhost:8080/login
{
  "email": "email_do_login",
  "password": "senha_do_login"
}
Após o login, copie o token retornado e utilize-o como autenticação nas próximas requisições (Método: Bearer Token, Valor: Token).
Criar Pagamento
POST: http://localhost:8080/produto/{id_do_cliente}/pagamento
{
  "nome": "KARINA RODRIGUES",
  "numero": 52994129913495,
  "descricao": "CREDITO DIVIDIDO EM 2X",
  "data": "2024-04-11"
}
Listar Clientes
GET: http://localhost:8080/cliente
Cadastro de Telefone
POST: http://localhost:8080/cliente/{Id_Cliente}/telefone
{
  "numeroTelefone": "STRING",
  "ddd": "STRING",
  "operadora": "STRING"
}
Atualizar Telefone
PUT: http://localhost:8080/telefone/{ID}
{
  "numeroTelefone": "STRING",
  "ddd": "STRING",
  "operadora": "STRING"
}
Deletar Telefone
DELETE: http://localhost:8080/telefone/{ID}
