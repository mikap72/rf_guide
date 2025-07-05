# Guide for Robot Framework with VS Code and WSL2

# Installation
Installation guide done. See: [installation.md](./installation.md)

## Running Bash Scripts


All robot framework scripts. In project folder:

```bash
   ./run_robot.sh
```

Only one Robot Framework script:

```bash
   ./run_robot.sh ./robot/<robot file.robot>
```

See [Claude generated instructions](./claude_run_robot.md) for details.

## Recommended VS Code extensions

WSL, Python, Markdown
- WSL
- Python (Microsoft)
- markdownlint
   - Markdown linting

If using Containers:
- Dev Containers
- Docker

## WSL modification for opening .html files in WSL terminal

Open WSL and type following commands: 

```bash
export BROWSER="/mnt/c/Windows/explorer.exe"
echo "alias view='explorer.exe'" >> ~/.bashrc
source ~/.bash_profile 
```

Restart VS Code and WSL.

Now you can open a HTML file in Edge by typing following command in VS Code's Integrated Terminal: `view <path to html file>`. You can open any folder in the VS Code Terminal by right clicking it in the `Explorer` file tree view and selecting `Open in Integrated Terminal`.

## Xpath related tools

- [SelectorsHub](https://microsoftedge.microsoft.com/addons/detail/selectorshub-xpath-help/iklfpdeiaeeookjohbiblmkffnhdippe) extension for prowser
   - This was security audited by an international corporation in early 2025.
- [Xpath cheatsheet](https://devhints.io/xpath) by Dev Hints