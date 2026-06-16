# tx-cli

<p align="center">
  <strong>Four terminal agents, one tiny command.</strong><br>
  Register a CLI once, then launch it in a 2x2 tmux workspace inside Ghostty or iTerm2.
</p>

<p align="center">
  <code>tx add claude -cc</code> -> <code>tx cc</code><br>
  <code>tx add codex -cx</code> -> <code>tx cx</code>
</p>

<p align="center">
  <a href="./README.zh-CN.md">中文说明</a>
</p>

## Install

One-line install:

```sh
curl -fsSL https://raw.githubusercontent.com/wuluoluoda/tx-cli/v0.1.5/install.sh | sh
```

Or download first, then run:

```sh
curl -fsSLO https://raw.githubusercontent.com/wuluoluoda/tx-cli/v0.1.5/install.sh
sh install.sh
```

The installer places `tx` in `~/.local/bin` and adds that directory to your shell PATH when needed.
It also pins the installed `tx` script to a detected Python 3 runtime.

Packaged release:

```sh
curl -L https://github.com/wuluoluoda/tx-cli/releases/download/v0.1.5/tx-cli-0.1.5.tar.gz -o tx-cli-0.1.5.tar.gz
```

## Quick Start

```sh
tx add claude -cc
tx terminal ghostty
tx add codex -cx
tx list
tx claude
tx cc
```

`tx add claude -cc` registers both `tx claude` and `tx cc`. Either command opens your configured terminal, starts a tmux session, creates a 2x2 pane layout, enters the directory where you ran `tx`, and runs `claude` in all four panes.

## Terminal

`tx` can launch either Ghostty or iTerm2:

```sh
tx terminal ghostty
tx terminal iterm2
tx terminal auto
```

You can also override it once:

```sh
tx --terminal ghostty cc
tx --terminal iterm2 cc
```

`auto` uses your current terminal when it can detect one, otherwise it prefers Ghostty when `/Applications/Ghostty.app` exists.

## Commands

```sh
tx add <name>
tx add <name> -<alias>
tx add <name> --alias <alias>
tx add <name> -<alias> -- <command ...>
tx list
tx terminal auto|ghostty|iterm2
tx help
tx version
tx <alias>
```

Examples:

```sh
tx add claude -cc
tx add codex -cx
tx add codex-full -cf -- codex --dangerously-bypass-approvals-and-sandbox
tx claude
tx cc
```

## Registry

Registered shortcuts are stored at:

```text
~/.config/tx/commands.json
```

## Requirements

- macOS
- Ghostty or iTerm2
- tmux
- Python 3

## Why

Some CLIs are better as a small control room: one pane for the main task, one for experiments, one for logs, one for a second opinion. `tx` uses tmux for the repeatable layout while keeping your terminal as the place you work.
