#!/bin/bash
set -o xtrace

/etc/eks/bootstrap.sh ${cluster_name} \
    --b64-cluster-ca ${cluster_ca_data} \
    --apiserver-endpoint ${endpoint} \
    --container-runtime containerd
