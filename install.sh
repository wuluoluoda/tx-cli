#!/usr/bin/env sh
set -eu

REPO="wuluoluoda/tx-cli"
BRANCH="${TX_BRANCH:-v0.1.4}"
INSTALL_DIR="${TX_INSTALL_DIR:-$HOME/.local/bin}"
BIN="$INSTALL_DIR/tx"
RAW_BASE="https://raw.githubusercontent.com/$REPO/$BRANCH"

say() {
  printf '%s\n' "$*"
}

need() {
  command -v "$1" >/dev/null 2>&1 || {
    say "tx install: missing required command: $1" >&2
    exit 1
  }
}

find_python() {
  if [ -n "${TX_PYTHON:-}" ]; then
    printf '%s\n' "$TX_PYTHON"
    return
  fi
  for candidate in /opt/homebrew/bin/python3 /usr/local/bin/python3; do
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return
    fi
  done
  command -v python3 2>/dev/null || true
}

download() {
  url="$1"
  dest="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$dest"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$dest" "$url"
  else
    say "tx install: curl or wget is required" >&2
    exit 1
  fi
}

install_tx() {
  script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
  if [ -f "$script_dir/bin/tx" ]; then
    cp "$script_dir/bin/tx" "$BIN"
  else
    download "$RAW_BASE/bin/tx" "$BIN"
  fi
}

append_path_if_needed() {
  shell_rc="$1"
  mkdir -p "$(dirname "$shell_rc")"
  touch "$shell_rc"
  if grep -F "$INSTALL_DIR" "$shell_rc" >/dev/null 2>&1; then
    return
  fi
  {
    printf '\n# tx-cli\n'
    printf 'export PATH="%s:$PATH"\n' "$INSTALL_DIR"
  } >> "$shell_rc"
}

PYTHON_BIN="$(find_python)"
if [ -z "$PYTHON_BIN" ]; then
  say "tx install: missing required command: python3" >&2
  exit 1
fi

mkdir -p "$INSTALL_DIR"
install_tx
tmp_bin="$BIN.tmp"
{
  printf '#!%s\n' "$PYTHON_BIN"
  sed '1d' "$BIN"
} > "$tmp_bin"
mv "$tmp_bin" "$BIN"
chmod +x "$BIN"

case "${SHELL:-}" in
  */zsh)
    append_path_if_needed "$HOME/.zshrc"
    ;;
  */bash)
    append_path_if_needed "$HOME/.bashrc"
    ;;
esac

case ":$PATH:" in
  *":$INSTALL_DIR:"*) path_ready=1 ;;
  *) path_ready=0 ;;
esac

say "tx installed: $BIN"
say "python runtime: $PYTHON_BIN"
if [ "$path_ready" -eq 0 ]; then
  say "PATH updated in your shell rc file. Run this once now:"
  say "  export PATH=\"$INSTALL_DIR:\$PATH\""
fi
say ""
say "Try:"
say "  tx help"
say "  tx add claude -cc"
say "  tx cc"
