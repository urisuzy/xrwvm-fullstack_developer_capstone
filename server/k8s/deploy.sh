#!/bin/bash
# Build, push and deploy the whole Best Cars app to the lab Kubernetes cluster.
set -e
cd "$(dirname "$0")/.."
NS=${MY_NAMESPACE:-$(ibmcloud cr namespaces | grep sn-labs- | head -1)}
echo "Using registry namespace: $NS"

docker build -t us.icr.io/$NS/nodeapp database
docker push us.icr.io/$NS/nodeapp
docker build -t us.icr.io/$NS/senti_analyzer djangoapp/microservices
docker push us.icr.io/$NS/senti_analyzer

(cd frontend && npm install --silent && npm run build)
docker build -t us.icr.io/$NS/dealership .
docker push us.icr.io/$NS/dealership

sed "s|your-name-space|$NS|g" k8s/backend.yaml | kubectl apply -f -
sed "s|your-name-space|$NS|g" deployment.yaml | kubectl apply -f -
kubectl rollout status deployment/mongo-db --timeout=300s
kubectl rollout status deployment/nodeapi --timeout=300s
kubectl rollout status deployment/sentianalyzer --timeout=300s
kubectl rollout status deployment/dealership --timeout=300s
kubectl get pods
