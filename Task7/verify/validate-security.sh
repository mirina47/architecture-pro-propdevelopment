#!/bin/bash
# Демонстрация применения всех манифестов с выводом результата для каждого пода

INSECURE="insecure-manifests"
SECURE="secure-manifests"

echo -e "=== Применение небезопасных подов ===\n"

for file in "$INSECURE"/*.yaml; do
    echo "Файл $file:"
    kubectl apply -f "$file" --dry-run=server
    if [ $? -ne 0 ]; then
        echo "✅ Под не прошёл, как ожидалось"
    else
        echo "❌ Под прошёл, хотя должен быть заблокирован"
    fi
    echo "----------------------------------------"
done

echo -e "=== Применение безопасных подов ===\n"

for file in "$SECURE"/*.yaml; do
    echo "Файл $file:"
    kubectl apply -f "$file" --dry-run=server
    if [ $? -eq 0 ]; then
        echo "✅ Под прошёл успешно"
    else
        echo "❌ Под не прошёл, хотя должен быть безопасным"
    fi
    echo "----------------------------------------"
done

echo "=== Применение завершено ==="
