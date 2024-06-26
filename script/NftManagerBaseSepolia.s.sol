// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/NftManager.sol";
import "../src/NftManagerProxy.sol";
import "../src/NftTemplate.sol";
import "../src/NftURITemplate.sol";
import "../src/mock/ERC721Sample.sol";
import "../src/NftManagerStorage.sol";
//ProxyAdmin 0xEeEAD4de3EF2220B7d5d7371a980b58758e1BC29         0x2eB805A0cd246EF4b7C83accb44Ac149989FEDD0
//nftManagerProxy  0x1aa95735855c012130d76a7c736b0c464366c92c   0xe375160Fd53B99466e42fE44Ab1E999203144BE1
//NftURITemplate     0x5a074f4c99853700131858d66de22fe3a6b50186  0xAe354cCeD7A8e8d3d1805F942abF5ce2A6b3ad54
//ERC721Sample
//forge script script/NftManagerBaseSepolia.s.sol:NftManagerScriptBaseSepolia --legacy --broadcast --rpc-url $BASE_SEPOLIA --via-ir
contract NftManagerScriptBaseSepolia is Script {

    ProxyAdmin proxyAdmin;
    NftManager nftManager;
    NftManagerProxy nftManagerProxy;
    NftURITemplate nftURITemplate;
    address serverSigner;

    function setUp() public {
//        proxyAdmin = ProxyAdmin(0xEeEAD4de3EF2220B7d5d7371a980b58758e1BC29);
//        nftManagerProxy = NftManagerProxy(payable(address(0x1Aa95735855C012130D76A7C736B0C464366C92c)));
//        nftManager = NftManager(0x1Aa95735855C012130D76A7C736B0C464366C92c);
//        serverSigner = address(0x3A67CC6D1d167a399497F98CC9076222C9240802);
//
//        nftURITemplate = NftURITemplate(0x99685a8d6B0568D6a0c769F07082007447B54Ab2);
    }

    function run() public {
        uint256 upgradePrivateKey = vm.envUint("UPGRADE_KEY");
        uint256 deployerPrivateKey = vm.envUint("DEPLOY_KEY");
        address deployerAddress = vm.envAddress("DEPLOY_ADDRESS");
        address UPGRADE_ADDRESS = vm.envAddress("UPGRADE_ADDRESS");
        //deploy contract
        if (false) {
            vm.startBroadcast(deployerPrivateKey);
            NftManager nftManagerImpl = new NftManager();
            bytes memory data = abi.encodeWithSelector(NftManager.initialize.selector);
            NftManagerProxy nftManagerProxy = new NftManagerProxy(address(nftManagerImpl), UPGRADE_ADDRESS, data);
            console.log(address(nftManagerProxy));
            NftURITemplate NftURITemplate = new NftURITemplate("NftTemplate", "NT", address(nftManagerProxy), deployerAddress);
            console.log(address(NftURITemplate));
            vm.stopBroadcast();
            return;
        }
        if(true){
            console.log(nftURITemplate.getAuthAdmin());
            return;
        }
        //upgrade contract
        if (false) {
            //            vm.startBroadcast(deployerPrivateKey);
            //            NftManager nftManagerImpl = new NftManager();
            //            vm.stopBroadcast();
            vm.startBroadcast(upgradePrivateKey);
            proxyAdmin.upgradeAndCall(ITransparentUpgradeableProxy(address(nftManagerProxy)), address(0x501FD84bcF9f431778d62fBb1B55a5B07ddF2F6B), new bytes(0));
            vm.stopBroadcast();
            return;
        }
        if (false) {
            vm.startBroadcast(deployerPrivateKey);
            nftManager.addSigner(serverSigner);
            vm.stopBroadcast();
            return;
        }
        if (false) {
            vm.startBroadcast(deployerPrivateKey);
            //0x501fd84bcf9f431778d62fbb1b55a5b07ddf2f6b
            ERC721Sample srcNft = new ERC721Sample();
            console.log("srcNft:", address(srcNft));
            //            NftManager nftManager = NftManager(0xb3a143ee2f41033e3f3c7f69da11e068eda6f90d);
            //            NftManagerProxy nftManagerProxy = NftManagerProxy(0x1aa95735855c012130d76a7c736b0c464366c92c);
            //            NftTemplate nftTemplate = NftTemplate(0x5a074f4c99853700131858d66de22fe3a6b50186);
            vm.stopBroadcast();
            return;
        }
        if (false) {
            vm.startBroadcast(deployerPrivateKey);
            //0x501fd84bcf9f431778d62fbb1b55a5b07ddf2f6b
            ERC721Sample srcNft = ERC721Sample(0x501FD84bcF9f431778d62fBb1B55a5B07ddF2F6B);
            //            srcNft.mint(deployerAddress, "");
            console.log("srcNft:", address(srcNft));
            NftManager nftManager = NftManager(0x0DC57b0cC323f418aa2107095d8E34c3C88004D0);
            NftManagerStorage.AuthData memory srcAuthData = NftManagerStorage.AuthData(address(srcNft), 2, 80001, 11155111, true, 5);
            bytes32 hash = nftManager.hashAuthData(srcAuthData, deployerAddress, 47579229);
            console.logBytes32(hash);
            //sepolia chainid
            //            nftManager.approveInToChain(address(srcNft), 2, 11155111, true, 5);
            vm.stopBroadcast();
            return;
        }
        if (false) {
            vm.startBroadcast(deployerPrivateKey);
            //0x501fd84bcf9f431778d62fbb1b55a5b07ddf2f6b
            ERC721Sample srcNft = ERC721Sample(0x1c5Dd239a7c7e524A7491cc34FA978779dC20452);
            srcNft.mint(deployerAddress, "");
            console.log("srcNft:", address(srcNft));
            NftManager nftManager = NftManager(0x1Aa95735855C012130D76A7C736B0C464366C92c);
            //sepolia chainid
            nftManager.approveInSrcChain(address(srcNft), 2, 11155111, true, 5);
            vm.stopBroadcast();
        }
    }
}
