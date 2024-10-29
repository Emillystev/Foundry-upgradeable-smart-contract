// what we gonna upgrade

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "../lib/openzeppelin-contracts-upgradeable/contracts/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "../lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;
    string private s_first;

    constructor() {
        // dont do any initializer!
        _disableInitializers(); // we don't want any initializers to run in the contract
    }

    function getString() public returns (string memory) {
        s_first = "original string";
        return s_first;
    }

    function initialize() public initializer {
        // same as constructor for our contract
        __Ownable_init(msg.sender); // sets owner to msg.sender
        __UUPSUpgradeable_init(); // __ means initializers, doesnt really do anything but good practice to have this function
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}

// we cant use constructors with our proxies
