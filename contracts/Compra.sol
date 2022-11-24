pragma solidity ^0.4.0;

contract Comprar {
    bool estadoEnvio;
    string nombreProducto;
    uint valorProducto;
    uint256 public id = 0;
    address public comprador = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    address public vendedor = msg.sender;

    event CompraCreada(
        uint256 id,
        string nombreProducto,
        uint valorProducto,
        address comprador,
        bool estadoEnvio
    );

    struct CompraProducto {
        uint256 id;
        string nombreProducto;
        uint valorProducto;
        address comprador;
        bool estadoEnvio;
    }
    mapping(uint256 => CompraProducto) public compraProducto;

    constructor(string _nombreProducto, uint256 _valorProducto) public payable {
        id++;
        nombreProducto = _nombreProducto;
        valorProducto = _valorProducto;
        estadoEnvio = false;
    }

    function CrearComprar() public payable {
        uint valorCompraConGarantia=valorProducto*2;
        require (valorCompraConGarantia < msg.value,"Vendedor, Dinero insuficiente");
        address(comprador).balance;
        uint valorComprador = msg.value;
        require (valorCompraConGarantia <  valorComprador,"Comprador, Dinero insuficiente");
        compraProducto[id] = CompraProducto(
            id,
            nombreProducto,
            valorProducto,
            comprador,
            estadoEnvio
        );
        emit CompraCreada(
            id,
            nombreProducto,
            valorProducto,
            comprador,
            estadoEnvio
        );
        id++;
    }

    function confirmarRecibirProductoTransferirGarantia(uint256 _id) public payable {
        CompraProducto memory c = compraProducto[_id];
        c.estadoEnvio = true;
        address(comprador).transfer(c.valorProducto);//Se le retorna el valor de la garantia al comprador
    }

    function reembolsarAlVendedor(uint256 _id) public payable {
        CompraProducto memory c = compraProducto[_id];
        if (c.estadoEnvio == true) {
            address(vendedor).transfer(c.valorProducto * 3); //se el retorna el valor de la garantia + producto que antes dio + la compra
        }
    }

    function abortarCompra(uint256 _id) public {
        CompraProducto memory c = compraProducto[_id];
        if (c.estadoEnvio == true) {
            revert();
        }
    }
}
