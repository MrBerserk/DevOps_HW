#!/bin/bash

# Функция для записи лога
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a create_user_dirs.log
}

# Проверка наличия ключа "-d"
if [ "$1" == "-d" ]; then
    root_dir="$2"
else
    # Запрос пути к корневому каталогу через диалог
    read -p "Введите путь к корневому каталогу: " root_dir
fi

# Проверка наличия корневого каталога
if [ -d "$root_dir" ]; then
    log "Корневой каталог: $root_dir"
else
    log "Ошибка: Корневой каталог '$root_dir' не существует."
    exit 1
fi

# Получение списка реальных пользователей системы
users=$(getent passwd | awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}')

# Создание директорий для каждого реального пользователя
for user in $users; do
    user_dir="$root_dir/$user"
    
    if [ ! -d "$user_dir" ]; then
        mkdir "$user_dir"
        chmod 755 "$user_dir"
        chown "$user" "$user_dir"
        log "Создана директория '$user_dir' для пользователя '$user'"
    else
        log "Директория '$user_dir' уже существует для пользователя '$user'"
    fi
done

log "Скрипт завершен."