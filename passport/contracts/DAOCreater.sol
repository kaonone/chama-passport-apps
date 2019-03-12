pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/math/SafeMath.sol";
// import "./Kit.sol";

contract DAOCreater is AragonApp {
    using SafeMath for uint256;

    /// Events
    event Deploy(address indexed entity, uint256 id);

    /// State
    uint256 public value;

    /// ACL
    bytes32 constant public CREATE_DAO_ROLE = keccak256("CREATE_DAO_ROLE");


    function initialize() onlyInit public {
        initialized();
    }


    // function createDAO(ENS ens, uint256 id) auth(CREATE_DAO_ROLE) external {
    function createDAO(uint256 ens, uint256 id) auth(CREATE_DAO_ROLE) external {
        // DAOFactory fac = DAOFactory(0);
        // Kernel dao = fac.newDAO(this);
        // ACL acl = ACL(dao.acl());
        // acl.createPermission(this, dao, dao.APP_MANAGER_ROLE(), this);

        // address root = msg.sender;
        // bytes32 appId = apmNamehash("app");
        // bytes32 votingAppId = apmNamehash("voting");
        // bytes32 tokenManagerAppId = apmNamehash("token-manager");

        // CounterApp app = CounterApp(dao.newAppInstance(appId, latestVersionAppBase(appId)));


        // Kit kit = Kit(ens);
        // kit.newInstance();

        emit Deploy(msg.sender, id);
    }
}
