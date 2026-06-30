#!/bin/bash
set -e

echo "--- Шаг 1: Запуск миграций Alembic ---"
# Выполняем миграции. Если база пустая, создаст структуру.
alembic upgrade head || echo "Миграции не применились, возможно БД еще загружается..."

echo "--- Шаг 2: Запуск приложения FastAPI ---"
exec uvicorn app.main:app --host 0.0.0.0 --port 8000
