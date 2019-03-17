pragma solidity ^0.4.24;

import "@aragon/os/contracts/apps/AragonApp.sol";
import "@aragon/os/contracts/lib/math/SafeMath.sol";
import "@aragon/os/contracts/apm/APMNamehash.sol";
import "../../common/contracts/IChamaKit.sol";

import "@aragon/os/contracts/lib/ens/ENS.sol";
import {Kit as ChamaKit} from "../../chama/contracts/Kit.sol";


contract DAOCreater is AragonApp, APMNamehash {
    using SafeMath for uint256;

    /// Events
    event Deploy(address indexed entity, uint256 id);

    /* Hardcoded constants to save gas */
    // TODO: re-impl & use:
    // bytes32 internal constant CHAMA_REGISTRY_APP_ID = apmNamehash("chamareg");
    // bytes32 internal constant CHAMA_KIT_ID = apmNamehash("chamakit");

    /// State
    address public kit;
    ENS public ens;

    /// ACL
    bytes32 constant public CREATE_DAO_ROLE = keccak256("CREATE_DAO_ROLE");
    bytes32 constant public SETUP_KIT_ROLE = keccak256("SETUP_KIT_ROLE");


    function initialize() public onlyInit {
        initialized();
    }

    function initialize(ENS _ens) onlyInit public {
        ens = _ens;
        initialize();
    }

    function setKit(address _kit) external auth(SETUP_KIT_ROLE) {
        kit = _kit;
    }

    function createDAO(uint256 id) external auth(CREATE_DAO_ROLE) {

        // TODO: FIXME:
        // address kit =
        // IChamaKit kit = IChamaKit(dao.newAppInstance(CHAMA_KIT_ID, latestVersionAppBase(CHAMA_KIT_ID)));
        // kit.newInstance(msg.sender, id);

        // ChamaKit chakit;
        // if (kit == 0) {
        //     chakit = new ChamaKit(ens);
        // } else {
        //     chakit = ChamaKit(kit);
        // }
        // /* var dao = */ chakit.newInstance();

        emit Deploy(msg.sender, id);
        // emit Deploy(address(dao), id);
    }
}
