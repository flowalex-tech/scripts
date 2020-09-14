#!/bin/bash

read -rp "Please enter your AWS IAM role (eg. workshop-name): " role

echo "INSTALL KUBERNETES TOOLS"
#https://www.eksworkshop.com/020_prerequisites/k8stools/

sudo curl --silent --location -o /usr/local/bin/kubectl \
  https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.7/2020-07-08/bin/linux/amd64/kubectl

sudo chmod +x /usr/local/bin/kubectl

sudo pip install --upgrade awscli && hash -r

sudo yum -y install jq gettext bash-completion moreutils

echo 'yq() {
  docker run --rm -i -v "${PWD}":/workdir mikefarah/yq yq "$@"
}' | tee -a ~/.bashrc && source ~/.bashrc

for command in kubectl jq envsubst aws
  do
    which $command &>/dev/null && echo "$command in path" || echo "$command NOT FOUND"
  done

kubectl completion bash >>  ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion

echo 'export ALB_INGRESS_VERSION="v1.1.8"' >>  ~/.bash_profile
.  ~/.bash_profile
echo
echo "CREATE AN IAM ROLE FOR YOUR WORKSPACE"
#https://www.eksworkshop.com/020_prerequisites/iamrole/
echo "1. Follow this link to create an IAM role with Administrator access.: https://console.aws.amazon.com/iam/home#/roles$new?step=review&commonUseCase=EC2%2BEC2&selectedUseCase=EC2&policies=arn:aws:iam::aws:policy%2FAdministratorAccess
2. Confirm that AWS service and EC2 are selected, then click Next to view permissions.
3. Confirm that AdministratorAccess is checked, then click Next: Tags to assign tags.
4. Take the defaults, and click Next: Review to review.
5. Enter $role for the Name, and click Create role."
echo 
echo "ATTACH THE IAM ROLE TO YOUR WORKSPACE"
#https://www.eksworkshop.com/020_prerequisites/ec2instance/
echo "1. Follow this link to find your Cloud9 EC2 instance: https://console.aws.amazon.com/ec2/v2/home?#Instances:tag:Name=aws-cloud9-.*workshop.*;sort=desc:launchTime
2. Select the instance, then choose Actions / Instance Settings / Attach/Replace IAM Role
3. Choose $role from the IAM Role drop down, and select Apply"
read -rp "Have you attached your IAM role ($role) to your workspace? Y/N: " -n 1
echo
if [[! $REPLY =~ ^[yes|y|YES|Yes|Y]$]] 
then
    echo "exiting"
    exit 1 || return 1
fi
echo "UPDATE IAM SETTINGS FOR YOUR WORKSPACE"
#https://www.eksworkshop.com/020_prerequisites/workspaceiam/

rm -vf ${HOME}/.aws/credentials

export ACCOUNT_ID=$(aws sts get-caller-identity --output text --query Account)
export AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')

test -n "$AWS_REGION" && echo AWS_REGION is "$AWS_REGION" || echo AWS_REGION is not set
sleep 10s

echo "export ACCOUNT_ID=${ACCOUNT_ID}" | tee -a ~/.bash_profile
echo "export AWS_REGION=${AWS_REGION}" | tee -a ~/.bash_profile
aws configure set default.region ${AWS_REGION}
aws configure get default.region

aws sts get-caller-identity --query Arn | grep $role -q && echo "IAM role valid" || echo "IAM role NOT valid"
sleep 10s

echo "CLONE THE SERVICE REPOS"
#https://www.eksworkshop.com/020_prerequisites/clone/

cd ~/environment
git clone https://github.com/brentley/ecsdemo-frontend.git
git clone https://github.com/brentley/ecsdemo-nodejs.git
git clone https://github.com/brentley/ecsdemo-crystal.git

echo "CREATE AN SSH KEY"
#https://www.eksworkshop.com/020_prerequisites/sshkey/
echo "press enter 3 times"
ssh-keygen

aws ec2 import-key-pair --key-name "eksworkshop" --public-key-material file://~/.ssh/id_rsa.pub
aws ec2 import-key-pair --key-name "eksworkshop" --public-key-material fileb://~/.ssh/id_rsa.pub

echo "CREATE AN AWS KMS CUSTOM MANAGED KEY (CMK)"
#https://www.eksworkshop.com/020_prerequisites/kmskey/

aws kms create-alias --alias-name alias/eksworkshop --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
export MASTER_ARN=$(aws kms describe-key --key-id alias/eksworkshop --query KeyMetadata.Arn --output text)
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile

echo "PREREQUISITES"
#https://www.eksworkshop.com/030_eksctl/prerequisites/

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp

sudo mv -v /tmp/eksctl /usr/local/bin

eksctl version
sleep 10s

eksctl completion bash >> ~/.bash_completion
. /etc/profile.d/bash_completion.sh
. ~/.bash_completion
