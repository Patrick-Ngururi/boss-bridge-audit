// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

/// @title L1Vault
/// @author Boss Bridge Peeps
/// @notice This contract is responsible for locking & unlocking tokens on the L1 or L2
/// @notice It will approve the bridge to move money in and out of this contract
/// @notice It's owner should be the bridge
contract L1Vault is Ownable {
    IERC20 public token;

    // @Audit-Note: One vault per token is intended.
    constructor(IERC20 _token) Ownable(msg.sender) {
        token = _token;
    }

    // @Audit-Question: Why not just hard-code the approval to only the bridge?
    function approveTo(address target, uint256 amount) external onlyOwner {
        // @Audit-Informational: the return value should be checked/verified
        token.approve(target, amount);
    }
}
