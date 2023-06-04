// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenLocker.sol";

contract TokenLockerTest is Test {
    TokenLocker public locker;
    uint256 emitterPkey =
        0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6;

    function setUp() public {
        locker = new TokenLocker(0xa0Ee7A142d267C1f36714E4a8F75612F20a79720);
    }

    function testCreate() public {
        locker.create{value: 1e18}(0, address(0), 1e18, address(0), 1e18);
    }

    function testClaim() public {
        locker.create{value: 1e18}(0, address(0), 1e18, address(0), 1e18);
        locker.create{value: 1e18}(0, address(0), 1e18, address(0), 1e18);

        bytes32 digest = locker.hash(1, "EXECUTE");
        console.logBytes32(digest);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            emitterPkey,
            locker.getEthSignedHash(digest)
        );

        console.log(v);
        console.logBytes32(r);
        console.logBytes32(s);

        locker.execute(1, digest, v, r, s);
    }

    function testCancel() public {
        locker.create{value: 1e18}(100, address(0), 1e18, address(0), 1e18);

        bytes32 digest = locker.hash(0, "CANCEL");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            emitterPkey,
            locker.getEthSignedHash(digest)
        );

        locker.requestCancel(0);

        locker.cancel(0, digest, v, r, s);
    }

    function testCancelImmediately() public {
        locker.create{value: 1e18}(100, address(0), 1e18, address(0), 1e18);

        bytes32 digest = locker.hash(0, "CANCEL");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            emitterPkey,
            locker.getEthSignedHash(digest)
        );

        locker.requestCancel(0);

        locker.cancel(0, digest, v, r, s);
    }

    fallback() external payable {}

    receive() external payable {}
}
