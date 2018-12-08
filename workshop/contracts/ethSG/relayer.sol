pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";
import "../examples/Trade.sol" as tradeContract;
import "./0xService.sol" as 0xService

/// @title Relayer that allows user interaction  with Kyber Network and 0x 
contract Relayer{
    //mapping of minRate to address of reserve
    mapping(uint256 => address) kyberOB;

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

    //
    function decision(ERC20 srcToken, uint srcQty, ERC20 destToken) public {
        //check KyberOB
        kyberOB = queryKyberOB(srcToken, srcQty, destToken)
        //check 0xOB
        0xOB = 0xService.query0xOB(srcToken, srcQty, destToken)
        //compare and returns 0, 1 or 2
        uint result = compare(kyberOB, 0xOB)
        switch(result){

            //if 0, means execute Trade with Kyber DEX
            case 0:
                tradeContract.execSwap(srcToken, srcQty, destToken)
                //a Swap Event will be emitted
                break;

            //if 1, means execute Trade with 0xOB
            case 1:
                0xService.execSwap(srcToken, srcQty, destToken)
                break;

            //if 2, means both 0 and 1 did not have the desired rates
            //and the final option would be to post on 0x's orderbook
            case 2:
                //UI should prompt and ask if proceed
                0xService.post0xOB(srcToken, srcQty, destToken)
                break;
        }
    }
}
