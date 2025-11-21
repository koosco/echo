.PHONY: build build-image pods replicasets service delete-all apply delete %

build:
	./gradlew clean build

build-image:
	docker build -t echo-server:v2 .
	k3d image import echo-server:v2 -c mycluster

pods:
	kubectl get pods

replicasets:
	kubectl get replicasets

service:
	kubectl get service

delete-all:
	kubectl delete all --all

apply:
	kubectl apply -f $(filter-out $@,$(MAKECMDGOALS))

delete:
	kubectl delete -f $(filter-out $@,$(MAKECMDGOALS))

%:
	@: