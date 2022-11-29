// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Billetera {
    uint256 public id = 0;
    address payable public owner = payable(msg.sender);
    uint256 public cantidad;
    bool success = false;
    mapping(uint256 => DatosBilletera) public Infobilletera;
 event CrearBilletera(
        uint256 id,
        address payable owner,
        uint256 cantidad
    );
    struct DatosBilletera {
        uint256 id;
        address payable owner;
        uint256 cantidad;
    }
    function creaBilletera(uint256 _cantidad) public payable {
        Infobilletera[id] = DatosBilletera( id, owner,_cantidad );
        emit CrearBilletera(id,owner,_cantidad);
        id++;
    }

    function retirar(uint256 _id, uint _cantidad) public payable {
        DatosBilletera memory c = Infobilletera[_id];
        if (c.owner == payable(msg.sender)) {
            c.cantidad=c.cantidad-_cantidad;
            address payable addr = payable(msg.sender); //Verificar saldo del remitente
            address(this).balance; //Obtener saldo del contrato
            addr.transfer(_cantidad); //Trasferir
            success = addr.send(_cantidad);
        }
        require(success == true, "Se transfirio el dinero");
    }

    function obtenerSaldo() public view returns (uint256 _id) {
         DatosBilletera memory c = Infobilletera[_id];
        return c.cantidad;}
}
