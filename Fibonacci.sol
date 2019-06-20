pragma solidity ^0.5.0;

contract Fibonacci{

    function fibonacci(uint n) external pure returns(uint){
        uint sum=0;
        if(n==0){
            return sum;
        }
        uint f0=0;
        uint f1=1;
        for (uint i=1;i<n;i++){
            sum=f0+f1;
            f0=f1;
            f1=sum;
        }
        return sum;
        
    }
}