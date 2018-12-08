pragma solidity ^0.4.18;

contract 0xService{

    function 0xService(){
        //constructor
    }

    function query0xOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{

    }

    function execSwap0x(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
            

            //should emit an Event
    }

    function post0xOB(
        ERC20 srcToken, 
        uint srcQty, 
        ERC20 destToken) public{
            //should emit an event
            //call watch0xOB to start watching the chain
            watch0xOB()
    }


    function watch0xOB(){
        //listener to watch for event and return to UI
    }
}