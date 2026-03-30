// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Util {
    // 反转字符串
    function reverseString(string memory originStr) external pure returns (string memory){
        bytes memory originBytes=bytes(originStr);
        uint256 length=originBytes.length;
        bytes memory outputBytes=new bytes(length);

        for(uint256 i=0;i<length;i++){
            outputBytes[i]=originBytes[length-i-1];
        }

        return string(outputBytes);
    }

    // 罗马转整数
    function romanToInt(string memory s) public pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 n = b.length;
        uint256 result;
        uint256 i;
        
        unchecked {
            while (i < n) {
                // 验证特殊组合
                if (i + 1 < n) {
                    // 拼接字节
                    bytes2 pair = bytes2(uint16(uint8(b[i])) << 8 | uint8(b[i+1]));
                    
                    if (pair == "IV") { 
                        result += 4; 
                        i += 2; 
                        continue; 
                    }
                    if (pair == "IX") { 
                        result += 9; 
                        i += 2; 
                        continue; 
                    }
                    if (pair == "XL") { 
                        result += 40; 
                        i += 2; 
                        continue; 
                    }
                    if (pair == "XC") { 
                        result += 90; 
                        i += 2; 
                        continue; 
                    }
                    if (pair == "CD") { 
                        result += 400; 
                        i += 2; 
                        continue; 
                        }
                    if (pair == "CM") { 
                        result += 900; 
                        i += 2; 
                        continue; 
                    }
                }
                
                bytes1 c = b[i];
                if (c == "I") {
                    result += 1;
                }
                else if (c == "V") {
                    result += 5;
                }
                else if (c == "X") {
                    result += 10;
                }
                else if (c == "L") {
                    result += 50;
                }
                else if (c == "C") {
                    result += 100;
                }
                else if (c == "D") {
                    result += 500;
                }
                else if (c == "M") {
                    result += 1000;
                }
                
                i++;
            }
        }
        
        return result;
    }

    // 整数转罗马
    function intToRoman(uint256 num) public pure returns (string memory) {
        uint256[13] memory values = [
            uint256(1000), 900, 500, 400,
            100, 90, 50, 40,
            10, 9, 5, 4,
            1
        ];
        
        string[13] memory symbols = [
            "M", "CM", "D", "CD",
            "C", "XC", "L", "XL",
            "X", "IX", "V", "IV",
            "I"
        ];
        
        bytes memory result;
        
        for (uint256 i = 0; i < 13; i++) {
            while (num >= values[i]) {
                num -= values[i];
                result = abi.encodePacked(result, symbols[i]);
            }
        }
        
        return string(result);
    }

    // 合并数组
    function mergeArray(uint256[] calldata a,uint256[] calldata b) external pure returns (uint256[] memory){
        uint256 aLength=a.length;
        uint256 bLength=b.length;
        uint256[] memory result=new uint256[](aLength+bLength);

        uint256 ai=0;
        uint256 bi=0;
        uint256 ri=0;
        while(ai<aLength&&bi<bLength){
            if(a[ai]<=b[bi]){
                result[ri++]=a[ai++];
            }else{
                result[ri++]=b[bi++];
            }
        }

        if(ai<aLength){
            result[ri++]=a[ai++];
        }
        if(bi<bLength){
            result[ri++]=b[bi++];
        }
        return result;
    }

    // 二分查找
     function binarySearch(uint256[] calldata arr, uint256 x) 
        external 
        pure 
        returns (bool found, uint256 index) 
    {
        if (arr.length == 0) {
            return (false, 0);
        }
        
        uint256 start = 0;
        uint256 end = arr.length - 1;
        
        while (start <= end) {
            uint256 middle = start + (end - start) / 2;
            
            if (x > arr[middle]) {
                start = middle + 1;
            } else if (x < arr[middle]) {
                if (middle == 0) {
                    break;
                }
                end = middle - 1;
            } else {
                return (true, middle);
            }
        }
        
        return (false, 0);
    }
}