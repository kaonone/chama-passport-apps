pragma solidity ^0.4.24;

import "./IPassport.sol";
// import "@aragon/os/contracts/apm/Repo.sol";
// import "@aragon/os/contracts/lib/ens/ENS.sol";
// import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
// import "@aragon/os/contracts/apm/APMNamehash.sol";


interface IChamaKit {
    function newInstance() external;
    // function newInstance(address root, address owner/* , IPassport id */) external;
}
