#!/bin/bash
echo "Проверка здоровья приложения после деплоя..."
sleep 10
STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8000/health)

if [ "$STATUS" -ne 200 ]; then
  echo "ОШИБКА: Healthcheck провален (код $STATUS). Начинаю Rollback!"
  docker compose rollback # Или любая логика возврата к тегу :stable
  exit 1
else
  echo "Деплой успешен! Приложение здорово."
fi
