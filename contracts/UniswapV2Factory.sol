// contracts/UniswapV2Factory.sol
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./interfaces/IUniswapV2Factory.sol";
import "./UniswapV2Pair.sol";

contract UniswapV2Factory is IUniswapV2Factory {
    address public override feeTo;
    address public override feeToSetter;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view override returns (uint256) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB)
        external
        override
        returns (address pair)
    {
        require(tokenA != tokenB, "UniswapV2: IDENTICAL_PAIR_ADDRESSES");
        (address token0, address token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "UniswapV2: PAIR_ZERO_ADDRESS");
        require(
            getPair[token0][token1] == address(0),
            "UniswapV2: PAIR_EXISTS"
        ); // single check is sufficient

        // Deploy salted Pair contract
        bytes memory bytecode = type(UniswapV2Pair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }

        /* A better way to do the above might be the following:

        UniswapV2Pair pair = new UniswapV2Pair{salt: salt}();
        address pairAddr = address(pair);
        
        */

        IUniswapV2Pair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external override {
        require(
            msg.sender == feeToSetter,
            "UniswapV2: FEE_TO_SETTER_FORBIDDEN"
        );
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external override {
        require(
            msg.sender == feeToSetter,
            "UniswapV2: FEE_TO_SETTER_FORBIDDEN"
        );
        feeToSetter = _feeToSetter;
    }
}
