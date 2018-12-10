pragma solidity ^0.4.18;
import "../KyberNetworkProxy.sol";
import "./ZxService.sol";

/// @title Relayer that allows user interaction  with Kyber Network and 0x 
contract Relayer{
    // mapping of minRate to address of reserve
    // mapping(uint256 => address) kyberOB;

    event Query(address indexed sender, uint minConversionRate, uint slippageRate);
    event Swap(address indexed sender, ERC20 srcToken, ERC20 destToken);

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
        uint srcQty,
        ERC20 destToken
    ) public returns (uint minConversionRate, uint slippageRate) {
        // uint256 minConversionRate;
        // uint256 slippageRate;
        // Get the minimum conversion rate
        (minConversionRate, slippageRate) = proxy.getExpectedRate(srcToken, destToken, srcQty);
        // check each reserve
        // get rate of each and liquidity provided by each
        // put into mapping
        // Log the event
        Query(msg.sender, minConversionRate, slippageRate);
        return (minConversionRate, slippageRate);
    }

    /// @dev Swap the user's ERC20 token to another ERC20 token
    /// @param srcToken source token contract address
    /// @param srcQty amount of source tokens
    /// @param destToken destination token contract address
    /// @param destAddress address to send swapped tokens to
    /// @param maxDestAmount address to send swapped tokens to
    //  Taken from contracts/examples/Trade.sol
    function execSwap(
        ERC20 srcToken,
        uint srcQty,
        ERC20 destToken,
        address destAddress,
        uint maxDestAmount
    ) public {
        uint minConversionRate;
        // Check that the token transferFrom has succeeded
        require(srcToken.transferFrom(msg.sender, address(this), srcQty));
        // Mitigate ERC20 Approve front-running attack, by initially setting
        // allowance to 0
        require(srcToken.approve(address(proxy), 0));
        // Set the spender's token allowance to tokenQty
        require(srcToken.approve(address(proxy), srcQty));
        // Get the minimum conversion rate
        (minConversionRate,) = proxy.getExpectedRate(srcToken, destToken, srcQty);
        // Swap the ERC20 token and send to destAddress
        proxy.trade(
            srcToken,
            srcQty,
            destToken,
            destAddress,
            maxDestAmount,
            minConversionRate,
            0
        );

        // Log the event
        Swap(msg.sender, srcToken, destToken);
    }
}
