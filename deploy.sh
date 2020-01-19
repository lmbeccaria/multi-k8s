docker build -t vinoveritas40/multi-client:latest -t vinoveritas40/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinoveritas40/multi-server:latest -t vinoveritas40/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinoveritas40/multi-worker:latest -t vinoveritas40/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vinoveritas40/multi-client:latest
docker push vinoveritas40/multi-server:latest
docker push vinoveritas40/multi-worker:latest

docker push vinoveritas40/multi-client:$SHA
docker push vinoveritas40/multi-server:$SHA
docker push vinoveritas40/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinoveritas40/multi-server:$SHA
kubectl set image deployments/client-deployment client=vinoveritas40/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vinoveritas40/multi-worker:$SHA
