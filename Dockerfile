# Используем официальный образ .NET 8.0 (в нем уже есть всё для работы)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS base

# Создаем рабочую папку
WORKDIR /app

# Устанавливаем нужные программы: wget (качать файлы) и screen (для фоновых задач)
RUN apt-get update && apt-get install -y wget curl bash unzip

# Скачиваем Playit.gg агента для Linux
RUN wget https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 -O /usr/local/bin/playit
RUN chmod +x /usr/local/bin/playit

# Копируем наш скрипт запуска из GitHub в контейнер
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Копируем все остальные файлы твоего репозитория в контейнер
COPY . /app/

# Команда, которая выполнится при старте сервера в Zeabur
CMD ["/app/start.sh"]
