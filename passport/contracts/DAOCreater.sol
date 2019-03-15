pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/math/SafeMath.sol";
import "@aragon/os/contracts/apm/APMNamehash.sol";
import "../../common/contracts/IChamaKit.sol";


contract DAOCreater is AragonApp, APMNamehash {
    using SafeMath for uint256;

    /// Events
    event Deploy(address indexed entity, uint256 id);

    /* Hardcoded constants to save gas */
    bytes32 internal constant CHAMA_REGISTRY_APP_ID = apmNamehash("chamareg");
    bytes32 internal constant CHAMA_KIT_ID = apmNamehash("chamakit");

    /// State

    /// ACL
    bytes32 constant public CREATE_DAO_ROLE = keccak256("CREATE_DAO_ROLE");


    function initialize() public onlyInit {
        initialized();
    }


    // function createDAO(ENS ens, uint256 id) auth(CREATE_DAO_ROLE) external {
    function createDAO(uint256 ens, uint256 id) external auth(CREATE_DAO_ROLE) {
        // TODO: FIXME:
        // address kit =
        // IChamaKit kit = IChamaKit(dao.newAppInstance(CHAMA_KIT_ID, latestVersionAppBase(CHAMA_KIT_ID)));
        // kit.newInstance(msg.sender, id);

        emit Deploy(msg.sender, id);
    }
}
