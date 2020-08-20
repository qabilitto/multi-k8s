docker build -t qabilitto/multi-client:latest -t qabilitto/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t qabilitto/multi-server:latest -t qabilitto/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t qabilitto/multi-worker:latest -t qabilitto/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push qabilitto/multi-client:latest
docker push qabilitto/multi-server:latest
docker push qabilitto/multi-worker:latest

docker push qabilitto/multi-client:$SHA
docker push qabilitto/multi-server:$SHA
docker push qabilitto/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=qabilitto/multi-server:$SHA
kubectl set image deployments/client-deployment client=qabilitto/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=qabilitto/multi-worker:$SHA