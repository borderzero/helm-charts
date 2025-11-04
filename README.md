# Helm-Charts

Border0 managed Helm charts:

| Chart Name           | Description                            |
|----------------------|----------------------------------------|
| [border0-connector](./charts/border0-connector) | Helm chart to deploy the Border0 Connector |

## Usage

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

### Advanced Configuration

To run a custom container image, set `image.override` to the full image reference:

```bash
helm install border0-connector border0/border0-connector \
  --set image.override="ghcr.io/borderzero/border0:dev" \
  [ your other flags e.g. invite code OR token, etc... ]
```

**Note:** The chart uses the Helm release namespace for namespaced resources. Set the namespace with `--namespace <namespace> --create-namespace`.
