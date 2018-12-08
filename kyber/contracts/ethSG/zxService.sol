pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";

contract zxService{

    function zxService() public {
        //constructor
    }

    function queryzxOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{

    }

    function execSwapzx(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
            

            //should emit an Event
    }

    function postzxOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
            //should emit an event
            //call watch0xOB to start watching the chain
            watchzxOB();
    }


    function watchzxOB() public {
        //listener to watch for event and return to UI
    }
}