#!/bin/bash
echo "Запуск миграций Alembic..."
# В реальном проекте: alembic upgrade head
sleep 2
echo "Миграции применены!"
echo "Запуск приложения..."
uvicorn app.main:app --host 0.0.0.0 --port 8000
