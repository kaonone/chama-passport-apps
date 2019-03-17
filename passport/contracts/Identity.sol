pragma solidity ^0.4.24;


import "@aragon/os/contracts/lib/math/SafeMath.sol";


contract Identity {
    using SafeMath for uint256;

    uint age;
    string fName;
    string lName;

    function Identity (uint something, string _fname, string _lname) {
        age = something;
        fName = _fname;
        lName = _lname;
    }
}
