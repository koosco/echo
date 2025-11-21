.PHONY: nodes node-exec build build-image pods replicasets svc delete-all apply delete %

nodes:
	k3d node list

# crictl images 확인
node-exec:
	docker exec -it k3d-mycluster-server-0 sh 

build:
	./gradlew clean build

build-image:
	docker build -t echo-server:3.0 .
	k3d image import echo-server:3.0 -c mycluster

pods:
	kubectl get pods

replicasets:
	kubectl get replicasets

svc:
	kubectl get svc

delete-all:
	kubectl delete all --all

delete:
	kubectl delete -f $(filter-out $@,$(MAKECMDGOALS))

apply:
	kubectl apply -f $(filter-out $@,$(MAKECMDGOALS))


%:
	@: