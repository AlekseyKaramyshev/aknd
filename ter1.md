### Чек-лист готовности к домашнему заданию

1. Скачайте и установите **Terraform** версии >=1.12.0 . Приложите скриншот вывода команды ```terraform --version```.
2. Скачайте на свой ПК этот git-репозиторий. Исходный код для выполнения задания расположен в директории **01/src**.
3. Убедитесь, что в вашей ОС установлен docker.

<img width="549" height="132" alt="ter1" src="https://github.com/user-attachments/assets/ceebe471-091c-41f6-ab17-a2e3d63361e7" />


---

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?(логины,пароли,ключи,токены итд)
3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
5. Выполните код. В качестве ответа приложите: исправленный фрагмент кода и вывод команды ```docker ps```.
6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. Догадайтесь или нагуглите зачем может пригодиться данный ключ? В качестве ответа дополнительно приложите вывод команды ```docker ps```.
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ **ОБЯЗАТЕЛЬНО НАЙДИТЕ В ПРЕДОСТАВЛЕННОМ КОДЕ**, а затем **ОБЯЗАТЕЛЬНО ПОДКРЕПИТЕ** строчкой из документации [**terraform провайдера docker**](https://library.tf/providers/kreuzwerker/docker/latest).  (ищите в классификаторе resource docker_image )

*Решение*

1. Скачивание зависимостей

<img width="1182" height="597" alt="ter1_1" src="https://github.com/user-attachments/assets/307f3a7e-6cba-4bb1-896d-1b7ee59051c3" />


---

2. Файл для хранения **terraform** секретов
```
personal.auto.tfvars
```

---

3. Значение секрета

<img width="1593" height="65" alt="ter3" src="https://github.com/user-attachments/assets/cb8d3c04-8235-418a-9462-274087f1764b" />

---

4. Для ресурса типа **docker_image** пропущено название
```
│ Error: Missing name for resource
│ 
│   on main.tf line 22, in resource "docker_image":
│   22: resource "docker_image" {
│ 
│ All resource blocks must have 2 labels (type, name).
```
  Для ресурса **docker_container** указано некорректное ( `начинается не с буквы или нижнего подчёркивания` ) имя
```
│ Error: Invalid resource name
│ 
│   on main.tf line 27, in resource "docker_container" "1nginx":
│   27: resource "docker_container" "1nginx" {
│ 
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
```
В интерполяции идёт указание на несуществующему ресурс **random_password**
```
│ Error: Reference to undeclared resource
│ 
│   on main.tf line 29, in resource "docker_container" "nginx":
│   29:   name  = "example_${random_password.random_string_FAKE.resulT}"
│ 
│ A managed resource "random_password" "random_string_FAKE" has not been declared in the root module.
```
синтаксическая ошибка в названии атрибута **result**
```
│ Error: Unsupported attribute
│ 
│   on main.tf line 29, in resource "docker_container" "nginx":
│   29:   name  = "example_${random_password.random_string.resulT}"
│ 
│ This object has no argument, nested block, or exported attribute named "resulT". Did you mean "result"?
```

---

5. Исправленный манифест

```bash
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ cat main.tf 
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
  required_version = "~>1.12.0" /*Многострочный комментарий.
 Требуемая версия terraform */
}
provider "docker" {}

#однострочный комментарий

resource "random_password" "random_string" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ 
```


<img width="1429" height="141" alt="ter5" src="https://github.com/user-attachments/assets/271590c4-bc2b-47cd-84fc-4c871b7cb47d" />


---

6. Опция **-auto-approve** выполняет инструкции без подтверждения. Что приведёт к деструктивным последствиям, если в манифест случайно или умышленно ( например скопированный из Интернета манифест  ) были внесены нежелательные инструкции.

---

7. Состояние после **terraform destroy**
```
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.12.2",
  "serial": 26,
  "lineage": "78df77f4-f0e8-8eac-8618-3f54d9ae74c2",
  "outputs": {},
  "resources": [],
  "check_results": null
}
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ 
```
---

8. Из-за опциональной настроки:

> keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.

**docker** образ остаётся после удаления инфраструктуры командой **terraform destroy**.

---

## Дополнительное задание (со звёздочкой*)

### Задание 2*

Не успел...

---

### Задание 3*
1. Установите [opentofu](https://opentofu.org/)(fork terraform с лицензией Mozilla Public License, version 2.0) любой версии
2. Попробуйте выполнить тот же код с помощью ```tofu apply```, а не terraform apply.

**Решение**

Для деплоя, потребовалось предварительно переинициализировать плагины и изменить **minor** версию в зависимостях
```bash
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ tofu apply
╷
│ Error: Inconsistent dependency lock file
│ 
│ The following dependency selections recorded in the lock file are inconsistent with the current configuration:
│   - provider registry.opentofu.org/hashicorp/random: required by this configuration but no version is selected
│   - provider registry.opentofu.org/kreuzwerker/docker: required by this configuration but no version is selected
│ 
│ To update the locked dependency selections to match a changed configuration, run:
│   tofu init -upgrade
╵
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$

dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ tofu init -upgrade

Initializing the backend...
╷
│ Error: Unsupported OpenTofu Core version
│ 
│   on main.tf line 7, in terraform:
│    7:   required_version = "~>1.12.0" /*Многострочный комментарий.
│ 
│ This configuration does not support OpenTofu version 1.11.3. To proceed, either choose another supported OpenTofu version or update this version constraint. Version constraints are
│ normally set for good reason, so updating the constraint may lead to other errors or unexpected behavior.
╵

dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$

dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ grep version main.tf 
  required_version = "~>1.11.0" /*Многострочный комментарий.
dev1@dev1-host ~/Documents/Netology/DevOPS/.git-repos/ter-homeworks/01/src  (main)$ 
```

<img width="1416" height="138" alt="ter3_1" src="https://github.com/user-attachments/assets/9b882c8d-f882-4d86-837a-b6f3f1d84257" />
