// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Util.sol';

contract UtilTest {
    uint256[] a=[1,4,6,7,8,10];
    uint256[] b=[2,4,6,8,9,11];
    function testreverseString(string calldata testStr) external pure returns (string memory) {
        return Util.reverseString(testStr);
    }

    function testMerge() external view returns (uint256[] memory){
        return Util.mergeArray(a,b);
    }

    function testBinarySearch() external view returns (bool,uint256){
        return Util.binarySearch(b,7);
    }

    function testIntToRoman(uint256 x) external pure returns (string memory) {
        return Util.intToRoman(x);
    }

    function testRomanToInt(string calldata s) external pure returns (uint256){
        return Util.romanToInt(s);
    }
}