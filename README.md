# Helm-Charts

Border0 managed Helm charts:

| Chart Name           | Description                            |
|----------------------|----------------------------------------|
| [tailzero-connector](./charts/tailzero-connector) | Helm chart to deploy the Tailzero Connector (Tailscale-enabled) |
| [border0-connector](./charts/border0-connector) | ~~Helm chart to deploy the Border0 Connector~~ **(deprecated)** |

## tailzero-connector

For Tailscale-enabled organizations. The connector exchanges an invite code for credentials (connector token + Tailscale auth key) and persists them in a Kubernetes secret automatically.

Add this Helm repository:

```bash
helm repo add border0 https://borderzero.github.io/helm-charts
helm repo update
```

Get an invite code from the Border0 admin portal connectors page, then:

```bash
helm install tailzero-connector border0/tailzero-connector \
  --set config.inviteCode="YOUR_INVITE_CODE_HERE"
```

### Advanced Configuration

To run a custom container image:

```bash
helm install tailzero-connector border0/tailzero-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set image.override="ghcr.io/borderzero/tailzero:dev"
```

To set a custom hostname (defaults to the Helm release name):

```bash
helm install tailzero-connector border0/tailzero-connector \
  --set config.inviteCode="YOUR_INVITE_CODE" \
  --set config.hostname="my-connector"
```

**Note:** The chart uses the Helm release namespace for namespaced resources. Set the namespace with `--namespace <namespace> --create-namespace`.

### Upgrading

#### When Using `image.tag: latest` (Default)

Restart the deployment to pull the latest image:

```bash
kubectl --namespace "YOUR_NS" rollout restart deployment tailzero-connector
```

#### When Using a Specific Image Tag

```bash
helm upgrade tailzero-connector border0/tailzero-connector \
  --namespace "YOUR_NS" \
  --reuse-values \
  --set image.tag="v1.2.3"
```

---

## border0-connector (deprecated)

> **Deprecated:** Use `border0/tailzero-connector` for new installations.

### Using an Invite Code (preferred)

```bash
helm install border0-connector border0/border0-connector \
  --set config.inviteCode="YOUR_INVITE_CODE_HERE"
```

### Using a Pre-Generated Token

```bash
helm install border0-connector border0/border0-connector \
  --set config.token="eyJhbGciOiJIUzI1NiIsIn..."
```

### Advanced Configuration

```bash
helm install border0-connector border0/border0-connector \
  --set image.override="ghcr.io/borderzero/border0:dev" \
  [ your other flags e.g. invite code OR token, etc... ]
```

### Upgrading

#### When Using `image.tag: latest` (Default)

```bash
kubectl --namespace "YOUR_CUSTOM_NS" rollout restart deployment border0-connector
```

#### When Using a Specific Image Tag

```bash
helm upgrade border0-connector border0/border0-connector \
  --namespace "YOUR_CUSTOM_NS" \
  --reuse-values \
  --set image.tag="v1.2.3"
```
