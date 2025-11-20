.PHONY: build build-image pods delete-all apply delete %

build:
	./gradlew clean build

build-image:
	docker build -t echo-server:v2 .
	k3d image import echo-server:v2 -c mycluster

pods:
	kubectl get pods

delete-all:
	kubectl delete all --all

apply:
	kubectl apply -f $(filter-out $@,$(MAKECMDGOALS))

delete:
	kubectl delete -f $(filter-out $@,$(MAKECMDGOALS))

%:
	@: