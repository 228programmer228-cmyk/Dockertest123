# Берем образ сразу с .NET 8.0, чтобы твой C# сервер работал без танцев с бубном
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Устанавливаем базовые проги для "VPS" (tmux, nano, htop и т.д.)
RUN apt-get update && apt-get install -y \
    tmux nano htop wget curl unzip sudo \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем Web-терминал (ttyd), чтобы заходить в консоль через браузер
RUN wget https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 -O /usr/local/bin/ttyd \
    && chmod +x /usr/local/bin/ttyd

# Сразу закидываем Playit.gg
RUN wget https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 -O /usr/local/bin/playit \
    && chmod +x /usr/local/bin/playit

# Рабочая папка
WORKDIR /root

# Запускаем ttyd на порту 8080. Опция -W разрешает писать команды. 
# При входе он сразу откроет сессию tmux с названием "vps"!
CMD["ttyd", "-p", "8080", "-W", "tmux", "new", "-s", "vps"]
