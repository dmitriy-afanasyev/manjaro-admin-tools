# manjaro-admin-tools

Скрипт `update-manjaro.sh` выполняет полное обслуживание системы Manjaro Linux:

- Обновляет зеркала
- Синхронизирует базу данных пакетов
- Обновляет официальные пакеты
- Обновляет AUR‑пакеты (с поддержкой игнорирования через `.env`)
- Очищает кэш `pacman`, `yay`, удаляет старые версии пакетов и пользовательский кэш
- Проверяет наличие битых (повреждённых) пакетов
- Показывает занятое место на корневом разделе

## Как клонировать и запустить

```bash
git clone https://github.com/dmitriy-afanasyev/manjaro-admin-tools.git
cd manjaro-admin-tools
chmod +x update-manjaro.sh
./update-manjaro.sh
```
