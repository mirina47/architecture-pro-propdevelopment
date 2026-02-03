#!/bin/bash
set -e

NAMESPACE=users
USERS=("reader" "editor" "admin")

kubectl create namespace $NAMESPACE 2>/dev/null || true

for USER in "${USERS[@]}"; do
  kubectl create serviceaccount $USER -n $NAMESPACE 2>/dev/null || true
done

echo "Пользователи успешно созданы в namespace $NAMESPACE"
