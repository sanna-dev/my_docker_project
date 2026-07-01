FROM python:3.10-slim

WORKDIR /app

# Устанавливаем только curl для healthcheck и сразу чистим кэш apt
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Сначала копируем и устанавливаем зависимости (используем кэш слоев)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код (благодаря .dockerignore папка .git не попадет внутрь)
COPY . .

RUN chmod +x scripts/entrypoint.sh

CMD ["/bin/bash", "scripts/entrypoint.sh"]
