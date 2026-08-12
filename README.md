# frpc LazyCat App

This directory packages `frpc` `v0.70.1` as a LazyCat LPK v2 application for package `community.lazycat.app.frpc`.

## Runtime

- Upstream image source: `ghcr.io/fatedier/frpc:v0.70.1`
- Manifest runtime image: `ghcr.1ms.run/fatedier/frpc:v0.70.1`
- Web UI: LazyCat application domain backed by `frpc:7400`
- Persistent dynamic proxy state: `/lzcapp/var/frpc` -> `/var/lib/frp`
- Generated GitHub Release asset: `community.lazycat.app.frpc-v0.70.1.lpk`

The packaged `content/frpc.toml` is copied to `/etc/frp/frpc.toml` at startup. `frpc` itself renders the Go-template `{{ .Envs.* }}` placeholders from the injected `FRPC_*` environment variables, so the config can stay upstream-compatible and no proxy is predeclared.

## Deployment

1. Deploy `frps` first.
2. Record the `frps` server address, control port, and shared token.
3. Deploy this app and fill `FRPC_SERVER_ADDR`, `FRPC_SERVER_PORT`, and `FRPC_AUTH_TOKEN`.
4. Open the LazyCat app URL to reach the embedded `frpc` Web UI.
5. Create and manage `[[proxies]]` dynamically from the UI for your own workflows.

The Web UI binds to `0.0.0.0:7400`. LazyCat injects the Basic Authorization header with the deployment-time username and random secret password, so direct UI access works without manually typing credentials each time.

## Automation

`.github/workflows/lazycat.yml` publishes from `main`, `workflow_dispatch`, or reusable `workflow_call`. It uses mirror delivery with `require_digest_match: true`, keeps the Action image source on `ghcr.io/fatedier/frpc`, generates versioned release assets, and publishes only to the MiaoMiao private store.

Required GitHub Secrets:

- `LZC_API_TOKEN`
- `APPSTORE_URL`
- `APPSTORE_TOKEN`
- `APP_ID` (optional)
- `PRIVATE_STORE_GROUP_CODES` (optional)

## References

- https://gofrp.org/zh-cn/
- https://gofrp.org/zh-cn/docs/features/common/ui
- https://github.com/fatedier/frp
