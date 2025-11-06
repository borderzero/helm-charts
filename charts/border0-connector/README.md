# border0-connector

Helm chart to deploy the Border0 Connector

## Installation

Add this Helm repository:

```bash
helm repo add border0 https://borderzero.github.io/helm-charts
helm repo update
```

### Using an Invite Code (preferred)

Get an invite code from the Border0 admin portal connectors page, then:

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE_HERE"
```

The connector will exchange the invite code for a token and persist it in a Kubernetes secret automatically.

### Using a Pre-Generated Token

```bash
helm install border0-connector border0/border0-connector \
  --set config.token="eyJhbGciOiJIUzI1NiIsIn..."
```

## Advanced Configuration

### Custom Container Image

To run a custom container image:

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set image.override="ghcr.io/borderzero/border0:dev"
```

### RBAC Modes

The chart supports two RBAC modes for cluster-level permissions:

#### api-admin (default)
Full cluster access for Border0 sockets that require Kubernetes API access. This grants wildcard permissions across the cluster.

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set rbac.clusterRoleMode="api-admin"
```

#### none
No cluster-level permissions. Use this when you don't need cluster-wide access.

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set rbac.clusterRoleMode="none"
```

**Note:** When using invite codes, a namespaced Role for secret management is always created regardless of the `clusterRoleMode` setting.

### Custom Namespace

The chart uses the Helm release namespace for namespaced resources. Set the namespace with `--namespace`:

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --namespace "YOUR_CUSTOM_NS" --create-namespace
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `config.token` | string | `""` | Connector token (use this OR inviteCode) |
| `config.inviteCode` | string | `""` | Invite code for automatic token exchange (recommended) |
| `image.repository` | string | `"ghcr.io/borderzero/border0"` | Container image repository |
| `image.tag` | string | `"latest"` | Container image tag |
| `image.pullPolicy` | string | `"Always"` | Image pull policy |
| `image.override` | string | `null` | Override the full image reference |
| `serviceAccount.name` | string | `""` | Service account name (auto-generated if empty) |
| `rbac.clusterRoleMode` | string | `"api-admin"` | ClusterRole mode: "api-admin" or "none" |
| `rbac.name` | string | `""` | ClusterRole name (auto-generated if empty) |
