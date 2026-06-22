## Prerequisites
- neovim **0.12+**
- tree-sitter-cli
- gcc
- fzf
- fd
- rg

### Configured language servers
| server          | ad hoc installation                                        |
| --------------- | ---------------------------------------------------------- |
| hls             | `ghcup install hls recommended`                            |
| nil             | `nix profile install nixpkgs#nil`                          |
| lua_ls          | `nix profile install nixpkgs#lua-language-server`          |
| html, css, json | `nix profile install nixpkgs#vscode-langservers-extracted` |
| ts_ls           | `npm install -g typescript-language-server typescript`     |

---

![screenshot](https://github.com/user-attachments/assets/faaebdaf-433c-467e-946e-ea966f46f043)

