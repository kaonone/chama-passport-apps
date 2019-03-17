pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/acl/IACL.sol";
import "@aragon/os/contracts/kernel/IKernel.sol";

interface IPassport {
    // bytes32 constant public REGISTER_IDENTITY_ROLE;

    function initialize() external;
    function initialize(IPassport root, IKernel dao) external;
    // function initialize(IACL acl, IPassport root) external;
    // function countMembers() view external returns (uint);
}
