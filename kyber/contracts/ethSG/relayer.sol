pragma solidity ^0.4.18;
import "../examples/Trade.sol";
import "./zxService.sol";


/// @title Relayer that allows user interaction  with Kyber Network and 0x 
contract Relayer{

    event Rates(address indexed sender, uint minConversionRate, uint slippageRate);
    
    KyberNetworkProxy public proxy;
    ERC20 constant internal ETH_TOKEN_ADDRESS = ERC20(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);

    function Relayer(KyberNetworkProxy _proxy) public {
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
    ) public returns (uint, uint) {
        uint minConversionRate;
        uint slippageRate;
        // Get the minimum conversion rate
        (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken,destToken, srcQty);
        //changge return type to match to compile TODO
        return (minConversionRate, slippageRate);
        // Log the event
        // Rates(msg.sender, minConversionRate, slippageRate);
    }

}
