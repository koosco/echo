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
kubectl apply -f pod.yaml
kubectl get pods
kubectl logs echo-pod
kubectl port-forward pod/echo-pod 8080:8080
kubectl exec -it echo-pod -- bash
kubectl describe pods echo-pod

kubectl apply -f deployment.yaml
kubectl delete -f deployment.yaml
kubectl describe deployment echo-deployment
```
