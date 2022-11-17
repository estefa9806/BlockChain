pragma solidity ^0.4.0;

contract Subasta{

 uint256 public id=0;
 string public nombreSubasta;
 uint256 public valor;
 bool public estado;
 uint256 public tiempoCreacion;
 uint256 public tiempoLimite;

constructor(string  _nombreSubasta, uint256  _valor,uint256  _tiempoLimite) public{
        id++;
        nombreSubasta = _nombreSubasta;
        valor = _valor;
        estado = true;
        tiempoCreacion=block.timestamp;
        tiempoLimite=tiempoCreacion+_tiempoLimite;
    }
   function pujar() payable public{
        require (valor > msg.value,"Dinero insuficiente"); 
        require (!estado && tiempoLimite-block.timestamp<=0,"Subasta no disponibleS"); 
        valor = msg.value;
       //Verificar saldo del remitente
       address addr = msg.sender;
       // Obtener saldo
        uint balance = addr.balance;
       //Obtener saldo del contrato
       address(this).balance;
       //Trasferir 
      addr.transfer(valor);
      bool success = addr.send(valor);
        require (success == true,"Se transfirio el dinero"); 
    }


 

 
   

}
