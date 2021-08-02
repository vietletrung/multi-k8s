docker build -t letrungviet/multi-client:latest  -t letrungviet/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t letrungviet/multi-server:latest -t letrungviet/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t letrungviet/multi-worker:latest -t letrungviet/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push letrungviet/multi-client:latest
docker push letrungviet/multi-server:latest
docker push letrungviet/multi-worker:latest

docker push letrungviet/multi-client:$SHA
docker push letrungviet/multi-server:$SHA
docker push letrungviet/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=letrungviet/multi-client:$SHA
kubectl set image deployments/server-deployment server=letrungviet/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=letrungviet/multi-worker:$SHA

