#!/bin/bash

# Скрипт для полного обновления Manjaro Linux
# с разделением прав для sudo и пользовательских команд

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

ENV_FILE="$(dirname "$0")/.env"   # ищем .env в той же папке, что и скрипт
if [ -f "$ENV_FILE" ]; then
    set -a
    source "$ENV_FILE"
    set +a
else
    echo -e "${YELLOW}Файл .env не найден. Используются значения по умолчанию.${NC}"
    IGNORED_APP=''
fi

check_error() {
    if [ $? -ne 0 ]; then
        echo -e "${RED}Ошибка на этапе: $1${NC}"
        echo -e "${YELLOW}Продолжить? [y/N]${NC}"
        read -r answer
        if [[ ! "$answer" =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

echo -e "${GREEN}=== Начато обновление Manjaro ===${NC}"

# 1. Обновление зеркал (требует sudo)
echo -e "${YELLOW}Обновление зеркал...${NC}"
sudo pacman-mirrors --fasttrack --api --protocol https
check_error "Обновление зеркал"

# 2. Обновление базы данных (требует sudo)
echo -e "${YELLOW}Синхронизация базы данных...${NC}"
sudo pacman -Sy
check_error "Синхронизация базы данных"

# 3. Обновление официальных пакетов (требует sudo)
echo -e "${YELLOW}Обновление системных пакетов...${NC}"
sudo pacman -Su --noconfirm
check_error "Обновление системных пакетов"

# 4. Обновление AUR
if command -v yay &> /dev/null; then
    echo -e "${YELLOW}Обновление AUR-пакетов...${NC}"    
    yay -Su --aur --noconfirm ${IGNORED_APP:+--ignore "$IGNORED_APP"}
    check_error "Обновление AUR-пакетов"
else
    echo -e "${YELLOW}yay не установлен. Пропуск AUR.${NC}"
fi

# 5. Очистка кэша (разделяем sudo и пользовательские команды)
echo -e "${YELLOW}Очистка кэша...${NC}"

# Системный кэш (требует sudo)
sudo pacman -Sc --noconfirm
check_error "Очистка кэша pacman"

# AUR кэш (без sudo)
if command -v yay &> /dev/null; then
    yay -Sc --noconfirm
    check_error "Очистка кэша yay"
fi

# Очистка старых версий (требует sudo)
sudo paccache -rk1
check_error "Очистка старых версий пакетов"

# Пользовательский кэш (без sudo)
rm -rf ~/.cache/*
check_error "Очистка пользовательского кэша"

# 6. Проверка на битые пакеты
echo -e "${YELLOW}Проверка на битые пакеты...${NC}"
sudo pacman -Qknq || echo -e "${RED}Внимание: найдены повреждённые пакеты!${NC}"
check_error "Проверка пакетов"

# 7. Проверка занятого места
echo -e "${YELLOW}Итоговое использование диска:${NC}"
df -h /

echo -e "${GREEN}=== Обновление завершено успешно! ===${NC}"
