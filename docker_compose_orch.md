- Задача 1

https://hub.docker.com/repository/docker/optester7/custom-nginx/general

---

- Задача 2

![Task2.bmp](https://github.com/user-attachments/files/24354706/2.bmp)

---

- Задача 3

![Task3.bmp](https://github.com/user-attachments/files/24354733/3.bmp)

> Почему контейнер остановился после docker attach затем CTRL + C?

`docker attach подключает STDIN, STDOUT, STDERR потоки терминала к запущенному контейнеру.
В контейнере nginx master process запущен как главный родительский процесс с PID 1.
После docker attach процесс nginx переносится в foreground терминала и запуск CTRL + C
( escape sequence ) отправляет SIGINT ОС сигнал, для graceful-завершения nginx master процесса.
После завершения основного ( nginx master ) процесса в контейнер, контейнер завершает
работу.`

> Почему после правок порта в конфиге внутри контейнера, на хосте служба стала недоступна по изначально заданному хост порту?

`docker при изначальном запуске через run создал связь/mapping порта на хосте 8080 и порта в 
контейнере 80, ручные изменения порта внутри контейнера ( linux namespace ) не поменяли 
изначально заданный mapping заявленный в аргументых к docker run.`

---

- Задача 4

![Task4.bmp](https://github.com/user-attachments/files/24354742/4.bmp)

---

- Задача 5

![Task5.bmp](https://github.com/user-attachments/files/24354756/5.bmp)

![Task5_1.bmp](https://github.com/user-attachments/files/24354758/5_1.bmp)


> Какой файл был запущен?

`Используется compose.yml так как он приоритетнее в текущих реалиях.`

> В чём суть предупреждения?

Удалив compose.yml оставив при этом, описанный в нём, контейнер сервиса portainer, мы создали контейнер "сироту"/orphan который не связан с сервисами в существующих файлах манифеста/ов.
Предупреждение просто рекомендует очистить лишнее, для консистентности.
