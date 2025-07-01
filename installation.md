# WSL2 Robot Framework Browser Library Installation

## Prequisities

- WSL

   Install in PowerShell:

   ```bash
      wsl --install -d Ubuntu-24.04
   ```

- VS Code (Microsoft marketplace)
- GitBash (optional)

   In GitBash (Win11):
    ```
       git config --global user.name "Your Name"
       git config --global user.email "your@email.com"
    ```

## Start VS Code from WSL
Make project directory and Open VS Code

   ```bash
    mkdir projects
    cd projects/
    mkdir rf_guide
    cd rf_guide/
    touch installation.md
    code .
   ```
## Init GIT

   ```bash
   touch .gitignore
   git init
   ```

   `NOTE:` your git identity should be already configured in GitBash.


## Create python virtual environment

Update/install pip, virtualenv and ensure that no global Python pacgages are used.

   ```bash
   sudo apt update
   sudo apt install virtualenv
   sudo apt install python3.12-venv   
   sudo apt install python3-pip
   alias python=python3
   alias pip=pip3
   python --version
   sudo python -m pip config set global.break-system-packages true
   python3 -m venv .venv
   ```

## Activate virtual environment

   ```bash
   source .venv/bin/activate
   ```

   `pip list` should look like this:

   ```
   Package Version
   ------- -------
   pip     24.0
   ```

## Install Robot Framework and Browser Library

   `NOTE:` inside `.venv`

   Robot Framework
   
   ```bash
   pip install robotframework-browser
   rfbrowser init
   ```

   Browser Library

   ```bash
   sudo apt install nodejs npm
   sudo npx playwright install-deps
   
   ```