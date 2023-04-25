# InferiorGold_infra

bastion_IP = 158.160.40.222
someinternalhost_IP = 10.128.0.29

Команда для подключения с локальной машины к витруальной машине someinternalhost, через виртуальную машину bastion:

ssh -o ProxyCommand="ssh -W %h:%p vvakhitov@158.160.40.222" vvakhitov@10.128.0.29

Дополнительное задание:
На рабочей станции, где вы хотите инициировать SSH-соединение, откройте файл конфигурации клиента OpenSSH ( ~/.ssh/config) с помощью выбранного вами текстового редактора и добавьте следующий код:


Host bastion
        HostName 158.160.40.222
        User vvakhitov
        IdentityFile ~/.ssh/id_rsa

Host someinternalhost
        HostName 10.128.0.29
        User vvakhitov
        ProxyCommand ssh -W %h:%p bastion


ProxyCommand: указывает команду, используемую в качестве прокси для доступа к someinternalhost. Эта конфигурация указывает, что соединение SSH должно сначала подключиться к bastionхосту, а затем использовать ncкоманду для переадресации соединения на someinternalhostпорт 22. %h— это заполнитель, который будет заменен фактическим именем хоста someinternalhost
Host bastion
    User vvakhitov
    Hostname 158.160.40.222

Host someinternalhost
    User vvakhitov
    Hostname 10.128.0.29
    ProxyJump bastion
Так же, но с ипользованием ProxyJump

Теперь мы можем просто использовать имя хоста someinternalhost без проблем с настройкой маршрута перехода каждый раз, когда вы обращаетесь к someinternalhost.

$ ssh someinternalhost

P.s: источники
https://itsecforu.ru/2020/12/04/%F0%9F%90%A7-4-%D1%81%D0%BF%D0%BE%D1%81%D0%BE%D0%B1%D0%B0-%D0%BF%D0%BE%D0%B4%D0%BA%D0%BB%D1%8E%D1%87%D0%B5%D0%BD%D0%B8%D1%8F-%D0%BA-ssh-%D0%B8-scp-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-%D0%BF%D1%80%D0%BE/
и
https://goteleport.com/blog/ssh-proxyjump-ssh-proxycommand/
