#!/usr/bin/env bats

load ../k8s-euft/env
load common

@test "Delete helm chart and ensure cluster is stopped" {
    delete_helm_chart
}