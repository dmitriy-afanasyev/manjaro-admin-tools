# 🛠️ manjaro-admin-tools

Скрипт `update-manjaro.sh` выполняет полное обслуживание системы Manjaro Linux:

- 🪞 Обновляет зеркала
- 🗄️ Синхронизирует базу данных пакетов
- 📦 Обновляет официальные пакеты
- 🔧 Обновляет AUR‑пакеты (с поддержкой игнорирования через `.env`)
- 🧹 Очищает кэш `pacman`, `yay`, удаляет старые версии пакетов и пользовательский кэш
- 🔍 Проверяет наличие битых (повреждённых) пакетов
- 💾 Показывает занятое место на корневом разделе

## 📥 Как клонировать и запустить

### Атоматический режим

_(Может не работать благодаря дементорам из PKН)_

```bash
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dmitriy-afanasyev/manjaro-admin-tools/main/install.sh)"
```

### Вручную

```bash
sudo mkdir -p /opt/manjaro-admin-tools
cd /opt/manjaro-admin-tools
sudo git clone https://github.com/dmitriy-afanasyev/manjaro-admin-tools.git .
sudo chmod +x update-manjaro.sh
sudo ln -sf /opt/manjaro-admin-tools/update-manjaro.sh /usr/local/bin/update-manjaro
```
