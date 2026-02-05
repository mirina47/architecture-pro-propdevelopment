#!/bin/bash
set -e

echo "Проверка доступа к кластеру..."
kubectl cluster-info > /dev/null

NAMESPACE=default

echo "Разворачиваем сервисы"

kubectl run front-end-app \
  --image=nginx \
  --labels role=front-end \
  --expose --port 80 \
  -n $NAMESPACE || true

kubectl run back-end-api-app \
  --image=nginx \
  --labels role=back-end-api \
  --expose --port 80 \
  -n $NAMESPACE || true

kubectl run admin-front-end-app \
  --image=nginx \
  --labels role=admin-front-end \
  --expose --port 80 \
  -n $NAMESPACE || true

kubectl run admin-back-end-api-app \
  --image=nginx \
  --labels role=admin-back-end-api \
  --expose --port 80 \
  -n $NAMESPACE || true