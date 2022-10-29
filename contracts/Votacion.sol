pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;
contract Votacion{
    uint[] public votes;
    string[] public options;
    constructor(string[] memory _options) public{
        options = _options;
        votes.length=options.length;
    }
    function votar(uint option) public{
       require (option>=0 && option < options.length,"Opcion invalida"); // el require revierte el estado de la trx evita que gastes fondos
        assert(votes[1]>=9);
        votes[option]=votes[option]+1;//en en view se puede 
        //accerder a los actibrutos del contratocon peer no
        //if(votes[2]>=9){
        //  revert();
        //}
    }
    function getOpciones() public view returns (string[]) {
        return options;

    }
        function getVotes() public view returns (uint[]) {
        return votes;}
        function calcular(uint a, uint b) public pure returns (uint) {
        return a+b;}

}
