#!/usr/bin/env bats

load ../k8s-euft/env
load common

@test "Ensure number of nodes is set: $NUM_NODES" {
    num_nodes_set
}

@test "Ensure nodes has correct labels" {
    num_nodes_are_labeled_as_node
}

@test "Deploy Prometheus cluster" {
  rm -Rf kubernetes-helm-chart-prometheus-operator
  git clone https://github.com/MySocialApp/kubernetes-helm-chart-prometheus-operator.git
  cd kubernetes-helm-chart-prometheus-operator
  helm upgrade --install --force --values ../tests/configs/prometheus-operator.yaml prometheus-operator kubernetes
}
