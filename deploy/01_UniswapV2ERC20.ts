// Deploy UniswapV2ERC20 contract

import { HardhatRuntimeEnvironment as HRE } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function ({
    getNamedAccounts,
    deployments,
}: HRE) {
    const { deployer } = await getNamedAccounts();
    const { deploy } = deployments;
    console.log("Deploying UniswapV2ERC20");
    await deploy("UniswapV2ERC20", {
        from: deployer,
    });
}

export default func;
func.tags = ["UniswapV2ERC20"];

