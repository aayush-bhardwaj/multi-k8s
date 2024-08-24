docker build -t aayush2911/multi-client:latest -t aayush2911/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aayush2911/multi-server:latest -t aayush2911/multi-client:$SHA -f ./server/Dockerfile ./server
docker build -t aayush2911/multi-worker:latest -t aayush2911/multi-client:$SHA -f ./worker/Dockerfile ./worker

docker push aayush2911/multi-client:latest
docker push aayush2911/multi-client:$SHA
docker push aayush2911/multi-server:latest
docker push aayush2911/multi-server:$SHA
docker push aayush2911/multi-worker:latest
docker push aayush2911/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aayush2911/multi-server:$SHA
kubectl set image deployments/client-deployment client=aayush2911/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aayush2911/multi-worker:$SHA