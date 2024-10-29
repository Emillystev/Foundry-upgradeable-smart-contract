// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// forge install OpenZeppelin/openzeppelin-contracts-upgradeable --no-commit
// forge install OpenZeppelin/openzeppelin-contracts --no-commit

import {UUPSUpgradeable} from "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";

contract BoxV2 is UUPSUpgradeable {
    uint256 internal number;
    string private s_second;

    function setValue(uint256 _number) external {
        number = _number;
    }

    function getString() public returns (string memory) {
        s_second = "updated string";
        return s_second;
    }

    function getValue() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}

// abstract contracts have some functions defined and some functions undefined
