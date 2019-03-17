/*
 * SPDX-License-Identitifer:    GPL-3.0-or-later
 *
 * This file requires contract dependencies which are licensed as
 * GPL-3.0-or-later, forcing it to also be licensed as such.
 *
 * This is the only file in your project that requires this license and
 * you are free to choose a different license for the rest of the project.
 */

pragma solidity 0.4.24;

import "@aragon/os/contracts/factory/DAOFactory.sol";
import "@aragon/os/contracts/apm/Repo.sol";
import "@aragon/os/contracts/lib/ens/ENS.sol";
import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
import "@aragon/os/contracts/apm/APMNamehash.sol";

import "@aragon/apps-voting/contracts/Voting.sol";
import "@aragon/apps-token-manager/contracts/TokenManager.sol";
import "@aragon/apps-shared-minime/contracts/MiniMeToken.sol";

import "./DAOCreater.sol";
// import "../../common/contracts/IPassport.sol";
// import {Kit as ChamaKit} from "../../chama/contracts/Kit.sol";


contract KitBase is APMNamehash {
    ENS public ens;
    DAOFactory public fac;

    event DeployInstance(address dao);
    event InstalledApp(address appProxy, bytes32 appId);

    function KitBase(DAOFactory _fac, ENS _ens) {
        ens = _ens;

        // If no factory is passed, get it from on-chain bare-kit
        if (address(_fac) == address(0)) {
            bytes32 bareKit = apmNamehash("bare-kit");
            fac = KitBase(latestVersionAppBase(bareKit)).fac();
        } else {
            fac = _fac;
        }
    }

    function latestVersionAppBase(bytes32 appId) public view returns (address base) {
        Repo repo = Repo(PublicResolver(ens.resolver(appId)).addr(appId));
        (,base,) = repo.getLatest();

        return base;
    }
}


contract Kit is KitBase {
    MiniMeTokenFactory tokenFactory;

    uint64 constant PCT = 10 ** 16;
    address constant ANY_ENTITY = address(-1);

    // address public passport;

    function Kit(ENS ens) KitBase(DAOFactory(0), ens) {
        /* , address passport */
        // tokenFactory = new MiniMeTokenFactory();
    }

    function newInstance() {
        Kernel dao = fac.newDAO(this);
        ACL acl = ACL(dao.acl());
        acl.createPermission(this, dao, dao.APP_MANAGER_ROLE(), this);

        address root = msg.sender;
        // bytes32 passportId = apmNamehash("passport");
        bytes32 factoryId = apmNamehash("chama-factory");
        // bytes32 votingAppId = apmNamehash("voting");

        // PassportApp passport = PassportApp(dao.newAppInstance(passportId, latestVersionAppBase(passportId)));
        DAOCreater factory = DAOCreater(dao.newAppInstance(factoryId, latestVersionAppBase(factoryId)));
        // Voting voting = Voting(dao.newAppInstance(votingAppId, latestVersionAppBase(votingAppId)));

        // init kit:
        // ChamaKit kit = new ChamaKit(ens);

        // init apps:
        factory.initialize(ens);
        // factory.initialize(address(kit));

        acl.createPermission(ANY_ENTITY, factory, factory.SETUP_KIT_ROLE(), acl);
        acl.createPermission(ANY_ENTITY, factory, factory.CREATE_DAO_ROLE(), acl);

        // Grant core permissions // TODO: review & fix me:
        // acl.grantPermission(voting, dao, dao.APP_MANAGER_ROLE());

        // acl.grantPermission(passport, acl, acl.CREATE_PERMISSIONS_ROLE());
        // acl.grantPermission(acl, factory, factory.SETUP_KIT_ROLE());
        // acl.grantPermission(acl, factory, factory.CREATE_DAO_ROLE());

        // Clean up permissions
        acl.grantPermission(root, dao, dao.APP_MANAGER_ROLE());
        acl.revokePermission(this, dao, dao.APP_MANAGER_ROLE());
        acl.setPermissionManager(root, dao, dao.APP_MANAGER_ROLE());

        acl.grantPermission(root, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.revokePermission(this, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.setPermissionManager(root, acl, acl.CREATE_PERMISSIONS_ROLE());

        DeployInstance(dao);
    }
}
