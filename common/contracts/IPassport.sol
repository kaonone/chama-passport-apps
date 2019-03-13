pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";


interface IPassport {
	function initialize() external;
	function countMembers() view external returns (uint);
}
