# shell_script

通用 shell 小脚本。状态栏相关在 `status/`（stdout 一行，供 dwmblocks / tmux 等调用）。

## status/

| 脚本 | 作用 |
|------|------|
| `sb-fcitx` | fcitx5：拼 / 五 / En |
| `sb-datetime` | `%A %m-%d %H:%M:%S` |

安装到 `PREFIX/bin`（须在 PATH）：

```bash
./install.sh          # → /usr/local/bin（需 sudo/doas）
./install.sh --user   # → ~/.local/bin
```
