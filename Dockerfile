# Берем образ с полноценным графическим рабочим столом (LXDE)
FROM dorowu/ubuntu-desktop-lxde-vnc:focal

# ИСПРАВЛЕНИЕ: Удаляем сломанный репозиторий Google Chrome, из-за которого крашится сборка
RUN rm -f /etc/apt/sources.list.d/google*.list

# Устанавливаем базовые программы и .NET 8.0
RUN apt-get update && apt-get install -y wget apt-transport-https && \
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Скачиваем Playit.gg
RUN wget https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 -O /usr/local/bin/playit && \
    chmod +x /usr/local/bin/playit

# Рабочий стол будет доступен по стандартному веб-порту
EXPOSE 80
