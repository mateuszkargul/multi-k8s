docker build -t mkargul/multi-client:latest -t mkargul/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mkargul/multi-server:latest -t mkargul/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mkargul/multi-worker:latest -t mkargul/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mkargul/multi-client:latest
docker push mkargul/multi-server:latest
docker push mkargul/multi-worker:latest

docker push mkargul/multi-client:$SHA
docker push mkargul/multi-server:$SHA
docker push mkargul/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mkargul/multi-server:$SHA
kubectl set image deployments/client-deployment client=mkarugl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mkargul/multi-worker:$SHA