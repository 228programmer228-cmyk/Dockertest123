# Берем образ сразу с .NET 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Устанавливаем базовые проги для "VPS"
RUN apt-get update && apt-get install -y \
    tmux nano htop wget curl unzip sudo \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Web-терминал (ttyd)
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Сразу закидываем Playit.gg
RUN wget https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 -O /usr/local/bin/playit \
    && chmod +x /usr/local/bin/playit

# Рабочая папка
WORKDIR /root

# Указываем Zeabur, что терминал будет работать на порту 8080
EXPOSE 8080

# ВОТ ТУТ ИСПРАВЛЕНО (добавлен пробел после CMD)
CMD["ttyd", "-p", "8080", "-W", "tmux", "new", "-s", "vps"]
