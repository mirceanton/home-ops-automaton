#!/bin/bash
set -e

# Default values
CLUSTER_NAME="${1}"
NAMESPACE="${2:-capi-system}"

# Validate arguments
if [ -z "$CLUSTER_NAME" ]; then
  echo "Error: Cluster name is required"
  echo "Usage: $0 <cluster-name> [namespace]"
  exit 1
fi

echo "Fetching configs for cluster '${CLUSTER_NAME}' in namespace '${NAMESPACE}'..."

# Fetch Kubeconfig
echo "Fetching kubeconfig..."
if kubectl get secret -n "${NAMESPACE}" "${CLUSTER_NAME}-kubeconfig" &>/dev/null; then
  kubectl get secret -n "${NAMESPACE}" "${CLUSTER_NAME}-kubeconfig" \
    -o jsonpath='{.data.value}' | base64 -d > "kubeconfig-${CLUSTER_NAME}.yaml"
  chmod 600 "kubeconfig-${CLUSTER_NAME}.yaml"
  echo "✓ Kubeconfig saved to: kubeconfig-${CLUSTER_NAME}.yaml"
else
  echo "✗ Kubeconfig secret '${CLUSTER_NAME}-kubeconfig' not found in namespace '${NAMESPACE}'"
fi

# Fetch Talosconfig
echo "Fetching talosconfig..."
if kubectl get secret -n "${NAMESPACE}" "${CLUSTER_NAME}-talosconfig" &>/dev/null; then
  kubectl get secret -n "${NAMESPACE}" "${CLUSTER_NAME}-talosconfig" \
    -o jsonpath='{.data.talosconfig}' | base64 -d > "talosconfig-${CLUSTER_NAME}.yaml"
  chmod 600 "talosconfig-${CLUSTER_NAME}.yaml"
  echo "✓ Talosconfig saved to: talosconfig-${CLUSTER_NAME}.yaml"
else
  echo "✗ Talosconfig secret '${CLUSTER_NAME}-talosconfig' not found in namespace '${NAMESPACE}'"
fi

echo ""
echo "To use these configs:"
echo "  export KUBECONFIG=\$(pwd)/kubeconfig-${CLUSTER_NAME}.yaml"
echo "  export TALOSCONFIG=\$(pwd)/talosconfig-${CLUSTER_NAME}.yaml"
