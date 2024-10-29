-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil scopefile

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: remove install build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install foundry-rs/forge-std --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit && forge install openzeppelin/openzeppelin-contracts-upgradeable@v4.8.3 --no-commit && forge install cyfrin/foundry-devops@0.0.11 --no-commit 

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvvv
endif

deploy:
	@forge script script/DeployBox.s.sol:DeployBox $(NETWORK_ARGS)

upgrade:
	@forge script script/UpgradeBox.s.sol:UpgradeBox $(NETWORK_ARGS)


# forge script script/DeployBox.s.sol --rpc-url https://eth-sepolia.g.alchemy.com/v2/6mRFljsQSpIgtiLEvvftwxQpSIdA__D8 --private-key efc3f319fea317f6c52bc8d7ffe144229ba1bfd1c3a77ce1110bf179b39796ae --broadcast
# 0xb6b143D3dde0005CDaE2313857b5626FB61D55Ee
# 0xb6b143D3dde0005CDaE2313857b5626FB61D55Ee
# forge script script/UpgradeBox.s.sol --rpc-url https://eth-sepolia.g.alchemy.com/v2/6mRFljsQSpIgtiLEvvftwxQpSIdA__D8 --private-key efc3f319fea317f6c52bc8d7ffe144229ba1bfd1c3a77ce1110bf179b39796ae --broadcast


# 0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000f6f726967696e616c20737472696e670000000000000000000000000000000000
# 0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000e7570646174656420737472696e67000000000000000000000000000000000000