pragma solidity ^ 0.4.0;

contract Greeter{
    string _message;
    //el memory almacena la variable
    constructor(string memory  message){
        _message=message;

    }
     function getMessage() public returns(string memory) {
       return _message;
    }
     function setMessage(string memory message) public  {
       _message=message;
    }
    
}
