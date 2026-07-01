FROM python:3.10-slim

# Установка зависимостей по правилам Hadolint (Requirement Task 1 & 4)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Оптимизация слоев (Requirement Task 4)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Команда запуска миграций и сервера (Requirement Task 2)
RUN chmod +x scripts/entrypoint.sh
CMD ["/bin/bash", "scripts/entrypoint.sh"]
