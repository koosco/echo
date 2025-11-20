k3d 설정
```bash
k3d cluster create mycluster
```

gradle build
```bash
./gradlew clean build
```

docker build
```bash
docker build -t echo-server .
k3d image import echo-server:v2 -c mycluster
```

kubectl
```bash
kubectl apply -f echo-server
kubectl get pods
kubectl logs echo-server
kubectl port-forward pod/echo-pod 8080:8080
kubectl exec -it echo-pod -- bash
```
