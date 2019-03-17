pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/math/SafeMath.sol";
import "../../common/contracts/IPassport.sol";
import "../../common/contracts/IChamaKit.sol";
import "./Identity.sol";

// import "@aragon/os/contracts/factory/DAOFactory.sol";
// import "@aragon/os/contracts/apm/Repo.sol";
// import "@aragon/os/contracts/lib/ens/ENS.sol";
// import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
// import "@aragon/os/contracts/apm/APMNamehash.sol";
import "@aragon/os/contracts/acl/IACL.sol";
import "@aragon/os/contracts/kernel/IKernel.sol";

contract PassportApp is AragonApp, IPassport {
    using SafeMath for uint256;

    /// Events
    event Registration(address indexed entity, address indexed identity);


    // IACL public acl;
    IKernel public dao;
    IPassport public root;

    /// State
    address[] public members;
    // TODO: String(bytes32) pointing to address of Identity instance.
    // OPT: https://gist.github.com/axic/ce82bdd1763c04ef8138c2b905985dab
    // mapping: address => Identity
    mapping (address => address) identities;


    /// ACL
    bytes32 constant public REGISTER_IDENTITY_ROLE = keccak256("REGISTER_IDENTITY_ROLE");

    function initialize() onlyInit public {
        initialized();
    }

    function initialize(IPassport _root, IKernel _dao) onlyInit public {
        dao = _dao;
        root = _root;
        initialize();
    }


    /**
     * @notice Register new Identity for caller with `something`
     * @param something Amount of something
     */
    function register(uint something, string fname, string lname) auth(REGISTER_IDENTITY_ROLE) external {
        // TODO: break if msg.sender is already existing in identities.

        var identity = identities[msg.sender];
        if (identity != 0) {
            throw;
        }

        var data = new Identity(something, fname, lname);
        identities[msg.sender] = address(data);
        members.push(msg.sender);

        emit Registration(msg.sender, address(data));
    }

    // function getIdentities() view public returns (address[]) {
    function getMembers() public view returns (address[]) {
        return members;
    }

    function countMembers() public view returns (uint) {
        return members.length;
    }

    function countIdentities() public view returns (uint) {
        return members.length;
    }

    /// returns address of associated Identity
    function getIdentity(address _address) public view returns (address) {
        return identities[_address];
    }

    function getMyIdentity() public view returns (address) {
        return getIdentity(msg.sender);
    }


    // TEMP: XXX:
    // ENS: 0x5f6f7e8cc7346a11ca2def8f827b7a0b612c56a1
    // DAO: 0x21bdbdCF1d4aF6651F633E487b3cf329992a04F2


    // function createDAO(uint256 ens, uint256 id) external auth(CREATE_DAO_ROLE) {
    // function createDAO() external {

    //     // It should be the Chama Kit address:
    //     address Kit = 0x21bdbdCF1d4aF6651F633E487b3cf329992a04F2;

    //     // (iid, fname, lname) = getIdentity(msg.sender);
    //     // if (iid == 0) {
    //     //     throw "Does not have ID!";
    //     // }

    //     // address kit =
    //     IChamaKit kit = IChamaKit(Kit);
    //     kit.newInstance();
    //     // kit.newInstance(this, msg.sender);
    //     // kit.newInstance(msg.sender, id);

    //     // emit Deploy(msg.sender, id);
    // }
}
