#!/bin/bash
echo "--- Проверка Git-Hook ---"

# 1. Поиск секретов
if grep -rE "PASSWORD|TOKEN|SECRET" app/ --exclude="*.sh" | grep -v "os.getenv"; then
    echo "ОШИБКА: Секреты в коде!"
    exit 1
fi

# 2. Проверка ADD для файлов > 10МБ
ADD_LINE=$(grep "ADD" Dockerfile)
if [ -n "$ADD_LINE" ]; then
    FILE_NAME=$(echo "$ADD_LINE" | awk '{print $2}')
    if [ -f "$FILE_NAME" ]; then
        FILE_SIZE=$(wc -c < "$FILE_NAME")
        if [ "$FILE_SIZE" -gt 10485760 ]; then
            echo "ОШИБКА: Файл в ADD > 10MB!"
            exit 1
        fi
    fi
fi
echo "Проверка пройдена!"
