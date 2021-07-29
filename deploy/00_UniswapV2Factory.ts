// Deploy UniswapV2Factory

import { HardhatRuntimeEnvironment as HRE } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async function ({
    getNamedAccounts,
    deployments,
}: HRE) {
    const { deployer } = await getNamedAccounts();
    const { deploy } = deployments;
    console.log("Deploying UniswapV2Factory");
    await deploy("UniswapV2Factory", {
        from: deployer,
        args: [deployer]
    });
};

export default func;
func.tags = ["UniswapV2Factory"];
