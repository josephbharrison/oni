# Oni

A cross-platform personalized development evironment (PDE)

![desktop][desktop]

## Installation

### Mac OS

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/josephbharrison/oni/HEAD/macos-install.sh)"
```

### Linux
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/josephbharrison/oni/HEAD/linux-install.sh)"
```

## Includes

- [**NeoVim**](https://neovim.io) A highly customized variant of [AstroNvim](https://astronvim.github.io) NeoVim
- [**WezTerm**](https://wezfurlong.org/wezterm/)
- [**tmux**](https://github.com/tmux/tmux/wiki)
- [**Language Servers:**](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)
  - [C](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#clangd)
  - [Go](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls)
  - [Node](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver)
  - [Python](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
  - [Rust](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer)
  - _Many others_ (Bash, Docker, Lua, Make, Protobuf, ...)
- [**Themes:**](https://github.com/topics/neovim-theme)
  - [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim) (default)
  - [folke/tokyonight](https://github.com/folke/tokyonight.nvim)
  - [Shatur/neovim-ayu](https://github.com/Shatur/neovim-ayu)
  - [EdenEast/nightfox.nvim](https://github.com/EdenEast/nightfox.nvim)
  - [astronvim](https://astronvim.github.io)
- [**NerdFonts:**](https://www.nerdfonts.com)
  - [hack](https://www.programmingfonts.org/#hack) (default)
  - [mononoki](https://www.programmingfonts.org/#mononoki)
  - [go-mono](https://www.programmingfonts.org/#go-mono)
  - [jetbrains-mono](https://www.programmingfonts.org/#jetbrains-mono)

## User Guide

```sh
nvim +Tutor
```

## Key Mappings

To view 'lead' mappings, open **nvim** and press `<Space>`:

![mappings][mappings]

> The `<Space>` key is the default _maplead_, change with: `vim.g.maplead = "<key>"`

### Navigation:

| Key Mapping  | Description                   |
| ------------ | ----------------------------- |
| `<Space>` e  | Toggle explorer (tree view)   |
| `<Space>` ff | Fuzzy finder (find/open file) |
| `<Shift>` l  | Next buffer (tab)             |
| `<Shift>` h  | Prev buffer (tab)             |
| `<Ctrl>` l   | Next window, right            |
| `<Ctrl>` h   | Next window, left             |
| `<Ctrl>` j   | Next window, down             |
| `<Ctrl>` k   | Next window, up               |

## Configuration

- **Languages:** `:LspInstall [language]`
- **Linters:** `:MasonInstall <linter>`
- **Formatters:** `:MasonInstall <formatter>`
- **Fonts:** `brew install --cask font-<font>-nerd-font`

### Advanced Configuration:

Update the _user_ configuration file: `~/.config/nvim/lua/user/init.lua`

> See [AstroNvim - Managing User Configuration](https://astronvim.github.io/Configuration/manage_user_config)

## Screenshots

![desktop2][desktop2]
![screen][screen]

[desktop]: https://raw.githubusercontent.com/josephbharrison/oni/main/images/desktop.png
[desktop2]: https://raw.githubusercontent.com/josephbharrison/oni/main/images/desktop2.png
[screen]: https://raw.githubusercontent.com/josephbharrison/oni/main/images/screen.png
[mappings]: https://raw.githubusercontent.com/josephbharrison/oni/main/images/mappings.png

# oni
