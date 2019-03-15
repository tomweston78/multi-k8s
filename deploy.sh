docker build -t tomweston78/multi-client:latest -t tomweston78/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomweston78/multi-server:latest -t tomweston78/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t tomweston78/multi-worker:latest -t tomweston78/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push tomweston78/multi-client:latest
docker push tomweston78/multi-server:latest
docker push tomweston78/multi-worker:latest
docker push tomweston78/multi-client:$SHA
docker push tomweston78/multi-server:$SHA
docker push tomweston78/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tomweston78/multi-server:$SHA
kubectl set image deployments/client-deployment client=tomweston78/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tomweston78/multi-worker:$SHA
