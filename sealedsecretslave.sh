#!/bin/bash

source_context=""
source_namespace=""
destination_context=""
destination_namespace=""

echo ""
echo "#### SEALED SECRET SLAVE ###"
echo ""

# Evaluate flags
while [[ $# -gt 0 ]]; do
  case $1 in
    -sc)
      source_context="$2"
      shift 2
      ;;
    -sn)
      source_namespace="$2"
      shift 2
      ;;
    -dc)
      destination_context="$2"
      shift 2
      ;;
    -dn)
      destination_namespace="$2"
      shift 2
      ;;
    -r)
      retain_cleartext_secrets=1
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

if [ -z "$source_context" ]; then
  contexts=$(kubectl config get-contexts -o name)
#  echo "Available contexts:"
#  echo "$contexts" | tr ' ' '\n' | column
  read -p "Enter source context: " source_context
  if ! echo "$contexts" | grep -q "^$source_context$"; then
    echo "Invalid context selected."
    exit 1
  fi
fi

echo ""

if [ -z "$source_namespace" ]; then
  kubectl config use-context "$source_context"
  namespaces=$(kubectl get namespace -o name | sed 's/namespace\///')
#  echo "Available namespaces:"
#  echo "$namespaces" | tr ' ' '\n' | column
  read -p "Enter source namespace: " source_namespace
  if ! echo "$namespaces" | grep -q "^$source_namespace$"; then
    echo "Invalid namespace selected."
    exit 1
  fi
fi

echo ""

if [ -z "$destination_context" ]; then
#  echo "Available contexts:"
#  echo "$contexts" | tr ' ' '\n' | column
  read -p "Enter destination context: " destination_context
  if ! echo "$contexts" | grep -q "^$destination_context$"; then
    echo "Invalid context selected."
    exit 1
  fi
fi

echo ""

if [ -z "$destination_namespace" ]; then
#  kubectl config use-context "$destination_context"
#  namespaces=$(kubectl get namespace -o name | sed 's/namespace\///')
#  echo "Available namespaces:"
#  echo "$namespaces" | tr ' ' '\n' | column
  read -p "Enter destination namespace: " destination_namespace
#  if ! echo "$namespaces" | grep -q "^$destination_namespace$"; then
#    echo "Invalid namespace selected."
#    exit 1
#  fi
fi

echo ""

# Retrieve & filter secrets
#kubectl config use-context "$source_context"
for secret_name in $(kubectl get secret -n "$source_namespace" -o jsonpath='{.items[*].metadata.name}');
do
  if [[ "$secret_name" != *"helm.release"* ]]; then # remove helm release secrets
    kubectl get secret "$secret_name" -n "$source_namespace" -o yaml | \
    yq eval 'del(.metadata.creationTimestamp, .metadata.resourceVersion, .metadata.uid) |
    .metadata.namespace = "'"$destination_namespace"'"' - > "$secret_name.yaml" # remove superfluous metadata and adjust namespace
  fi
done

# Recrypt and delete cleartext secrets (unless -r is set)
#kubectl config use-context $destination_context
#for secret in




# todo: recrypt to correct destination ns and context
# todo: push to repo
# todo: convert to installable brew package
# todo: create tap
# todo: allow multiple namespaces?