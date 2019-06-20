pragma solidity ^0.5.8;

contract StringManipulation{
    /**
        Concatinating the String and the String Length.
     */

     function getStringLength(string memory _str) public pure returns(uint){
         bytes memory str_bytes = bytes(_str);
            return str_bytes.length;
     }

     function stringConcat(string memory str1,string memory str2) 
        public pure returns(string memory){
            bytes memory str1_bytes=bytes(str1);
            bytes memory str2_bytes=bytes(str2);
            string memory str = new string(str1_bytes.length+str2_bytes.length);
            bytes memory str_bytes=bytes(str);
            uint j=0;
            for (uint i=0;i<str1_bytes.length;i++){
                str_bytes[j] = str1_bytes[i];
                j++;
            }
            for (uint i=0;i<str2_bytes.length;i++){
                str_bytes[j] = str2_bytes[i];
                j++;
            }
            return string(str_bytes);
     }
}