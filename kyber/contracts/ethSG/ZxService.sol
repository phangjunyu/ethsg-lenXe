pragma solidity ^0.4.18;

import "../KyberNetworkProxy.sol";

contract ZxService{

    function ZxService(){
        //constructor
    }

    function queryZxOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{

    }

    function execSwapZx(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
            

            //should emit an Event
    }


    function watchZxOB(){
        //listener to watch for event and return to UI
    }

    function postZxOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
      //should emit an event
      //call watch0xOB to start watching the chain
      watchZxOB();
    }



}

