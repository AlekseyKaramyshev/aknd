Ошибки возникли с значениями *platform_id*, *cores*, *core_fraction* ресурса *yandex_compute_instance*, требовалось актуализировать параметры, согласно доступным тарифам.
Также потребовалось указать *zone* для каждой vm без этого при разделении на подсети и зоны, выпадала ошибка

> Zone in subnet does not match expected zone

---

Параметры preemptible = true и core_fraction=5 могут пригодиться для экономии ресусов, например, при деплое внутри dev, staging окружений/контуров.

---

<img width="658" height="815" alt="ter2_1" src="https://github.com/user-attachments/assets/c462eb86-c78c-40c5-8c63-b6dbcb69e76b" />

<img width="720" height="663" alt="ter2_2" src="https://github.com/user-attachments/assets/c125c243-755a-43f9-b185-0fd42bd09fc7" />

<img width="1788" height="74" alt="2_4" src="https://github.com/user-attachments/assets/ec0d8e13-c67a-4b3b-adf3-64db2f331fdd" />
