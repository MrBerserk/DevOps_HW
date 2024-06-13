# Базовый образ
FROM ubuntu:20.04

# Указываем метаданные об авторе образа
MAINTAINER Danilov D.D. <mr.berserk228@mail.ru>

## Обновляем список пакетов
RUN apt-get update

# Устанавливаем Nginx
RUN apt-get install -y nginx

# Устанавливаем PostgreSQL
RUN apt-get install -y postgresql

# Устанавливаем дополнительные утилиты PostgreSQL
RUN apt-get install -y postgresql-contrib

# Копируем конфигурационные файлы Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Копируем SQL-скрипт для инициализации базы данных
COPY init.sql /docker-entrypoint-initdb.d/

# Устанавливаем переменные окружения
ENV POSTGRES_USER myuser
ENV POSTGRES_PASSWORD mypassword
ENV POSTGRES_DB mydb

# Устанавливаем рабочую директорию
WORKDIR /var/www/html

# Копируем файлы веб-приложения
COPY app/ /var/www/html/

# Настраиваем права доступа
RUN chown -R www-data:www-data /var/www/html

# Открываем порты
EXPOSE 80 5432

# Указываем пользователя
USER www-data

# Указываем команду для запуска при старте контейнера
CMD service nginx start && su postgres -c "/usr/lib/postgresql/12/bin/postgres -D /var/lib/postgresql/12/main -c config_file=/etc/postgresql/12/main/postgresql.conf"