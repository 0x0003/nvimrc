## Prerequisites
- neovim **0.10+**
- gnumake
- gcc
- fzf
- fd
- rg

### Configured language servers
| server        | ad-hoc install                                             |
| ------------- | ---------------------------------------------------------- |
| hls           | `ghcup install hls recommended`                            |
| nil           | `nix profile install nixpkgs#nil`                          |
| lua_ls        | `nix profile install nixpkgs#lua-language-server`          |
| html,css,json | `nix profile install nixpkgs#vscode-langservers-extracted` |
| ts_ls         | `npm install -g typescript-language-server typescript`     |

