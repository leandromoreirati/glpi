![alt tag](https://glpi-project.org/wp-content/uploads/2017/03/logo-glpi-bleu-1.png)

O GLPI é uma ferramenta de software ITSM gratuita e de código aberto incrível que ajuda você a planejar e gerenciar mudanças de TI de maneira fácil, resolver problemas eficientemente quando eles surgirem e permitir que você tenha controle legítimo sobre o orçamento de TI e despesas da empresa.

Nesse repostorio disponibilizo a instalação do GLPI em um container docker, assim como a instalação de alguns plugins.

# PLUGINS
 ° Fusioninventory\
 ° Behaviors\
 ° Dashboard\
 ° Data Injection\
 ° Escalade\
 ° Form Creator\
 ° Tag\
 ° Modifications.

Todos os plugins presentes foram desenvolvidos pela comunidade do GLPI e podem ser baixados no link abaixo:
  https://plugins.glpi-project.org/#/ 

# NOTAS DE VERSÃO
 ° Versão 1.0 - 15/07/2018 ==> Criação do Dockerfile e do Docker composse.\
 ° Versão 1.1 - 30/08/2018 ==> Atualizacao da versão do Zabbix Server.\
 ° Versão 1.2 - 05/10/2018 ==> Configuração da idioma Portugues.\
 ° Versão 1.3 - 21/10/2018 ==> Adição plugin behaviors.\
 ° Versão 1.4 - 16/11/2018 ==> Criação do aquivo README.md e adição dos plugins TAG e Modifications.

# PRÉ-REQUISITO
Os pre-requisitos necessários para execução da stack de serviço:
 1) Docker Instalado e configurado.
 2) Docker Swarm configurado.
 3) Mysql instalado e configurado.

# INSTALANDO E CONFIGURANDO DOCKER
 curl -fsSL https://get.docker.com | bash

# INSTALANDO DOCKER SWARM
 docker swarm init --advertise-addr  <IP_DO_SERVIDOR>

 Onde:\
 <IP_DO_SERVIDOR> deve ser substituído pelo ip do seu servidor.

# BAIXANDO AS IMAGENS
 docker pull leandromoreirajfa/zabbix-web:1.2
                                                 
# INSTACAO DO MYSQL
  A instalacao do Mysql pode sem encontrada no link abaixo:
  https://blog.remontti.com.br/2054

# CRIANDO BANCO DE DADOS DO GLPI
  1) Criar database
     CREATE DATABASE glpi;
		
  2) Criar usuário e senha no mysql
     CREATE USER 'glpi'@'localhost' IDENTIFIED BY '<SENHA_DO_USUARIO>';
	
  3) Dar permissão no usuário para uma database
     GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost' IDENTIFIED BY '<SENHA_DO_USUARIO>' WITH GRANT OPTION;
	
  4) Recarregar os privilégios
     Flush privileges;

# CONFIGURANDO SERVIÇO GLPI
Para configurar o serviço do Zabbix Server, editar o arquivo server.config que localiza-se no diretório configs, alterando as variáveis:

MYSQL_HOST=<IP_DATABASE_GLPI>
GLPI_USER=<USUARIO_DATABASE_GLPI>
GLPI_PASS=<PASSWORD_USUARIO_GLPI>
GLPI_DB=<DATABASE_GLPI>
APACHE_VHOST=<FDQN_VIRTUAL_HOST_APACHE>\
APACHE_SRV_ADMIN=<EMAIIL_SERVER_ADMIN>\
TZ=America/Sao_Paulo\
CERT_FILE=<NOME_ARQUIVO_CERTIFICADO>\
CERT_KEY=<NOME_ARQUIVO_KEY>

# INICIANDO O SERVICO
 docker stack deploy -c docker-compose.yml glpi
