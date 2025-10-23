# ADL Workshop Setup Script for Windows
# Run this script in PowerShell

param(
    [switch]$SkipPrereqs
)

# Function to write colored output
function Write-Step {
    param($Message)
    Write-Host "`n*************************************************`n" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor White
}

# Function to check command existence
function Test-CommandExists {
    param($Command)
    $null -ne (Get-Command $Command -ErrorAction SilentlyContinue)
}

# Check prerequisites
if (-not $SkipPrereqs) {
    Write-Step "Checking prerequisites"

    # Check git installation
    Write-Host "`nChecking git installation..." -ForegroundColor Yellow
    if (-not (Test-CommandExists git)) {
        Write-Host "ERROR: git is not installed. Please install git and try again." -ForegroundColor Red
        exit 1
    }
    git --version

    # Check Node.js version (should be 22 or higher)
    Write-Host "`nChecking Node.js version..." -ForegroundColor Yellow
    if (-not (Test-CommandExists node)) {
        Write-Host "ERROR: Node.js is not installed. Please install Node.js 22 or higher." -ForegroundColor Red
        exit 1
    }

    $nodeVersion = (node --version) -replace 'v', ''
    $nodeMajorVersion = [int]($nodeVersion -split '\.')[0]
    $requiredNodeMajor = 22
    Write-Host "Found Node.js version: v$nodeVersion"

    if ($nodeMajorVersion -lt $requiredNodeMajor) {
        Write-Host "ERROR: Node.js version must be $requiredNodeMajor or higher. Found: v$nodeVersion" -ForegroundColor Red
        exit 1
    }
    Write-Host "Node.js version is sufficient" -ForegroundColor Green

    # Check npm version (should be 9 or higher)
    Write-Host "`nChecking npm version..." -ForegroundColor Yellow
    if (-not (Test-CommandExists npm)) {
        Write-Host "ERROR: npm is not installed. Please install npm 9 or higher." -ForegroundColor Red
        exit 1
    }

    $npmVersion = npm --version
    $npmMajorVersion = [int]($npmVersion -split '\.')[0]
    $requiredNpmMajor = 9
    Write-Host "Found npm version: $npmVersion"

    if ($npmMajorVersion -lt $requiredNpmMajor) {
        Write-Host "ERROR: npm version must be $requiredNpmMajor or higher. Found: $npmVersion" -ForegroundColor Red
        exit 1
    }
    Write-Host "npm version is sufficient" -ForegroundColor Green

    Write-Host "`nAll prerequisites met!`n" -ForegroundColor Green
}
else {
    Write-Step "Skipping prerequisite checks"
}

# Install aio cli
Write-Step "Installing aio cli"
npm install -g @adobe/aio-cli

# Install aio commerce plugin
Write-Step "Installing aio commerce plugin"
aio plugins:install https://github.com/adobe-commerce/aio-cli-plugin-commerce

# aio config clear
Write-Step "Clearing aio config"
aio config clear

# aio force login
Write-Step "Logging in to aio"
aio auth login -f

# aio console org select
Write-Step "Selecting aio console org"
aio console org select

# aio console project select
Write-Step "Selecting aio console project"
aio console project select

# aio console workspace select
Write-Step "Selecting aio console workspace"
aio console workspace select

# Extension setup

# Clone integration starter kit
Write-Step "Cloning integration starter kit"
git clone --branch adl https://github.com/adobe/commerce-integration-starter-kit.git extension

# Move into extension folder
Write-Step "Moving into extension folder"
Set-Location extension

# Install dependencies
Write-Step "Installing dependencies"
npm install

# create env file
Write-Step "Creating env file"
Copy-Item env.dist .env

# Download workspace configuration
Write-Step "Downloading workspace configuration"
aio console workspace download workspace.json

# Copy workspace.json to scripts/onboarding/config
Write-Step "Copying workspace.json to scripts/onboarding/config"
Copy-Item workspace.json scripts/onboarding/config/workspace.json

# Connect local workspace to remote workspace
Write-Step "Connecting local workspace to remote workspace"
aio app use workspace.json -m

# Move out of extension folder
Write-Step "Moving out of extension folder"
Set-Location ..

# Storefront setup

# Clone storefront starter kit
Write-Step "Cloning storefront starter kit"
git clone --branch agentic-dev https://github.com/hlxsites/aem-boilerplate-commerce.git storefront

# Move into storefront folder
Write-Step "Moving into storefront folder"
Set-Location storefront

# Install dependencies
Write-Step "Installing dependencies"
npm install

# Install MCP server dependencies
Write-Step "Installing MCP server dependencies"
Set-Location mcp-server
npm install

# Setup MCP server env
Write-Step "Setting up MCP server env"
Copy-Item env.example .env

# Go back to extension folder
Write-Step "Going back to extension folder"
Set-Location ../../extension

Write-Host "`n*************************************************" -ForegroundColor Cyan
Write-Host "Setup complete!" -ForegroundColor Green
Write-Host "*************************************************`n" -ForegroundColor Cyan

