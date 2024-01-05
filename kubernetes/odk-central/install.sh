#!/usr/bin/env bash

export SANDBOX_HOSTNAME=${SANDBOX_HOSTNAME:-openg2p.sandbox.net}
export ODK_HOSTNAME=${ODK_HOSTNAME:-odk.$SANDBOX_HOSTNAME}

NS=odk

helm repo add openg2p https://openg2p.github.io/openg2p-helm
helm repo update

echo Create $NS namespace
kubectl create ns $NS

./copy_secrets.sh

helm -n $NS install odk-central openg2p/odk-central --wait --set global.hostname=$ODK_HOSTNAME $@
