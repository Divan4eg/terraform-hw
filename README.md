# Домашнее задание к занятию "`Введение в Terraform`" - `Первушин Дмитрий`

### Задание 1

1. Перейдите в каталог src. Скачайте все необходимые зависимости, использованные в проекте.
2. Изучите файл .gitignore. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)
3. Выполните код проекта. Найдите в state-файле секретное содержимое созданного ресурса random_password, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла main.tf. Выполните команду terraform validate. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды docker ps.
6. Замените имя docker-контейнера в блоке кода на hello_world. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду terraform apply -auto-approve. Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды docker ps.
7. Уничтожьте созданные ресурсы с помощью terraform. Убедитесь, что все ресурсы удалены. Приложите содержимое файла terraform.tfstate.
8. Объясните, почему при этом не был удалён docker-образ nginx:latest. Ответ ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ, а затем ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ строчкой из документации terraform провайдера docker. (ищите в классификаторе resource docker_image )

### Решение 1

![task0](https://github.com/Divan4eg/terraform-hw/blob/main/img/0.png)

2. Личную информацию допустимо хранить в `personal.auto.tfvars`.

3. ```"result": "NdwceTg7SLumgIyK"```

4. 
```
 Error: Missing name for resource
│ 
│   on main.tf line 22, in resource "docker_image":
│   22: resource "docker_image" {
│ 
│ All resource blocks must have 2 labels (type, name).
```
Ошибка указывает на то, что блок resource должен принять 2 параметра - тип и имя, а в данном случае был один.

```
│ Error: Invalid resource name
│ 
│   on main.tf line 27, in resource "docker_container" "1nginx":
│   27: resource "docker_container" "1nginx" {
│ 
│ A name must start with a letter or underscore and may contain only letters,
│ digits, underscores, and dashes.
```
Ошибка указывает на то, что имя блока resource не может начинаться с цифры.

```
 Error: Reference to undeclared resource
│ 
│   on main.tf line 28, in resource "docker_container" "nginx":
│   28:   image = docker_image.nginx.image_id
│ 
│ A managed resource "docker_image" "nginx" has not been declared in the root
│ module.
```
Ошибка указывает на то, что terraform пытается обратиться к ресурсу с типом `docker_image` но был создан ресурс с именем `docker_container`. 
```
│ Error: Reference to undeclared resource
│ 
│   on main.tf line 29, in resource "docker_container" "nginx":
│   29:   name  = "example_${random_password.random_string_FAKE.resulT}"
│ 
│ A managed resource "random_password" "random_string_FAKE" has not been
│ declared in the root module.
```
Ошибка указывает на то, что не создан ресурс с именем `random_string_FAKE`, создан с именем `random_string`. Также большая буква T в слове `result`.

5. Исправленный код:
```
resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "test_name" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.test_name.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
```

![task5](https://github.com/Divan4eg/terraform-hw/blob/main/img/1.png)

6. Команда `terraform apply -auto-approve` выполняет применение изменений в инфраструктуре без запроса подтверждения у пользователя. Риски использования - необратимые изменения могут быть применены без возможности их предварительного просмотра, возможны потери данных из-за ошибок в конфигурации, которые будут применены автоматически. Можно применять в CI/CD пайплайнах.
![task6](https://github.com/Divan4eg/terraform-hw/blob/main/img/2.png)

7. 
```
{
  "version": 4,
  "terraform_version": "1.14.3",
  "serial": 14,
  "lineage": "ec66690d-a11d-4cce-054c-60c11d9640c2",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

8. Образ не удалился так как был использован аргумент `keep_locally = true`.

https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image
![task6](https://github.com/Divan4eg/terraform-hw/blob/main/img/3.png)
