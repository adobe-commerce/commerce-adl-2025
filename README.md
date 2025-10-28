# ADL Commerce Lab Setup

This repository contains a setup script for the ADL (Adobe Developer Lab) workshop that automates the installation and configuration of required tools and projects.

## Prerequisites

- **Node.js** version 22 or higher
- **npm** version 9 or higher
- **git** installed and configured

## What This Script Does

The setup script performs the following tasks:

1. **Prerequisite Checks** - Verifies that git, Node.js, and npm are installed with correct versions
2. **Adobe I/O CLI Setup** - Installs and configures the Adobe I/O CLI and commerce plugin
3. **Extension Setup** - Clones and configures the Commerce Integration Starter Kit
4. **Storefront Setup** - Clones and configures the AEM Boilerplate Commerce storefront
5. **MCP Server Setup** - Configures the MCP (Model Context Protocol) server

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

- `extension/` - The Commerce Integration Starter Kit
- `storefront/` - The AEM Boilerplate Commerce storefront

## Troubleshooting

If you encounter issues:

1. Ensure you have the correct Node.js and npm versions installed
2. Make sure you're logged into Adobe I/O when prompted
3. Verify you have access to the required Adobe Console organizations and projects
4. Check that you have proper git credentials configured

## Notes

- The script will prompt you to select your Adobe Console organization, project, and workspace
- You'll need to authenticate with Adobe I/O during the setup process
- The script creates `.env` files from template files where needed

