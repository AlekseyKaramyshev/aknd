**Задание 1**

Ошибки возникли с значениями *platform_id*, *cores*, *core_fraction* ресурса *yandex_compute_instance*, требовалось актуализировать параметры, согласно доступным тарифам.
Также потребовалось указать *zone* для каждой vm без этого при разделении на подсети и зоны, выпадала ошибка

> Zone in subnet does not match expected zone

Параметры preemptible = true и core_fraction=5 могут пригодиться для экономии ресусов, например, при деплое внутри dev, staging окружений/контуров.

<img width="658" height="815" alt="ter2_1" src="https://github.com/user-attachments/assets/b07e7262-5a10-4d73-9316-a1ebb588446e" />

<img width="720" height="663" alt="ter2_2" src="https://github.com/user-attachments/assets/9d097bf6-b40d-48dd-a53e-5d5b16f4ad5f" />

---

**Задание 4**

<img width="1788" height="74" alt="2_4" src="https://github.com/user-attachments/assets/13ad9e0f-579b-4e8f-9d2f-1375be5f975f" />

---

**Задание 7***

<img width="1843" height="382" alt="ter7" src="https://github.com/user-attachments/assets/0be8cbdd-d07d-4980-b643-24faf115c9bf" />


```zsh
> local.test_list[1]
"staging"
>  
> length(local.test_list)
3
>  
> local.test_map.admin
"John"
>  
> "${local.test_map.admin} is ${keys(local.test_map).0} for ${local.test_list.2} server based on OS ${local.servers.stage.image} with ${local.servers.stage.cpu} vcpu, ${local.servers.stage.ram} ram, and ${length(local.servers.stage.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 4 vcpu, 8 ram, and 2 virtual disks"
>
```
