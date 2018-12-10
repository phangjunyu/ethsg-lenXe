# ethsg-lenXe
Offchain virtual relayer between Kyber and 0x implementation for EthSingapore 2018

### Bounty 8) Off-Chain Virtual Orderbook Relayer
One strong advantage of Kyber is that liquidity is already on-chain (tokens and prices are already on the smart contract). Anyone can query the Kyber contract for the expect buy and sell rate, such as 1 or 2 ETH equivalent amount of a token. One can then reconstruct an orderbook with orders extracted from Kyber’s liquidity pool. For greater accuracy, consider querying rates from individual reserve contracts instead of Kyber’s contract. In any case, let us denote orders extracted from Kyber as on-chain orders.

It would be cool to build a relayer that can combine both 0x’s and Kyber’s model: there are always on-chain orders relayed from Kyber and users can also create new off-chain orders should they wish to sell/buy at a different price. What’s really interesting is how the settlement occurs between a new on-chain order with an existing off-chain order, since it may require interactions between both Kyber and 0x smart contracts.

Using Kyber’s protocol, develop any type of relayer application that combines both 0x’s and Kyber’s model.

### Overview
The main idea for this task is to create a relayer that can communicate between both Kyber's onchain smart contract DEX and 0x's offchain orderbooks. The approach was to query Kyber's reserves directly and construct an orderbook. We then compare Kyber's rates to what the user needs. If it is not enough, we will then query 0x's orderbooks as a "taker" to see if an order can be matched. If it is still not enough, the order would be pushed to 0x's orderbook instead. With this, we believe that it greatly increases the liquidity in the exchange market, benefitting users. Users can initially decide which workflow (on chain or off chain) they prefer best, but the trades that they can make will always be matched at the optimal price due to a two-way relayer that can speak to both DEXes.

### Implementation
For this task, we used the "workshop" repo from Kyber and 0x's starter kit to launch a private ganache blockchain that had both their contracts deployed. A simple Relayer contract was then used to communicate with Kyber's contracts to query the rates or make an order. A simple NodeJS framework was used to communicate with the contract through web3js. The web server can be found here: https://github.com/phangjunyu/simple-web3.

We also modified the 0x starter kit's fill_sra scenario to separate out the "Maker" and "Taker" functions that can be called. As of now, the functions have not been successfully integrated as one smooth workflow in the app and still remains as a separate command line function. The code can be found here: https://github.com/lenz913/0xstarter


special shoutout to lenz931 and yaliu14 for coming together and working on this together at EthSG2018!
