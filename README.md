# ADL Commerce Lab Setup

This repository contains a setup script for the ADL (Adobe Developer Lab) workshop that automates the installation and configuration of required tools and projects.

## Prerequisites

- **Node.js** version 22 (any minor/patch version)
- **npm** version 9 or higher
- **git** installed and configured

## What This Script Does

The setup script performs the following tasks in order:

1. **Prerequisite Checks** - Verifies that git, Node.js 22, and npm 9+ are installed
2. **Adobe I/O CLI Installation** - Installs the Adobe I/O CLI globally
3. **Plugin Installation** - Installs Commerce and Runtime plugins for Adobe I/O CLI
4. **Adobe I/O Configuration** - Clears config, authenticates, and selects org/project/workspace
5. **Extension Setup** - Clones the Commerce Integration Starter Kit (from `adl` branch), installs dependencies, creates env file, downloads workspace configuration, and connects to remote workspace
6. **Storefront Setup** - Clones the AEM Boilerplate Commerce storefront (from `agentic-dev` branch) and installs dependencies
7. **MCP Server Setup** - Installs MCP server dependencies and creates env file

## Usage

### macOS/Linux

#### Standard Setup (with prerequisite checks)

```bash
./adl-setup.sh
```

#### Skip Prerequisite Checks

If you're certain your environment meets the requirements, you can skip the prerequisite checks:

```bash
./adl-setup.sh --skip-prereqs
```

### Windows (PowerShell)

#### Standard Setup (with prerequisite checks)

```powershell
.\adl-setup.ps1
```

#### Skip Prerequisite Checks

```powershell
.\adl-setup.ps1 -SkipPrereqs
```

**Note for Windows users:** You may need to enable script execution in PowerShell. Run PowerShell as Administrator and execute:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Script Options

### macOS/Linux
- `--skip-prereqs` - Skip the prerequisite version checks for Node.js, npm, and git

### Windows (PowerShell)
- `-SkipPrereqs` - Skip the prerequisite version checks for Node.js, npm, and git

## What Gets Installed

- **Adobe I/O CLI** (`@adobe/aio-cli`)
- **Commerce Plugin** for Adobe I/O CLI
- **Runtime Plugin** for Adobe I/O CLI
- **Commerce Integration Starter Kit** (extension folder)
- **AEM Boilerplate Commerce** (storefront folder)

## Post-Installation

After the script completes, you'll have two main directories:

- `extension/` - The Commerce Integration Starter Kit (includes `.env` file and workspace configuration)
- `storefront/` - The AEM Boilerplate Commerce storefront (includes MCP server setup)

## Troubleshooting

If you encounter issues:

1. Ensure you have the correct Node.js and npm versions installed
2. Make sure you're logged into Adobe I/O when prompted
3. Verify you have access to the required Adobe Console organizations and projects
4. Check that you have proper git credentials configured

## Notes

- The script will prompt you to select your Adobe Console organization, project, and workspace
- You'll need to authenticate with Adobe I/O during the setup process
- The script creates `.env` files from template files:
  - `extension/.env` (from `env.dist`)
  - `storefront/mcp-server/.env` (from `env.example`)
- The workspace configuration is downloaded and copied to `extension/scripts/onboarding/config/workspace.json`
- Your local workspace is automatically connected to your Adobe Console workspace
