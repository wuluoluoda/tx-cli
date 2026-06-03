# tx-cli

<p align="center">
  <strong>Four terminal agents, one tiny command.</strong><br>
  Register a CLI once, then launch it in a 2x2 iTerm2 workspace.
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
curl -fsSL https://raw.githubusercontent.com/wuluoluoda/tx-cli/main/install.sh | sh
```

Or download first, then run:

```sh
curl -fsSLO https://raw.githubusercontent.com/wuluoluoda/tx-cli/main/install.sh
sh install.sh
```

The installer places `tx` in `~/.local/bin` and adds that directory to your shell PATH when needed.
It also pins the installed `tx` script to a detected Python 3 runtime.

Packaged release:

```sh
curl -L https://github.com/wuluoluoda/tx-cli/releases/download/v0.1.1/tx-cli-0.1.1.tar.gz -o tx-cli-0.1.1.tar.gz
```

## Quick Start

```sh
tx add claude -cc
tx add codex -cx
tx list
tx cc
```

`tx cc` opens iTerm2, creates a 2x2 split layout, and runs `claude` in all four panes.

## Commands

```sh
tx add <name> -<alias>
tx add <name> --alias <alias>
tx add <name> -<alias> -- <command ...>
tx list
tx help
tx version
tx <alias>
```

Examples:

```sh
tx add claude -cc
tx add codex -cx
tx add codex-full -cf -- codex --dangerously-bypass-approvals-and-sandbox
```

## Registry

Registered shortcuts are stored at:

```text
~/.config/tx/commands.json
```

## Requirements

- macOS
- iTerm2
- Python 3

## Why

Some CLIs are better as a small control room: one pane for the main task, one for experiments, one for logs, one for a second opinion. `tx` makes that setup repeatable without turning it into a ceremony.
