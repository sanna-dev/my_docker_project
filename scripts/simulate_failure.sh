#!/bin/bash
echo "Остановка БД..."
docker compose stop db
echo "Ждем 10 секунд..."
sleep 10
echo "Запуск БД..."
docker compose start db
echo "Проверка логов приложения..."
sleep 5
docker compose logs app | tail -n 10
