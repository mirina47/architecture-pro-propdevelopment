# 1. Создание namespace
```
kubectl apply -f 01-create-namespace.yaml
```

# 2. Установка OPA Gatekeeper
```
kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/release-3.14/deploy/gatekeeper.yaml
kubectl wait --for=condition=Ready pod -l control-plane=controller-manager -n gatekeeper-system --timeout=300s
```

# 3. Настройка OPA Gatekeeper
```
kubectl apply -f gatekeeper/constraint-templates/
kubectl apply -f gatekeeper/constraints/
```

# 4. Проверка
```
chmod +x ./verify/verify-admission.sh
./verify/verify-admission.sh
chmod +x ./verify/validate-security.sh
./verify/validate-security.sh
```