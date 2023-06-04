// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {TokenLocker} from "../src/TokenLocker.sol";

contract Deploy is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(
            0x4d22de0a66e57c6467d61a8101b1c3fa287725b169e6b21feb9e65b0eb2c357b
        );

        TokenLocker locker = new TokenLocker(
            0x98684114447D600cC7a851b5c403c1EAd63fe9bd
        );

        vm.stopBroadcast();
    }
}

contract Claim is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(
            0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
        );

        TokenLocker locker = new TokenLocker(
            0x98684114447D600cC7a851b5c403c1EAd63fe9bd
        );

        locker.create{value: 1e18}(111, address(0), 1e18, address(0), 1e18);
        locker.create{value: 1e18}(111, address(0), 1e18, address(0), 1e18);

        locker.setRecipient(
            0,
            vm.addr(
                uint256(
                    0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
                )
            ),
            1
        );
        locker.setRecipient(
            1,
            vm.addr(
                uint256(
                    0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
                )
            ),
            0
        );

        vm.stopBroadcast();
    }
}

contract Cancel is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(
            0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
        );

        TokenLocker locker = new TokenLocker(
            0x98684114447D600cC7a851b5c403c1EAd63fe9bd
        );

        locker.create{value: 1e18}(111, address(0), 1e18, address(0), 1e18);
        locker.create{value: 1e18}(112, address(0), 1e18, address(0), 1e18);

        locker.setRecipient(
            0,
            vm.addr(
                uint256(
                    0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
                )
            ),
            1
        );
        locker.setRecipient(
            1,
            vm.addr(
                uint256(
                    0xdbda1821b80551c9d65939329250298aa3472ba22feea921c0cf5d620ea67b97
                )
            ),
            0
        );

        locker.requestCancel(1);

        vm.stopBroadcast();
    }
}
