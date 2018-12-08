pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";
// import "../../examples/Trade.sol" as tradeContract;
// import "./ZxService.sol" as ZxService;

/// @title Relayer that allows user interaction  with Kyber Network and 0x 
contract Relayer{
    //mapping of minRate to address of reserve
    // mapping(uint256 => address) kyberOB;

    event Rates(address indexed sender, uint minConversionRate, uint slippageRate);

    KyberNetworkProxy public proxy;
    ERC20 constant internal ETH_TOKEN_ADDRESS = ERC20(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);

    /// @dev Contract constructor, change syntax for solc@0.4.22 and above
    /// @param _proxy KyberNetworkProxy contract address
    //  TODO: something that talks to 0x
    function Relayer(KyberNetworkProxy _proxy) public {
        proxy = _proxy;
    }

    /// @dev should query KyberNetworkProxy
    /// @param srcToken source token contract address
    /// @param srcQty amount of source tokens
    /// @param destToken destination token contract address
    function queryKyber(
        ERC20 srcToken,
        uint256 srcQty,
        ERC20 destToken
    ) public returns (uint256 minRate, uint256 slippageRate) {
        uint256 minConversionRate;
        //uint256 slippageRate;
        // Get the minimum conversion rate
        // (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken, destToken, srcQty);
        // check the reserves
        // get rates and put into a mapping from minimum rates to addresses of the reserves)
        // Log the event
        // Rates(msg.sender, minConversionRate, slippageRate);
    }

    function query0xOB(
        ERC20 srcToken,
        uint256 srcQty,
        ERC20 destToken
    ) public returns (uint256 minRate){

    }

    function compare(
        uint256 kyberRate,
        uint256 ZxRate
    ) private returns (address optimalAddress) {

    }

    //
    function decision(ERC20 srcToken, uint srcQty, ERC20 destToken) public {
        //check KyberOB
        // kyberOB = queryKyberOB(srcToken, srcQty, destToken);
        //check 0xOB
        // ZxOB = ZxService.queryZxOB(srcToken, srcQty, destToken);
        //compare and returns 0, 1 or 2
        // uint result = compare(kyberOB, ZxOB);
        uint32 result = 0;
        if (result == 0) {
            //if 0, means execute Trade with Kyber DEX
            // tradeContract.execSwap(srcToken, srcQty, destToken);
            //a Swap Event will be emitted
        } else if (result == 1) {
            //if 1, means execute Trade with 0xOB
            // ZxService.execSwap(srcToken, srcQty, destToken);
        } else {
            //if 2, means both 0 and 1 did not have the desired rates
            //and the final option would be to post on 0x's orderbook
            //UI should prompt and ask if proceed
            // ZxService.post0xOB(srcToken, srcQty, destToken);
        }
    }
}
