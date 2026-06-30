FROM python:3.10-slim

# Установка системных зависимостей (Requirement: Task 1 & 4 optimization)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Оптимизация слоев: сначала зависимости
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем остальной код
COPY . .

# Делаем скрипт исполняемым
RUN chmod +x scripts/entrypoint.sh

# Запуск через entrypoint (Requirement: Task 2 migrations)
CMD ["/bin/bash", "scripts/entrypoint.sh"]
