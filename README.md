# My NVIM Setup

This is my nvim setup which was built from source, adding each configuration, options, mappings and plugins manually
rather than using flavors. Why? Well so this way I have more control on nvim's behaviour and it'll work exactly how I
need.

## Dependencies

Here are what you need to install locally for a Unix like OS, in order to have it working properly:

### Linux

#### From package manager

Here is an example considering Ubuntu with `apt` as package manager:

```bash
sudo apt update -y && sudo apt install -y \
build-essential \
make \
libssl-dev \
zlib1g-dev \
libbz2-dev \
libreadline-dev \
libsqlite3-dev \
libncursesw5-dev \
xz-utils \
tk-dev \
libxml2-dev \
libxmlsec1-dev \
libffi-dev \
liblzma-dev \
unzip \
zip \
wget \
curl \
llvm \
fd-find \
ninja-build \
gettext \
cmake \
curl \
ripgrep \
gh \
```

> [!NOTE]
> - ripgrep is required for [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin;
> - Github CLI is required for [Octo](https://github.com/pwntester/octo.nvim) plugin;

#### NodeJS

Since NodeJS is also required, here is an example using `nvm`:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
```

Then source the terminal `~/.bashrc` or `~/.zshrc`;
Check for the version `nvm --version`;
List and install a version:
```bash
nvm ls-remote
nvm install <THE_CHOSEN_VERSION>
```
Set the version as the default one `nvm default <THE_CHOSEN_VERSION>`.

#### Python

- Install using curl with the command `curl https://pyenv.run | bash`
- Add these environment variable into `~/.bashrc` or `~/.zshrc`:

```bash
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"   
```

- Source the terminal `source ~/.bashrc` or `source ~/.zshrc`.
- List, install and set the default python version:

```bash
pyenv install --list
pyenv install <THE_CHOSEN_VERSION>
pyenv global <THE_CHOSEN_VERSION>
```

#### Java

- Install SDK Man with this command `curl -s "https://get.sdkman.io" | bash`, so it'll be easier to manage
  different versions.
- After installation completes run `source "$HOME/.sdkman/bin/sdkman-init.sh"`
- Check available Java versions `sdk list java`
- Install one of them, e.g., `sdk install java 21.0.11-tem`


### Nvim

When using Linux either via main computer OS or WSL, using the tarball is preferred, since you'll get more up-to-date
release. Take a look at [Neovim's GitHub project release list][^1] to get the latest one.

Use these commands to install replacing `${VERSION}` by the version you chose from the release list:

```bash
curl -LO https://github.com/neovim/neovim/releases/download/${VERSION}/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo mv /opt/nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
```

Then check for the version with the command `nvim --version`.

## Mappings

<!-- TODO: Add how mappings are setup -->

🏗️ **This document is still a work in progress** 🏗️

[^1]: https://github.com/neovim/neovim/releases
