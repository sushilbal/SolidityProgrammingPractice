pragma solidity ^0.5.0;

contract CRUD{
    struct User{
        uint id;
        string name;        
    }
    User[] users;
    uint nextId=1;

    function addUser(string memory _name) public{
       users.push(User(nextId,_name));
       nextId++;
    }

    function readUser(uint _position) public view returns (string memory,uint){
        if(_position <= users.length){
            return (users[_position].name,users[_position].id);
        }
    }
    
    function updateUser(uint _id,string memory _name) public returns(bool){
        uint _i = findUser(_id);
        users[_i].name=_name;
        return true;
    }

    function removeUser(uint _id) public {
        uint _i = findUser(_id);
        delete users[_i];
    }

    function findUser(uint _id) internal returns(uint){
        if(users.length > 0){
            for(uint8 i=1; i < users.length ;i++){
                if(users[i].id == _id){
                    return i;
                }
            }
            revert("Users doesn't exists!");
        }
        revert("First Add users to user array!");
    }
}