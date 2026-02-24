#!/bin/bash
# Проверка работы PodSecurity и Gatekeeper: небезопасные поды блокируются, безопасные проходят

INSECURE="insecure-manifests"
SECURE="secure-manifests"

echo -e "=== Проверка небезопасных подов (должны блокироваться) ===\n"

for file in "$INSECURE"/*.yaml; do
    echo "Файл $file:"
    kubectl apply -f "$file" --dry-run=server
    if [ $? -ne 0 ]; then
        echo "✅ Под заблокирован, как и ожидалось"
    else
        echo "❌ Под прошёл, хотя должен быть заблокирован"
    fi
    echo "----------------------------------------"
done

echo -e "=== Проверка безопасных подов (должны проходить) ===\n"

for file in "$SECURE"/*.yaml; do
    echo "Файл $file:"
    kubectl apply -f "$file" --dry-run=server
    if [ $? -eq 0 ]; then
        echo "✅ Под прошёл валидацию успешно"
    else
        echo "❌ Под не прошёл, хотя должен быть безопасным"
    fi
    echo "----------------------------------------"
done

echo "=== Проверка завершена ==="
