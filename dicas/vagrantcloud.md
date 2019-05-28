## Dicas para enviar box para a nuvem

A forma mais simples de enviar uma box para o Vagrantup é logando no site, criando uma nova box e enviando o arquivo exportado:

### Efetuar login em
https://app.vagrantup.com/session

Após o login clicar em New Vagrant Box

Name - ribafs/teste

Short - description - Digitar uma descrição breve para a box

Clicar em Create box

Version - 1.0

Description - Agora a descrição definitiva e completa. Uma boa ideia é inserir um link de repositório criado no GitHub para a box.

Clicar em Create version

Clicar abaixo em Add a provider

Provider - virtualbox

File hosting - Upload to Vagrant Cloud

Clicar em Continue to upload

Abaixo clicar em Browser e indicar a box exportada

Após enviar deve voltar e efetuar o Release da versão atual da box clicando no Botão Release. Enquanto não fizer isso não poderá instalar sua box pela linha de comando, mesmo que ela apareça na busca do Vagrant.

## Enviando a box pelo terminal/prompt do seu desktop
```php
vagrant cloud auth login
vagrant cloud box create ribafs/cake-vagrant
```
Mostrar existentes

vagrant cloud box show ribafs/cake-vagrant

Publicar uma box no Vagrant Cloud

Estando no diretório do cake-vagrant.box
```php
vagrant cloud box update ribafs/cake-vagrant
vagrant cloud provider upload ribafs/cake-vagrant virtualbox 1.0.0 cake-vagrant.box
```
Criar versão

vagrant cloud version create ORGANIZATION/BOX-NAME VERSION

Excluir versão

vagrant cloud version delete ORGANIZATION/BOX-NAME VERSION


