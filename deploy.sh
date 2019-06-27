docker build -t rohitdockeryes/multi-client:latest -t rohitdockeryes/multi-client:$SHA  -f ./client/Dockerfile.dev ./client
docker build -t rohitdockeryes/multi-server:latest -t rohitdockeryes/multi-server:$SHA  -f ./client/Dockerfile.dev ./server
docker build -t rohitdockeryes/multi-worker:latest -t rohitdockeryes/multi-worker:$SHA  -f ./client/Dockerfile.dev ./worker

docker push rohitdockeryes/multi-client:latest
docker push rohitdockeryes/multi-server:latest
docker push rohitdockeryes/multi-worker:latest

docker push rohitdockeryes/multi-client:$SHA
docker push rohitdockeryes/multi-server:$SHA
docker push rohitdockeryes/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client= rohitdockeryes/multi-client:$SHA
kubectl set image deployments/server-deployment server= rohitdockeryes/multi-server:$SHA
kubectl set image deployments/worker-deployment worker= rohitdockeryes/multi-worker:$SHA

