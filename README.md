# My Dotfiles: A Comprehensive Framework

This repository contains a highly modular and customizable set of dotfiles for creating a powerful and "cool-looking" development environment on a Linux machine.

## Features

-   **Hyper-Modular Structure:** Configurations are broken down into small, single-purpose files, making them easy to manage and extend.
-   **Themable Shell Prompt:** A themable `bash` prompt with Git integration.
-   **Rich Arsenal of Aliases and Functions:** A large collection of aliases and functions to speed up your workflow.
-   **Comprehensive Tool Configurations:** Default configurations for a wide range of common CLI tools like `vim`, `tmux`, `htop`, and `bat`.
-   **Automated Installation:** A non-interactive installation script to get you up and running in minutes.

## Prerequisites

Before you begin, ensure you have `git` installed on your system.

```bash
sudo apt-get update && sudo apt-get install -y git
```

## Installation

To install these dotfiles, clone this repository and run the `install.sh` script from the `install` directory:

```bash
git clone git@github.com:ByteQuester/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install/install.sh
```

The installer will:
1.  Install a comprehensive list of command-line tools.
2.  Create symbolic links for all your dotfiles and configurations.

## Structure

Your dotfiles are organized into the following directories:

-   **`bin/`**: Your custom executable scripts and utilities.
-   **`shell/`**: The heart of your shell environment.
    -   `aliases/`: All your command aliases, categorized by tool.
    -   `functions/`: Your custom shell functions.
    -   `prompt/`: Your themable shell prompt.
    -   `exports.sh`: Your environment variables.
    -   `main.sh`: The main entry point for your shell setup.
-   **`config/`**: Configuration files for your favorite tools.
-   **`install/`**: The installation scripts for your dotfiles.

## Customization

### Prompt Theming

You can change your shell prompt's theme by setting the `DOTFILES_THEME` variable in your `shell/exports.sh` file. The available themes are:

-   `default`
-   `powerline`
-   `minimal`

After changing the theme, open a new terminal to see the changes.

### Adding Your Own Customizations

-   **Aliases:** To add new aliases, create a new file with a `.sh` extension in the `shell/aliases/` directory. Your new aliases will be loaded automatically.
-   **Functions:** To add new functions, create a new file with a `.sh` extension in the `shell/functions/` directory. Your new functions will be loaded automatically.
-   **Exports:** To add new environment variables, add them to the `shell/exports.sh` file.

## Included Tools

The `install_tools.sh` script will install the following tools for you:

-   `htop`: Interactive process viewer.
-   `jq`: A command-line JSON processor.
-   `fzf`: A command-line fuzzy finder.
-   `tree`: Visualize directory structures.
-   `unzip`: For uncompressing zip files.
-   `curl` & `wget`: For downloading files.
-   `ripgrep` (rg): A very fast and powerful alternative to `grep`.
-   `bat`: A `cat` clone with syntax highlighting.
-   `exa`: A modern replacement for `ls`.
-   `tldr`: Simplified and community-driven man pages.
-   `tmux`: A terminal multiplexer.
-   `silversearcher-ag` (ag): A code-searching tool similar to `ack`.
-   `ncdu`: A disk usage analyzer with an ncurses interface.

## Usage Examples

### Aliases

-   `..`: Go up one directory.
-   `...`: Go up two directories.
-   `ll`: List files in long format with human-readable sizes.
-   `la`: List all files, including hidden ones.
-   `g`: A shortcut for `git`.
-   `gs`: Get a short status of your git repository.
-   `glog`: A beautiful and compact git log.

### Functions

-   `mkcd <dir>`: Create a directory and change into it.
-   `extract <file>`: Extract any archive file.
-   `backup <file_or_dir>`: Create a gzipped tarball of a file or directory.
