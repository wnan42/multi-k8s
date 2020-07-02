docker build -t wnan42/multi-client:latest -t wnan42/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t wnan42/multi-server:latest -t wnan42/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t wnan42/multi-worker:latest -t wnan42/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push wnan42/multi-client:latest
docker push wnan42/multi-server:latest
docker push wnan42/multi-worker:latest

docker push wnan42/multi-client:$GIT_SHA
docker push wnan42/multi-server:$GIT_SHA
docker push wnan42/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wnan42/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=wnan42/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=wnan42/multi-worker:$GIT_SHA
