#!/bin/sh
set -e
ROOT="$(cd "$(dirname "$0")" && pwd)"
MODE=system
for arg in "$@"; do
	case "$arg" in
	--user) MODE=user ;;
	-h|--help)
		echo "用法: $0 [--user]"
		exit 0
		;;
	*)
		echo "未知参数: $arg" >&2
		exit 1
		;;
	esac
done

run_root() {
	if [ "$(id -u)" -eq 0 ]; then
		"$@"
	elif command -v doas >/dev/null 2>&1; then
		doas "$@"
	elif command -v sudo >/dev/null 2>&1; then
		sudo "$@"
	else
		echo "需要 root（doas/sudo）" >&2
		exit 1
	fi
}

install_glob() {
	# $1=dest $2=glob  $3=root?
	dest=$1
	glob=$2
	as_root=${3:-0}
	for s in $glob; do
		[ -f "$s" ] || continue
		base=$(basename "$s")
		if [ "$as_root" = 1 ]; then
			run_root install -m 755 "$s" "$dest/$base"
		else
			install -m 755 "$s" "$dest/$base"
		fi
		echo "installed $dest/$base"
	done
}

if [ "$MODE" = user ]; then
	dest="$HOME/.local/bin"
	mkdir -p "$dest"
	install_glob "$dest" "$ROOT/status/sb-*" 0
	install_glob "$dest" "$ROOT/media/*" 0
else
	dest=/usr/local/bin
	run_root mkdir -p "$dest"
	install_glob "$dest" "$ROOT/status/sb-*" 1
	install_glob "$dest" "$ROOT/media/*" 1
fi
