#!/bin/bash
echo "--- Запуск проверки безопасности перед коммитом ---"

# Проверяем на секреты только папку app/ (код приложения), игнорируя конфиги .env
if grep -rE "PASSWORD|TOKEN|SECRET_KEY" app/ --exclude="*.sh" | grep -v "os.getenv"; then
    echo "ОШИБКА: Найдены секреты в коде приложения!"
    exit 1
fi

# Проверка на использование ADD
if grep "ADD" Dockerfile; then
    echo "ОШИБКА: Используй COPY вместо ADD."
    exit 1
fi

echo "Проверка пройдена успешно!"
