#!/bin/bash

# Check prerequisites
echo -e "\n*************************************************\n"
echo -e "Checking prerequisites"

# Check git installation
echo -e "\nChecking git installation..."
if ! command -v git &> /dev/null; then
    echo "ERROR: git is not installed. Please install git and try again."
    exit 1
fi
git --version

# Check Node.js version (should be 22 or higher)
echo -e "\nChecking Node.js version..."
if ! command -v node &> /dev/null; then
    echo "ERROR: Node.js is not installed. Please install Node.js 22 or higher."
    exit 1
fi

NODE_VERSION=$(node --version | sed 's/v//')
NODE_MAJOR_VERSION=$(echo $NODE_VERSION | cut -d. -f1)
REQUIRED_NODE_MAJOR="22"
echo "Found Node.js version: v$NODE_VERSION"

if [ "$NODE_MAJOR_VERSION" -lt "$REQUIRED_NODE_MAJOR" ]; then
    echo "ERROR: Node.js version must be $REQUIRED_NODE_MAJOR or higher. Found: v$NODE_VERSION"
    exit 1
fi
echo "Node.js version is sufficient"

# Check npm version (should be 9 or higher)
echo -e "\nChecking npm version..."
if ! command -v npm &> /dev/null; then
    echo "ERROR: npm is not installed. Please install npm 9 or higher."
    exit 1
fi

NPM_VERSION=$(npm --version)
NPM_MAJOR_VERSION=$(echo $NPM_VERSION | cut -d. -f1)
REQUIRED_NPM_MAJOR="9"
echo "Found npm version: $NPM_VERSION"

if [ "$NPM_MAJOR_VERSION" -lt "$REQUIRED_NPM_MAJOR" ]; then
    echo "ERROR: npm version must be $REQUIRED_NPM_MAJOR or higher. Found: $NPM_VERSION"
    exit 1
fi
echo "npm version is sufficient"

echo -e "\nAll prerequisites met!\n"

# Install aio cli
echo -e "\n*************************************************\n"
echo -e "\nInstalling aio cli\n"
npm install -g @adobe/aio-cli


# Install aio commerce plugin
echo -e "\n*************************************************\n"
echo -e "\nInstalling aio commerce plugin\n"
aio plugins:install https://github.com/adobe-commerce/aio-cli-plugin-commerce

# aio config clear
echo -e "\n*************************************************\n"
echo -e "\nClearing aio config\n"
aio config clear

# aio force login
echo -e "\n*************************************************\n"
echo -e "\nLogging in to aio\n"
aio auth login -f

# aio console org select
echo -e "\n*************************************************\n"
echo -e "\nSelecting aio console org\n"
aio console org select

# aio console project select
echo -e "\n*************************************************\n"
echo -e "\nSelecting aio console project\n"
aio console project select

# aio console workspace select
echo -e "\n*************************************************\n"
echo -e "\nSelecting aio console workspace\n"
aio console workspace select

# Extension setup

# Clone integration starter kit
echo -e "\n*************************************************\n"
echo -e "\nCloning integration starter kit\n"
git clone --branch adl https://github.com/adobe/commerce-integration-starter-kit.git extension

# Move into extension folder
echo -e "\n*************************************************\n"
echo -e "\nMoving into extension folder\n"
cd extension

# Install dependencies
echo -e "\n*************************************************\n"
echo -e "\nInstalling dependencies\n"
npm install

# create env file
echo -e "\n*************************************************\n"
echo -e "\nCreating env file\n"
cp env.dist .env

# Download workspace configuration
echo -e "\n*************************************************\n"
echo -e "\nDownloading workspace configuration\n"
aio console workspace download workspace.json

# Copy workspace.json to scripts/onboarding/config
echo -e "\n*************************************************\n"
echo -e "\nCopying workspace.json to scripts/onboarding/config\n"
cp workspace.json scripts/onboarding/config/workspace.json

# Connect local workspace to remote workspace
echo -e "\n*************************************************\n"
echo -e "\nConnecting local workspace to remote workspace\n"
aio app use

# Move out of extension folder
echo -e "\n*************************************************\n"
echo -e "\nMoving out of extension folder\n"
cd ..

# Storefront setup

# Clone storefront starter kit
echo -e "\n*************************************************\n"
echo -e "\nCloning storefront starter kit\n"
git clone --branch agentic-dev https://github.com/hlxsites/aem-boilerplate-commerce.git storefront

# Move into storefront folder
echo -e "\n*************************************************\n"
echo -e "\nMoving into storefront folder\n"
cd storefront

# Install dependencies
echo -e "\n*************************************************\n"
echo -e "\nInstalling dependencies\n"
npm install

# Install MCP server dependencies
echo -e "\n*************************************************\n"
echo -e "\nInstalling MCP server dependencies\n"
cd mcp-server
npm install

# Setup MCP server env
echo -e "\n*************************************************\n"
echo -e "\nSetting up MCP server env\n"
cp env.example .env

# Go back to extension folder
echo -e "\n*************************************************\n"
echo -e "\nGoing back to extension folder\n"
cd ../../extension
