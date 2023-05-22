# InferiorGold_infra

# Ansible-2

## Один плейбук, один сценарий
1. Создаем плейбук для управления конфигурации и деплоя нашего приложения - reddit_app.yml -> reddit_app_one_play.yml
Добавляем сценарии для управления конфигурации хостов.
Сценарий для MongoDB из шаблона, делаем пробные прогоны.
Определяем переменные, добавляем Handlers, применяем плейбук.

2. Настраиваем инстанс приложения
Копируем Unit файл для сервиса puma.
Добавляем шаблон для приложения.

3. Делаем деплой приложения.
Добавляем еще несколько тасков в сценарий плейбука.
Используем модули git и bundle для клонирования последней версии кода нашего приложения и установки зависимых Ruby Gems через bundle

## Один плейбук несколько сценариев.
Разобъем один сценарий на несколько сценариев, сценарий для MongoDB и сценарий для App
Пересоздадим инфраструктуру окружения stage и проверим работу сценариев.
Создаем сценарий для деплоя reddit_app2.yml -> reddit_app_multiple_plays.yml

## Несколько плейбуков.
Создаем три плейбука app.yml (сценарий настройки хоста), db.yml (сценарий настройки БД), deploy.yml(сценарий деплоя). Создадим плейбук site.yml в котором опишем управление конфигурацией всей нашей инфраструктуры. Проверяем.

## Провижинг в Packer. Изменяем provision в Packer и заменим bash-скрипты на Ansible плейбуки. Создаем два плейбука: packer_app.yml

Проверяем блид образов с использованием новых провижионеров. На их основе запускаем stage окружение и проверяем запуск плейбука site.yml конфигурирование и деплой приложения.




