# border0-connector

Helm chart to deploy the Border0 Connector


## Usage

Add this Helm repository:

```bash
helm repo add border0 https://borderzero.github.io/helm-charts
```

Then install the chart with your configuration overrides e.g.:

```
helm install border0-connector border0/border0-connector \
  --set config.token="eyJhbGciOiJIUzI1NiIsIn..."
```

Note: The chart uses the Helm release namespace for namespaced resources. Set the namespace with `--namespace`.
