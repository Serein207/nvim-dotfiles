<h1 align="center">nvim dotfiles</h1>

<div align="center"><img src = "images/image1.png"></div>
<div align="center">
<span ><img src = "images/image2.png" width = "45%"></span>
<span><img src = "images/image3.png" width = "45%"></span>
</div>

## How to Use

1. Clone this repository to your local machine.

```bash
git clone https://github.com/Serein207/nvim-dotfiles.git ~/.config/nvim
```

2. Open your neovim and wait for the installation to complete.

```bash
nvim
```

## Use Neovide

The `lua/utils.lua` file contains the configuration for neovide, you can modify it according to your needs.

The default font is `Monaco Nerd Font Mono`, you can change it to your favorite font.

Use `<C-S-c>` and `<C-S-v>` to copy and paste text with the system clipboard.

## Key Mappings

### Basic Mappings

| Key Mapping | Description       |
| ----------- | ----------------- |
| `jj`        | Enter Normal Mode |
| `<Esc>`     | Enter Normal Mode |
| `q`         | Quit              |
| `qq`        | Quit not Save     |

### Multi Cursor

refer [here](https://github.com/mg979/vim-visual-multi)

### Copilot

type `: CopilotAuth` to use copilot

| Key Mapping | Description     |
| ----------- | --------------- |
| `<C-CR>`    | Accept One Line |
| `<A-CR>`    | Accept All      |

### Window Mappings

| Key Mapping | Description                       |
| ----------- | --------------------------------- |
| `sv`        | Split Window Vertically           |
| `sh`        | Split Window Horizontally         |
| `sc`        | Close Current Split Window        |
| `so`        | Close Other Split Window          |
| `<A-h>`     | Focus to Left Window              |
| `<A-j>`     | Focus to Down Window              |
| `<A-k>`     | Focus to Up Window                |
| `<A-l>`     | Focus to Right Window             |
| `<C-Left>`  | Reduce Window Width (2 chars)     |
| `<C-Right>` | Increase Window Width (2 chars)   |
| `<C-Up>`    | Reduce Window Height (2 chars)    |
| `<C-Down>`  | Increase Window Height (2 chars)  |
| `s,`        | Reduce Window Width (20 chars)    |
| `s.`        | Increase Window Width (20 chars)  |
| `sj`        | Reduce Window Height (10 chars)   |
| `sk`        | Increase Window Height (10 chars) |
| `s=`        | Equalize Window Size              |

### Terminal Mappings

| Key Mapping  | Description                |
| ------------ | -------------------------- |
| `<leader>t`  | Open Terminal              |
| `<leader>tf` | Open Terminal Float        |
| `<leader>th` | Open Terminal Horizontally |
| `<leader>tv` | Open Terminal Vertically   |

### Bufferline Mappings

| Key Mapping  | Description             |
| ------------ | ----------------------- |
| `<C-h>`      | Switch to Left Tab      |
| `<C-l>`      | Switch to Right Tab     |
| `<C-w>`      | Close Current Tab       |
| `<leader>bl` | Buffer Line Close Right |
| `<leader>bh` | Buffer Line Close Left  |
| `<leader>bc` | Buffer Line Close       |

### leap Mappings

| Key Mapping | Description |
| ----------- | ----------- |
| `<leader>s` | Leap        |
| `S`         | Leap Back   |
| `gs`        | Leap Window |

### NERDTree Mappings

| Key Mapping | Description                |
| ----------- | -------------------------- |
| `<A-m>`     | Toggle NERDTree            |
| `<C-v>`     | Open File in Split Window  |
| `<CR>`      | Open File or Folder        |
| `i`         | Toggle Hidden Files        |
| `.`         | Toggle Dotfiles            |
| `<F5>`      | Refresh NERDTree           |
| `a`         | Create File or Folder      |
| `d`         | Remove File or Folder      |
| `r`         | Rename File or Folder      |
| `x`         | Cut File or Folder         |
| `c`         | Copy File or Folder        |
| `p`         | Paste File or Folder       |
| `s`         | System Open File or Folder |

### Telescope Mappings

| Key Mapping         | Description                   |
| ------------------- | ----------------------------- |
| `<leader><leader>p` | Find Files                    |
| `<leader><leader>f` | Find keyword                  |
| `<leader>pp`        | Find Projects                 |
| `<leader>m`         | Find Notification or Messages |
| `<leader>L`         | Find CMake Project Files      |
| `<C-j>` `<C-k>`     | Move Cursor                   |
| `<C-u>` `<C-d>`     | Preview Scrolling             |
| `<C-n>` `<C-p>`     | History                       |
| `<C-c>`             | Close Window                  |

### Complete Menu

| Key Mapping     | Description        |
| --------------- | ------------------ |
| `<C-j>` `<C-k>` | Move Select Cursor |
| `<CR>`          | Confirm Selection  |

### LSP Mappings

| Key Mapping  | Description               |
| ------------ | ------------------------- |
| `gd`         | Go to Definition          |
| `gh`         | Hover Doc                 |
| `gf`         | Finder Def+Ref            |
| `gD`         | Go to Declaration         |
| `gi`         | Go to Implementation      |
| `gr`         | Go to References          |
| `gp`         | Show Line Diagnostics     |
| `gk`         | Go to Previous Diagnostic |
| `gj`         | Go to Next Diagnostic     |
| `<leader>r`  | Rename Symbol             |
| `<leader>f`  | Code Formatting           |
| `<leader>ca` | Code Action               |
| `<S-k>`      | Signature Help            |

### CMake Mappings

| Key Mapping | Description   |
| ----------- | ------------- |
| `<F5>`      | Build and Run |
| `<F17>`     | Stop          |

### Other Mappings

| Mode   | Key Mapping | Description           |
| ------ | ----------- | --------------------- |
| Normal | `<leader>o` | Insert a New Row Down |
| Normal | `<leader>O` | Insert a New Row Up   |
| Visual | `<`         | Indent Left           |
| Visual | `>`         | Indent Right          |
| Visual | `J`         | Select Row Down       |
| Visual | `K`         | Select Row Up         |
