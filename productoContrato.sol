// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/*
	*@title Contrato que crea y administra una lista de tareas
        *@author IV4N0203 - AIR.dev
        *@notice Este es un contrato simple con fines educativos
        *@custom:security No uses este código en producción
*/

contract productoContrato {
        /*///////////////
                Definicion de estructura
        ///////////////*/

        ///@dev se usa para guardar la informacion de los productos que se agregan al contrato
        ///@param nombre es el nombre del producto
        ///@param precio es el precio del producto
        ///@param tiempoDeCreacion es el tiempo de creacion del producto

        struct Producto {
            string nombre;
            uint precio;
            uint256 tiempoDeCreacion;
            bool agregado;
        }

        /*///////////////
                Array para los productos
        ///////////////*/

         ///@dev array para los productos, este debe ser publico para facilitar su acceso.
        Producto[] public s_productos;

        /*///////////////
                Eventos
        /*//////////////

        ///@dev el evento se emite cuando un nuevo producto es añadido al array
        ///@param _Producto es el producto que se añade al array
        event productoContrato_ProductoAgregado(Producto _Producto);
         ///@dev el evento se emite cuando un producto es modificado
        event productoContrato_ProductoModificado(Producto _Producto);
         ///@dev el evento se emite cuando un producto es eliminado del array
        event productoContrato_ProductoEliminado(Producto _Producto);

        /*///////////////
                Funciones
        ///////////////*/
        
        ///@dev la funcion crea un producto y lo agrega al array de peliculas
        ///@param _nombre es el nombre del producto
        ///@param _precio es el precio del producto
        function agregarProducto(string memory _nombre, uint256 _precio) external {
                Producto memory nuevoProducto = Producto({
                        nombre: _nombre,
                        precio: _precio,
                        tiempoDeCreacion: block.timestamp,
                        agregado: true
                });
                s_productos.push(nuevoProducto);
                emit productoContrato_ProductoAgregado(nuevoProducto);
        }
        /*
               @dev la funcion elimina un producto del array de productos
               @dev se elimina el producto que coincida con el nombre del producto
               @param _nombre es el nombre del producto
        */
        function eliminarProducto(string memory _nombre) external {
                uint256 tamano = s_productos.length;

                for (uint256 i = 0; i < tamano; i++) {
                        if (keccak256(abi.encodePacked(_nombre)) == keccak256(abi.encodePacked(s_productos[i].nombre))){
                                s_productos[i] = s_productos [tamano - 1 ];
                                s_productos.pop();
                                emit productoContrato_ProductoEliminado(s_productos[i]);
                                return;
                        }
                }
        }
        /*
        *@dev la funcion trae todos los productos cargados en el array
        @return Productos[] memoria todosLosProductos
        */
        function traerProductos() external view returns (Producto[] memory todosLosProductos) {
                return s_productos;

        }
        }