# Ansible-1
```
Выполните ansible  app  -m  command  -a  'rm  -rf  ~/reddit'
и проверьте еще раз выполнение плейбука. Что изменилось и почему?
```
Команда удалит директорию и вложенные файлы репозитория приложения. После запуска ansible-playbook clone.yaml репозиторий будет заново клонирован, но ruby выдаст ошибку c диагностическими данными
Для задания со * используем [готовый скрипт](https://gist.github.com/tuxfight3r/2c027f8fd70333a8288e) для динамического инвентори на bash и копируем в наш **inventory.json**


# Terraform 2
##Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform

Создал ветку terraform-2
Выполнил сборку образов для разных VM с созданием шаблона db.json и app.json
Сделал разбитие конфигурации по файлам согласно ТЗ.
Разбил файлы на модули.
Для использование модулей загружаем их из указанного источника (source) коммандой terraform get
Создал директории stage и prod. Скопировал файлы в каждую из директорий.
Проверил конфигурацию
Выполнил самостоятельные задания со * и ** . Создал файл backend.tf в каждой из директории stage/prod. Выполнил команды terraform init / terraform apply и добавил необходимые provisioner модули для деплоя и работы приложения
```
terraform {
backend "s3" {
endpoint   = "storage.yandexcloud.net"
bucket     = "backet-otus"
region     = "ru-central1"
key        = "terraform.tfstate"
access_key = ""
secret_key = ""

skip_region_validation      = true
skip_credentials_validation = true
}
}
```


# Terraform 1
Установил Terraform
Создал дирректорию
Создал сервисный аккаунт
Описал создание инстанса с помощью Terraform в main.tf
## Самостоятельные задания
  ## 1. Определите input переменную для приватного ключа,использующегося в определении подключения для провижинеров (connection)
    Переменная была добавлена в terraform.tfvars и добавлено описание в variables.tf
 ## 2.Определите input переменную для задания зоны в ресурсе "yandex_compute_instance" "app". У нее должно быть значение по умолчанию 
     Переменная была добавлена в terraform.tfvars и добавлено описание в variables.tf
## 3. Создан файл terraform.tfvars.example
## Задание со **
   Создан файл lb.tf с описанием когда балансировщика, направляющего трафик на reddit-app
## Задание со **
  Удалил описание reddit-app2 и задал
  количество инстансов через параметр ресурса count.
  Добавил новую переменную count_app
  Добавил динамическую группу в lb.tf 



# Packer
Создать ветку packer-base

Перенести файлы предыдущего ДЗ в configscripts

Установил Packer на локальную машину

Создал сервисный аккаунт, делегировал права аккаунту для Packer

Создал шаблон описания образа VM с предустановленным Ruby и MongoDB

Сбилдил образ с приложением внутри

## Параметризировал созданный шаблон

```
домен VPN сервера https://otus.i4all.ru/login
bastion_IP = 158.160.40.222
someinternalhost_IP = 10.128.0.29
```

Команда для подключения с локальной машины к витруальной машине someinternalhost, через виртуальную машину bastion:

```
ssh -o ProxyCommand="ssh -W %h:%p bastion" someinternalhost
```

## Дополнительное задание:
На рабочей станции, где вы хотите инициировать SSH-соединение, откройте файл конфигурации клиента OpenSSH ( ~/.ssh/config) с помощью выбранного вами текстового редактора и добавьте следующий код:

```
Host bastion
        HostName 158.160.40.222
        User vvakhitov
        IdentityFile ~/.ssh/id_rsa

Host someinternalhost
        HostName 10.128.0.29
        User vvakhitov
        ProxyCommand ssh -W %h:%p bastion
```

ProxyCommand: указывает команду, используемую в качестве прокси для доступа к someinternalhost. Эта конфигурация указывает, что соединение SSH должно сначала подключиться к bastionхосту, а затем использовать ncкоманду для переадресации соединения на someinternalhostпорт 22. %h— это заполнитель, который будет заменен фактическим именем хоста someinternalhost

```
Host bastion
    User vvakhitov
    Hostname 158.160.40.222

Host someinternalhost
    User vvakhitov
    Hostname 10.128.0.29
    ProxyJump bastion
```

Так же, но с ипользованием ProxyJump


Теперь мы можем просто использовать имя хоста someinternalhost без проблем с настройкой маршрута перехода каждый раз, когда вы обращаетесь к someinternalhost.

```
$ ssh someinternalhost
```


P.s: источники
```
https://itsecforu.ru/2020/12/04/%F0%9F%90%A7-4-%D1%81%D0%BF%D0%BE%D1%81%D0%BE%D0%B1%D0%B0-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BA-ssh-%D0%B8-scp-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-%D0%BF%D1%80%D0%BE/
и
https://goteleport.com/blog/ssh-proxyjump-ssh-proxycommand/
```
##  Облачное тестовое приложение:

Создаем новый инстанс
Создаем виртуальную машину через yc CLI:

```

yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--core-fraction=5 --memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=infra,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--ssh-key ~/.ssh/appuser.pub

```

Проверяем подключение
```
ssh yc-user@158.160.33.140
```

Запускайте скрипты вручную или из файлов, чтобы установить зависимости и запустить приложение Reddit: install_ruby.sh, install_mongodb.sh, deploy.sh
Чтобы скопировать файлы скриптов на сервер, выполните следующие команды:

```
scp install_ruby.sh yc-user@158.160.33.140:/home/yc-user/install_ruby.sh
scp install_mongodb.sh yc-user@158.160.33.140:/home/yc-user/install_mongodb.sh
scp deploy.sh yc-user@158.160.33.140:/home/yc-user/deploy.sh
```

## Создайте и настройте сервер автоматически с помощью сценария конфигурации cloud-init.
Создайте сервер с помощью скрипта конфигурации запуска:
```
yc compute instance create \
--name reddit-app \
--hostname reddit-app \
--core-fraction=5 --memory=4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
--network-interface subnet-name=infra,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--metadata-from-file user-data=startup.yaml
```

```
testapp_IP = 158.160.33.140
testapp_port = 9292
```
