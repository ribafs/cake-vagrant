## Executar comandos em php com script após o update
```php
{
    "name": "ribafs/teste",
    "description": "Teste",
    "license": "MIT",
    "authors": [
        {
            "name": "Ribamar FS",
            "email": "ribafs@gmail.com"
        }
    ],
    "require": {},
    "scripts": {
      "post-update-cmd": "php t.php"
    }
}
```
## Veja outras opções:

Composer fires the following named events during its execution process:
Command Events#
```php
    pre-install-cmd: occurs before the install command is executed with a lock file present.
    post-install-cmd: occurs after the install command has been executed with a lock file present.
    pre-update-cmd: occurs before the update command is executed, or before the install command is executed without a lock file present.
    post-update-cmd: occurs after the update command has been executed, or after the install command has been executed without a lock file present.
    post-status-cmd: occurs after the status command has been executed.
    pre-archive-cmd: occurs before the archive command is executed.
    post-archive-cmd: occurs after the archive command has been executed.
    pre-autoload-dump: occurs before the autoloader is dumped, either during install/update, or via the dump-autoload command.
    post-autoload-dump: occurs after the autoloader has been dumped, either during install/update, or via the dump-autoload command.
    post-root-package-install: occurs after the root package has been installed, during the create-project command.
    post-create-project-cmd: occurs after the create-project command has been executed.
```
### No plugin ribafs/admin-br eu usei no post-upload-dump, que apenas executa o composer.json:
```php
    "scripts": {
      "post-autoload-dump": "php copiar.php"
} 
```
Este é o arquivo copiar.php:
```php
<?php
    copy ( 'copiar/AppController.php' , '../../../src/Controller/AppController.php');
    copy ( 'copiar/bootstrap_cli.php' , '../../../config/bootstrap_cli.php');
?>
```
## Muito mais em:
https://getcomposer.org/doc/articles/scripts.md


