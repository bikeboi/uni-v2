// Deploy UniswapV2ERC20 contract

import { HardhatRuntimeEnvironment as HRE } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function ({
    getNamedAccounts,
    deployments,
}: HRE) {
    const { deployer } = await getNamedAccounts();
    const { deploy } = deployments;
    console.log("Deploying UniswapV2Pair");
    await deploy("UniswapV2Pair", {
        from: deployer,
    });
};

export default func;
func.tags = ["UniswapV2Pair"];
