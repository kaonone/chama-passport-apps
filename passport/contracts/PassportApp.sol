pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/math/SafeMath.sol";

contract PassportApp is AragonApp {
    using SafeMath for uint256;

    /// Events
    // event Increment(address indexed entity, uint256 step);
    // event Decrement(address indexed entity, uint256 step);
    // event Registration(address indexed entity, uint256 step);
    event Registration(address indexed entity, uint step);

    struct Identity {
        uint age;
        string fName;
        string lName;
    }

    /// State
    /// String(bytes32) pointing to address of Identity instance.
    // OPT: https://gist.github.com/axic/ce82bdd1763c04ef8138c2b905985dab
    mapping (address => Identity) identities;
    address[] public members;

    // TODO: TEMP: remove me
    uint256 public value;


    /// ACL
    bytes32 constant public REGISTER_IDENTITY_ROLE = keccak256("REGISTER_IDENTITY_ROLE");

    function initialize() onlyInit public {
        initialized();
    }


    /**
     * @notice Register new Identity for caller with `something`
     * @param something Amount of something
     */
    function register(uint something, string fname, string lname) auth(REGISTER_IDENTITY_ROLE) external {
        // TODO: break if msg.sender is already existing in identities.

        var identity = identities[msg.sender];
        identity.age = something;
        identity.fName = fname;
        identity.lName = lname;

        members.push(msg.sender);

        value = value.add(something);
        emit Registration(msg.sender, something);
    }

    // function getIdentities() view public returns (address[]) {
    function getMembers() view public returns (address[]) {
        return members;
    }

    function countMembers() view public returns (uint) {
        return members.length;
    }

    function countIdentities() view public returns (uint) {
        return members.length;
    }

    function getIdentity(address _address) view public returns (uint, string, string) {
        return (identities[_address].age, identities[_address].fName, identities[_address].lName);
    }

    function getMyIdentity() view public returns (uint, string, string) {
        return (identities[msg.sender].age, identities[msg.sender].fName, identities[msg.sender].lName);
    }
}
