#!/usr/bin/env bats

load ../k8s-euft/env
load common

@test "Deploying Prometheus exporter helm chart" {
    helm upgrade --install --force --values tests/configs/exporter-node.yaml exporter-node kubernetes
}

@test "Ensuring exporters are running" {
    check_pod_is_running daemonset "-l app=exporter-node" exporter-node
}