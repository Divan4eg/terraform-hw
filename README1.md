# Домашнее задание к занятию "`Основы Terraform. Yandex Cloud`" - `Первушин Дмитрий`

### Задание 1

В качестве ответа всегда полностью прикладывайте ваш terraform-код в git. Убедитесь что ваша версия Terraform ~>1.12.0

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. service_account_key_file.
3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
5. Подключитесь к консоли ВМ через ssh и выполните команду `curl ifconfig.me`. Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: `"ssh ubuntu@vm_ip_address"`. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: `eval $(ssh-agent) && ssh-add` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
6. Ответьте, как в процессе обучения могут пригодиться параметры `preemptible = true` и `core_fraction=5` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

### Решение 1

4. Нашел следующие ошибки

```
 Error: Error while requesting API to create instance: client-request-id = c3535a60-abe7-4a91-9703-9f89a6d47199 client-trace-id = d3bd596a-751c-452a-b8d4-590048c4cf13 rpc error: code = FailedPrecondition desc = Platform "standart-v4" not found
│ 
│   with yandex_compute_instance.platform,
│   on main.tf line 15, in resource "yandex_compute_instance" "platform":
│   15: resource "yandex_compute_instance" "platform" {
```
В каталоге Яндекса есть конфигурация `standard-v1`, нет `standart-v4`.

```
 Error: Error while requesting API to create instance: client-request-id = 40a71df7-6005-4d29-a567-8d943495e52e client-trace-id = bd5e8bd7-0dba-4245-9afa-07f1b5dc663c rpc error: code = InvalidArgument desc = the specified number of cores is not available on platform "standard-v1"; allowed core number: 2, 4
│ 
│   with yandex_compute_instance.platform,
│   on main.tf line 15, in resource "yandex_compute_instance" "platform":
│   15: resource "yandex_compute_instance" "platform" {

```
Нельзя установить нечетное количество ядер, поставил 2.

Скриншоты с результатами:
![task0](https://github.com/Divan4eg/terraform-hw/blob/main/img/4.png)
![task0](https://github.com/Divan4eg/terraform-hw/blob/main/img/5.png)

6. Эти параметры помогают экономить ресурсы на Я.Облаке, в частности:  
`preemptible = true` 
Прерываемая виртуальная машина — это особый тип ВМ, который может быть остановлен в любой момент по двум причинам:  
- Прошло более 24 часов с момента запуска
- Возникла нехватка ресурсов для запуска новых ВМ

`core_fraction=5`
Core_fraction определяет базовую производительность ядра процессора в процентах. Нагружать ВМ не будем, поэтому экономиим ресурсы.

### Задание 2

1. Замените все хардкод-значения для ресурсов yandex_compute_image и yandex_compute_instance на отдельные переменные. К названиям переменных ВМ добавьте в начало префикс vm_web_ . Пример: vm_web_name.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их default прежними значениями из main.tf.
3. Проверьте terraform plan. Изменений быть не должно.

### Решение 2

Прикладываю новые файлы main и variables  

[MAIN](https://github.com/Divan4eg/terraform-hw/blob/main/task2/main.tf)
[VARIABLES](https://github.com/Divan4eg/terraform-hw/blob/main/task2/variables.tf)

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: "netology-develop-platform-db" , cores  = 2, memory = 2, core_fraction = 20. Объявите её переменные с префиксом vm_db_ в том же файле ('vms_platform.tf'). ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

### Решение 3

Прикладываю новые файлы main, variables, vms_platform  
[MAIN](https://github.com/Divan4eg/terraform-hw/blob/main/task3/main.tf)
[VARIABLES](https://github.com/Divan4eg/terraform-hw/blob/main/task3/variables.tf)
[VMS_PLATFORM](https://github.com/Divan4eg/terraform-hw/blob/main/task3/vms_platform.tf)

### Задание 4

1. Объявите в файле outputs.tf один output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.
В качестве решения приложите вывод значений ip-адресов команды terraform output.

### Решение 4

Прикладываю скриншоты  
![task4](https://github.com/Divan4eg/terraform-hw/blob/main/img/6.png)
![task4](https://github.com/Divan4eg/terraform-hw/blob/main/img/7.png)

### Задание 5

1. В файле locals.tf опишите в одном local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

### Решение 5

Прикладываю новые файлы main и locals  

[MAIN](https://github.com/Divan4eg/terraform-hw/blob/main/task5/main.tf)
[VARIABLES](https://github.com/Divan4eg/terraform-hw/blob/main/task5/locals.tf)

### Задание 6

Вместо использования трёх переменных ".._cores",".._memory",".._core_fraction" в блоке resources {...}, объедините их в единую map-переменную vms_resources и внутри неё конфиги обеих ВМ в виде вложенного map(object).

пример из terraform.tfvars:
vms_resources = {
  web={
    cores=2
    memory=2
    core_fraction=5
    hdd_size=10
    hdd_type="network-hdd"
    ...
  },
  db= {
    cores=2
    memory=4
    core_fraction=20
    hdd_size=10
    hdd_type="network-ssd"
    ...
  }
}
Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.

пример из terraform.tfvars:
metadata = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
}
Найдите и закоментируйте все, более не используемые переменные проекта.

Проверьте terraform plan. Изменений быть не должно.