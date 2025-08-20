# My Dotfiles

This repository contains my personal dotfiles for setting up a new development environment.

## Installation

To install these dotfiles, run the `install.sh` script from the root of this repository:

```bash
./install.sh
```

This script will back up any existing dotfiles in your home directory to `~/.dotfiles_backup` and then create symbolic links to the dotfiles in this repository.

## Project Setup

This dotfiles repository is intended to be used in conjunction with the `projects-inventory.yaml` file and the `clone_projects.sh` script, which are located in your home directory on a new machine.

The `clone_projects.sh` script automates the process of cloning all the necessary project repositories, including this `.dotfiles` repository.

### Quick Start for a New Machine

1.  **Clone this repository:**
    ```bash
    git clone git@github.com:ByteQuester/.dotfiles.git ~/.dotfiles
    ```
2.  **Run the installation script:**
    ```bash
    ~/.dotfiles/install.sh
    ```
3.  **Run the project cloning script:**
    - Make sure you have your `projects-inventory.yaml` file in your home directory.
    - A script to clone all projects should be available at `~/clone_projects.sh`.
    ```bash
    ~/clone_projects.sh
    ```

## Included Dotfiles

*   `.bashrc`: Shell configuration for interactive bash sessions.
*   `.profile`: Shell configuration for login shells.
*   `.gitconfig`: Git configuration with useful aliases and settings.