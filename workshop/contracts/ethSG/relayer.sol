pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";

contract Relayer{


    event Rates(address indexed sender, uint minConversionRate, uint slippageRate);

    KyberNetworkProxy public proxy;
    ERC20 constant internal ETH_TOKEN_ADDRESS = ERC20(0x00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee);

    //@dev Contract contstructor
    //@param _proxy KyberNetworkProxy contract address
    function Relayer(KyberNetworkProxy _proxy) public {
        proxy = _proxy;
    }

    //@dev Swap the user's ERC20 token to another ERC20 token
    //@param srcToken source token contract address
    //@param srcQty amount of source tokens
    //@param destToken destination token contract address
    //@param destAddress address to send swapped tokens to
    //@param maxDestAmount address to send swapped tokens to
    function queryKyberOB(
        ERC20 srcToken,
        uint srcQty,
        ERC20 destToken
    ) public {
        uint minConversionRate;
        uint slippageRate;

        // Get the minimum conversion rate
        (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken, destToken, srcQty);

        // Log the event
        Rates(msg.sender, minConversionRate, slippageRate);
    }

    function call0xOB() public {

    }
}
