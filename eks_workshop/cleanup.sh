#!/bin/bash
# Version: 0.4
# This is no longer being maintained PRs are still welcome, but I am no longer making updates to the
read -rp "What is the name of your eks cluster (check eksworkshop.yaml it will be eksworkshop-name): " clustername
echo "UNDEPLOY THE APPLICATIONS"
#https://www.eksworkshop.com/920_cleanup/undeploy/

cd ~/environment/ecsdemo-frontend || exit 1
kubectl delete -f kubernetes/service.yaml
kubectl delete -f kubernetes/deployment.yaml

cd ~/environment/ecsdemo-crystal || exit 2
kubectl delete -f kubernetes/service.yaml
kubectl delete -f kubernetes/deployment.yaml

cd ~/environment/ecsdemo-nodejs || exit 3
kubectl delete -f kubernetes/service.yaml
kubectl delete -f kubernetes/deployment.yaml

export DASHBOARD_VERSION="v2.0.0"

kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/${DASHBOARD_VERSION}/src/deploy/recommended/kubernetes-dashboard.yaml

echo "DELETE THE EKSCTL CLUSTER"
#https://www.eksworkshop.com/920_cleanup/eksctl/
eksctl delete cluster --name="$clustername"

echo "CLEANUP THE WORKSPACE"
echo "Since we no longer need the Cloud9 instance to have Administrator access to our account, we can delete the workspace we created:
1. Go to your Cloud9 Environment (https://us-west-2.console.aws.amazon.com/cloud9/home)
2. Select the environment named eksworkshop and pick delete
3. Clean up your keys, go to https://us-west-2.console.aws.amazon.com/kms/home?region=us-west-2#/kms/keys and delete any keys related to your IAM accont"
