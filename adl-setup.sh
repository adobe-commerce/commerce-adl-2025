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

# Go back to storefront folder
echo -e "\n*************************************************\n"
echo -e "\nGoing back to storefront folder\n"
cd ..
