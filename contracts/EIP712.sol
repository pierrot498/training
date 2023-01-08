pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EIP712 {

    address public owner;
    address public test;

    struct EIP712Domain {
        string  name;
        string  version;
        uint256 chainId;
        address verifyingContract;
    }

    struct Voucher {
        address token;
        address user;
        uint256 amount;
        uint256 timestamp;
    }

    

    bytes32 constant VOUCHER_TYPEHASH = keccak256("Voucher(address token,address user,uint256 amount,uint256 timestamp)");

    bytes32 constant EIP712DOMAIN_TYPEHASH = keccak256(
        "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
    );
   
   bytes32 DOMAIN_SEPARATOR;

    constructor() {
        owner = msg.sender;
        DOMAIN_SEPARATOR = hash(EIP712Domain({
            name: "Ether Mail",
            version: '1',
            chainId: 111,
            verifyingContract: address(this)
        }));
    }

    function hash(EIP712Domain memory eip712Domain) internal pure returns (bytes32) {
        return keccak256(abi.encode(
            EIP712DOMAIN_TYPEHASH,
            keccak256(bytes(eip712Domain.name)),
            keccak256(bytes(eip712Domain.version)),
            eip712Domain.chainId,
            eip712Domain.verifyingContract
        ));
    }

    function hash(Voucher memory voucher) internal pure returns (bytes32) {
        return keccak256(abi.encode(
            VOUCHER_TYPEHASH,
            voucher.token,
            voucher.user,
            voucher.amount,
            voucher.timestamp
        ));
    }

    function verif(Voucher memory voucher, uint8 v, bytes32 r, bytes32 s) public view returns (address) {
        // Note: we need to use `encodePacked` here instead of `encode`.
        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            DOMAIN_SEPARATOR,
            hash(voucher)
        ));
        return ecrecover(digest, v, r, s);
    }

    
    function changeOwner(address addr) external {
        require(owner == msg.sender);
        owner = addr;
    }

}