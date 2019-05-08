pragma solidity ^0.5.0;

contract AdvanceStorage{
    uint[] advStore;
    uint arrayLength;
    
    function add(uint _data) public {
        arrayLength = advStore.push(_data);
    }
    
    function size()public view  returns(uint){
        return arrayLength;
    }
    
    function remove(uint _index) public {
        if(_index > (advStore.length - 1)) return;
        delete advStore[_index];
    }
    
    function get(uint _index) public view returns(uint){
        return advStore[_index];
    }
    
    function getAll() public view  returns(uint[] memory){
        return advStore;
    }
}