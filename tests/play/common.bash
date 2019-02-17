#!/usr/bin/env bash

#set -x

num_nodes_set() {
    echo "Ensure number of nodes is set: $NUM_NODES"
    [ ! -z $NUM_NODES ]
}

num_nodes_are_labeled_as_node() {
    label='node-role.kubernetes.io/node=true'

    for i in $(seq 1 $NUM_NODES) ; do
        if [ $(kubectl get nodes --show-labels | grep kube-node-$i | grep $label | wc -l) == 0 ] ; then
            kubectl label nodes kube-node-$i node-role.kubernetes.io/node=true --overwrite
        fi
    done
}

delete_helm_chart() {
    RUNNING_PODS=-1
    POD_FILTERS="-l app=exporter-node"

    helm delete --purge exporter-node
    while [ "$RUNNING_PODS" != '0' ] ; do
        sleep 5
        RUNNING_PODS=$(kubectl get pod $POD_FILTERS | grep exporter-node | wc -l)
        echo "Couchbase running nodes: $RUNNING_PODS/$NUM_NODES, waiting..." >&3
    done
}