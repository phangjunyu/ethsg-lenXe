pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";


/// @title Relayer that allows user interaction  with Kyber Network and 0x 
contract Relayer{

    event Rates(address indexed sender, uint minConversionRate, uint slippageRate);

    KyberNetworkProxy public proxy;
    ERC20 constant internal ETH_TOKEN_ADDRESS = ERC20(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);

    /// @dev Contract constructor
    /// @param _proxy KyberNetworkProxy contract address
    /// @param TODO: something that talks to 0x
    constructor Relayer(KyberNetworkProxy _proxy) public {
        proxy = _proxy;
    }

    /// @dev should query KyberOB.sol 
    /// @param srcToken source token contract address
    /// @param srcQty amount of source tokens
    /// @param destToken destination token contract address
    function queryKyberOB(
        ERC20 srcToken,
        uint srcQty,
        ERC20 destToken
    ) public returns (uint256 minRate, uint256 slippageRate) {
        uint minConversionRate;
        uint slippageRate;
        // Get the minimum conversion rate
        (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken, destToken, srcQty);

        // check the reserves
        // get rates and put into a mapping from minimum rates to addresses of the reserves)
        
        // Log the event
        // Rates(msg.sender, minConversionRate, slippageRate);
    }

    function query0xOB(
        ERC20 srcToken,
        uint srcQty,
        ERC20 destToken
    ) public returns (uint256 minRate){

    }

    function compare(
        uint kyberRate,
        uint 0xRate
    ) private returns (address optimalAddress)){

    }

    function post0xOB(){

    }

    //
    function decision(){
        //check KyberOB
        //check 0xOB
        //compare
        //if there is optimal, execute trade with desired DEX
        //if both are NOT optimal, post trade on 0xOB
    }
}
