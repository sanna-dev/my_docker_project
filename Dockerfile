FROM python:3.10-slim

# Установка зависимостей с очисткой кэша (требование Hadolint)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpq-dev \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копируем зависимости
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект
COPY . .

RUN chmod +x scripts/entrypoint.sh

CMD ["/bin/bash", "scripts/entrypoint.sh"]
