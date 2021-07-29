// contracts/interfaces/IUniswapV2Pair.sol
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./IUniswapV2ERC20.sol";

/// @title UniswapV2 liquidity pool
interface IUniswapV2Pair is IUniswapV2ERC20 {
    event Mint(address indexed sender, uint256 amount0, uint256 amount1);

    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    /// @notice UniswapV2 Factory address
    function factory() external view returns (address);

    /// @notice Token0 address
    function token0() external view returns (address);

    /// @notice Token1 address
    function token1() external view returns (address);

    /// @notice Returns reserves of tokens in pool + timestamp at last cache
    function getReserves()
        external
        view
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    /// @notice Cumulative price of token1/token0
    function price0CumulativeLast() external view returns (uint256);

    /// @notice Cumulative price of token1/token0
    function price1CumulativeLast() external view returns (uint256);

    /// @notice Last recorded constant k = a*b (reserve0*reserve1)
    /// @dev This gets updated every liquidity event i.e. when minting or burning LP tokens
    function kLast() external view returns (uint256);

    /// @notice Mint LP tokens
    /// @dev This is a low-level function whose caller needs to perform security checks
    function mint(address to) external returns (uint256 liquidity);

    /// @notice Burn LP tokens
    /// @dev This is a low-level function whose caller needs to perform security checks
    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

    /// @notice Swap 
    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    /// @notice Force balances to match reserves
    function skim(address to) external;

    /// @notice Force reserves to match balances
    function sync() external;

    /// @notice Initialize token addresses
    /// @dev Called once by the factory at deployment
    function initialize(address, address) external;
}

/* DEPRECATED CODE
interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    // ERC20
    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    // ERC20 Permit (EIP-2612)
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);
    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    // Custom Pair Code
    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}
*/
