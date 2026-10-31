# shell_script

通用 shell 小脚本。

- `status/`：状态栏一行输出（dwmblocks / tmux 等）
- `media/`：音量 / 屏幕亮度 / 键盘背光（带 `notify-send`，供 dwm、tmux、命令行复用）

## status/

| 脚本 | 作用 |
|------|------|
| `sb-fcitx` | fcitx5：拼 / 五 / En |
| `sb-volume` | 音量 Nerd 图标 + %（`wpctl`；无则空） |
| `sb-battery` | 电池图标 + 电量%（无 BAT* 则空输出） |
| `sb-datetime` | `%A %m-%d %H:%M:%S` |

## media/

| 脚本 | 用法 | 依赖 |
|------|------|------|
| `vol` | `vol up\|down\|mute` | `wpctl`；可选 `notify-send` |
| `bright` | `bright up\|down` | `brightnessctl`；可选 `notify-send` |
| `kbdbl` | `kbdbl up\|down` | `brightnessctl`；设备默认 `smc::kbd_backlight`（`KBD_BACKLIGHT_DEVICE` 可覆盖） |

安装到 `PREFIX/bin`（须在 PATH）：

```bash
./install.sh          # → /usr/local/bin（需 sudo/doas）
./install.sh --user   # → ~/.local/bin
```

测试（图形会话内，通知靠 dunst）：

```bash
vol up
bright down
kbdbl up    # 非 Apple / 无该 LED 会报错退出
```
