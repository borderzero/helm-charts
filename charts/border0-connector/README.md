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

### Custom Secret Name

To use a different secret name for token storage:

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set config.secretName="my-custom-secret"
```

### Custom Namespace Name

**Note:** The chart uses the Helm release namespace for namespaced resources. Set the namespace with `--namespace "YOUR_CUSTOM_NS" --create-namespace`.

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
| `config.secretName` | string | `"connector-config"` | Name of the secret for token storage |
| `image.repository` | string | `"ghcr.io/borderzero/border0"` | Container image repository |
| `image.tag` | string | `"latest"` | Container image tag |
| `image.pullPolicy` | string | `"Always"` | Image pull policy |
| `image.override` | string | `null` | Override the full image reference |
| `serviceAccount.name` | string | `"border0-connector"` | Service account name |
| `rbac.create` | bool | `true` | Create RBAC resources |
| `rbac.name` | string | `"border0-connector"` | RBAC resources name |
