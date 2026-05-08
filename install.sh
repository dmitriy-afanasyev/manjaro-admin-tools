#!/bin/bash

# Скрипт установки/обновления manjaro-admin-tools с созданием символической ссылки
set -e

# Проверка прав root
if [[ $EUID -ne 0 ]]; then
   echo "Этот скрипт должен выполняться с правами root"
   echo "Запустите: sudo $0"
   exit 1
fi

TARGET_DIR="/opt/manjaro-admin-tools"
REPO_URL="https://github.com/dmitriy-afanasyev/manjaro-admin-tools.git"
SCRIPT_NAME="update-manjaro.sh"
LINK_NAME="/usr/local/bin/update-manjaro"

echo "→ Создание папки $TARGET_DIR (если не существует)..."
mkdir -p "$TARGET_DIR"

cd "$TARGET_DIR"

if [ -d ".git" ]; then
    echo "→ Репозиторий уже существует, выполняю git pull для обновления..."
    git pull
else
    echo "→ Клонирование репозитория..."
    git clone "$REPO_URL" .
fi

echo "→ Предоставление прав на выполнение файлу $SCRIPT_NAME..."
chmod +x "$SCRIPT_NAME"

echo "→ Создание символической ссылки $LINK_NAME -> $TARGET_DIR/$SCRIPT_NAME..."
ln -sf "$TARGET_DIR/$SCRIPT_NAME" "$LINK_NAME"

echo "✅ Установка/обновление завершены."
echo "Теперь вы можете запускать скрипт из любого места командой: update-manjaro"