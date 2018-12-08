pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";
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
        (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken, srcQty, destToken);
        //changge return type to match to compile TODO
        return (minConversionRate, slippageRate);

        // check the reserves
        // get rates and put into a mapping from minimum rates to addresses of the reserves)
        
        // Log the event
        // Rates(msg.sender, minConversionRate, slippageRate);
    }

    function queryzxOB(
        ERC20 srcToken,
        uint srcQty,
        ERC20 destToken
    ) public returns (uint256){
        uint minRate;
        return minRate;
    }

    function compare(
        uint kyberRate,
        uint zxRate
    ) private returns (uint){
        uint result;
        return result;
    }

    //
    function decision(ERC20 srcToken, uint srcQty, ERC20 destToken, address destAddress, uint maxDestAmount) public {
        //check KyberOB
        var kyberOB = queryKyberOB(srcToken, srcQty, destToken);
        //check 0xOB
        var zxOB = zxService.queryzxOB(srcToken, srcQty, destToken);
        //compare and returns 0, 1 or 2
        uint result = compare(kyberOB, zxOB);
        
        //if 0, means execute Trade with Kyber DEX
        if (result == 0){
            Trade.execSwap(srcToken, srcQty, destToken, destAddress, maxDestAmount);
            //a Swap Event will be emitted
        }
            

        //if 1, means execute Trade with 0xOB
        if (result == 1){
            zxService.execSwapzx(srcToken, srcQty, destToken);
        }

        //if 2, means both 0 and 1 did not have the desired rates
        //and the final option would be to post on 0x's orderbook
        if (result == 2){
            //UI should prompt and ask if proceed
            // zxService.postzxOB(srcToken, srcQty, destToken);
        } 
    }
}
