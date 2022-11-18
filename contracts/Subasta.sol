pragma solidity ^0.4.0;

contract Subasta{
uint256 private tiempoTotalMinToMils;
 uint256 public id=0;
 string public nombreSubasta;
 uint256 public valor;
 bool public estado;
 uint256 public tiempoCreacion;
 uint256 public tiempoLimiteEnMin;

constructor(string  _nombreSubasta,uint256  _tiempoLimite) payable public{
        id++;
        nombreSubasta = _nombreSubasta;
        valor = msg.value;
        estado = true;
        tiempoCreacion=block.timestamp;
        tiempoTotalMinToMils = _tiempoLimite*60000 ;
        tiempoLimiteEnMin=tiempoCreacion+tiempoTotalMinToMils;
    }
   function pujar() payable public{
        require (valor > msg.value,"Dinero insuficiente"); 
        require (!estado,"El estado ya no es valido para la subasta"); 
        require ( tiempoTotalMinToMils-block.timestamp<=0,"Lo sentimo el tiempo de la subasta termino"); 
        if(msg.value>valor){
            selfdestruct(msg.sender); //se retorna el dinero al remitente anterior
        }
        valor = msg.value;
        address addr = msg.sender;  //Verificar saldo del remitente
        address(this).balance; //Obtener saldo del contrato
        addr.transfer(valor); //Trasferir 
        bool success = addr.send(valor);
        require (success == true,"Se transfirio el dinero"); 
    }

    function ganador()  payable public{
        require (tiempoTotalMinToMils-block.timestamp > 0,"El tiempo aún no termina, no se puede definir quien gana"); 
        if(tiempoTotalMinToMils-block.timestamp <= 0){
            msg.sender;
            msg.value;
        }
    }


 

 
   

}
