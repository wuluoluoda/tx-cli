# tx-cli

<p align="center">
  <strong>一个命令，四开你的终端 CLI。</strong><br>
  注册一次 CLI，以后用短命令在 Ghostty 或 iTerm2 里自动打开 tmux 2x2 工作区。
</p>

<p align="center">
  <code>tx add claude -cc</code> -> <code>tx cc</code><br>
  <code>tx add codex -cx</code> -> <code>tx cx</code>
</p>

<p align="center">
  <a href="./README.md">English README</a>
</p>

## 安装

一行安装：

```sh
curl -fsSL https://raw.githubusercontent.com/wuluoluoda/tx-cli/v0.1.5/install.sh | sh
```

或者先下载，再运行：

```sh
curl -fsSLO https://raw.githubusercontent.com/wuluoluoda/tx-cli/v0.1.5/install.sh
sh install.sh
```

安装脚本会把 `tx` 放到 `~/.local/bin`，并在需要时把这个目录写入你的 shell PATH。
安装时还会把 `tx` 固定到检测到的 Python 3 运行时，避免受 PATH 顺序影响。

下载打包版本：

```sh
curl -L https://github.com/wuluoluoda/tx-cli/releases/download/v0.1.5/tx-cli-0.1.5.tar.gz -o tx-cli-0.1.5.tar.gz
```

## 快速开始

```sh
tx add claude -cc
tx terminal ghostty
tx add codex -cx
tx list
tx claude
tx cc
```

`tx add claude -cc` 会同时注册 `tx claude` 和 `tx cc`。执行任意一个都会打开你配置的终端，启动一个 tmux session，自动切成 2x2 四个 pane，进入你执行 `tx` 时所在的目录，并在四个 pane 里分别启动 `claude`。

## 终端

`tx` 支持 Ghostty 和 iTerm2：

```sh
tx terminal ghostty
tx terminal iterm2
tx terminal auto
```

也可以只覆盖本次启动：

```sh
tx --terminal ghostty cc
tx --terminal iterm2 cc
```

`auto` 会优先使用当前终端；如果无法识别当前终端，并且 `/Applications/Ghostty.app` 存在，则优先使用 Ghostty。

## 命令

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

例子：

```sh
tx add claude -cc
tx add codex -cx
tx add codex-full -cf -- codex --dangerously-bypass-approvals-and-sandbox
tx claude
tx cc
```

## 注册表

快捷命令会保存到：

```text
~/.config/tx/commands.json
```

## 依赖

- macOS
- Ghostty 或 iTerm2
- tmux
- Python 3

## 这个东西解决什么

有些 CLI 很适合四开：一个 pane 跑主任务，一个 pane 做实验，一个 pane 看日志，一个 pane 备用。`tx` 用 tmux 负责稳定的四 pane 布局，终端只负责承载你的工作窗口。
