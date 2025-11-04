| miRestaurante opcion menuString plato1 plato2 plato3 plato4 mozo1 mozo2 cliente1 cliente2 mesa1 mesa2 mesa3 platosCaros nombresEmpleados mesasLibres empleadoJuan conteoPlatos menuOrdenado validOptions nombrePlato clienteNombre clienteEncontrado mesaLibre mozoAsignado nuevoPedido platoEncontrado tipoCliente nombreNuevo telNuevo emailNuevo platoIdString mesaIdString mesaEncontrada mesasOcupadas |

"Inicializamos las variables"
miRestaurante := nil.
opcion := ''.
Transcript clear.
Transcript show: '*** BIENVENIDO A LA APLICACION DEL RESTAURANTE ***'; cr; cr.
validOptions := #('0' '1' '2' '3' '4' '5' '6'). "Ajustamos las opciones validas"

"--- (5.a) Cargar instancias "
Transcript show: 'Cargando instancias estaticas (Menu, Empleados, Clientes)...'; cr; cr.

"1. Crear Restaurante"
miRestaurante := Restaurante 
                    crearRestauranteId: 1 
                    nom: 'El Rincon de Smalltalk' 
                    dir: 'Calle Falsa 123' 
                    tel: '555-1234'.

"2. Cargar Platos (Menu)"
plato1 := Plato crearPlaId: 10 nom: 'Milanesa con Fritas' desc: 'Clasica' pre: 12000.
plato2 := Plato crearPlaId: 20 nom: 'Fideos con Tuco' desc: 'Pasta' pre: 9000.
plato3 := Plato crearPlaId: 30 nom: 'Ensalada Cesar' desc: 'Pollo y aderezo' pre: 10000.
plato4 := Plato crearPlaId: 40 nom: 'Agua sin Gas' desc: 'Bebida' pre: 3000.
miRestaurante agregarPlato: plato1.
miRestaurante agregarPlato: plato2.
miRestaurante agregarPlato: plato3.
miRestaurante agregarPlato: plato4.

"3. Cargar Empleados"
mozo1 := Empleado crearEmpleadoId: 1 nom: 'Juan Perez' rol: 'Mozo'.
mozo2 := Empleado crearEmpleadoId: 2 nom: 'Maria Gomez' rol: 'Mozo'.
miRestaurante agregarEmpleado: mozo1.
miRestaurante agregarEmpleado: mozo2.

"4. Cargar Mesas"
mesa1 := Mesa crearMesaId: 1 capa: 4 num: 1.
mesa2 := Mesa crearMesaId: 2 capa: 2 num: 2.
mesa3 := Mesa crearMesaId: 3 capa: 4 num: 3.
miRestaurante agregarMesa: mesa1.
miRestaurante agregarMesa: mesa2.
miRestaurante agregarMesa: mesa3.

"5. Cargar Clientes "
cliente1 := Cliente crearCliId: 100 nom: 'Ana' tel: '555-1111' email: 'ana@mail.com'.
cliente2 := Cliente crearCliId: 101 nom: 'Luis' tel: '555-2222' email: 'luis@mail.com'.
miRestaurante agregarCliente: cliente1.
miRestaurante agregarCliente: cliente2.

Transcript show: 'DATOS ESTATICOS CARGADOS.'; cr.
Transcript show: '--- Mostrando Menu ---'; cr; cr.


"Bucle principal del menu"
[ opcion ~= '0' ] whileTrue: [
    
    "--- MOSTRAMOS EL MENU EN EL TRANSCRIPT ---"
    Transcript show: '*** Menu Interactivo Restaurante ***'; cr.
    Transcript show: 'Estado: ' , (miRestaurante nombre , ' (Cargado) - Pedidos: ' , miRestaurante pedidos size printString); cr.
    Transcript show: '------------------------------------------'; cr.
    Transcript show: '1. (b) Ver Consultas (select, collect, reject, detect)'; cr.
    Transcript show: '2. (c) Ver Conteo de Platos (Dictionary)'; cr.
    Transcript show: '3. (d) Ver Menu Ordenado por Precio'; cr.
    Transcript show: '4. (a) Simular Nuevo Pedido Interactivo'; cr.
    Transcript show: '5. Ver Pedido de una Mesa Ocupada'; cr.
    Transcript show: '6. Pagar y Desocupar Mesa'; cr.
    Transcript show: '------------------------------------------'; cr.
    Transcript show: '0. Salir'; cr; cr.

    "--- PEDIMOS LA OPCION EN UN PROMPTER SIMPLE ---"
    menuString := 'Ingrese su opcion (1-6, 0 para Salir):'.
    opcion := Prompter prompt: menuString.
    (opcion isNil or: [opcion isEmpty]) ifTrue: [ opcion := '0' ].
    Transcript show: '--- Opcion Elegida: ', opcion, ' ---'; cr.


    "--- OPCION 1: (5.b) Consultas ---"
    opcion = '1' ifTrue: [
        Transcript show: '--- 5.b) Ejemplos de colecciones ---'; cr.
        
        "SELECT: Platos caros"
        platosCaros := miRestaurante menu select: [ :plato | plato verPrecio > 9500 ].
        Transcript show: 'Platos caros (>$9500): '; cr.
        platosCaros do: [ :p | Transcript show: '  - ', p nombre; cr ].

        "COLLECT: Nombres de empleados"
        nombresEmpleados := miRestaurante empleados collect: [ :empleado | empleado nombre ].
        Transcript show: 'Nombres de empleados: '; cr.
        Transcript print: nombresEmpleados; cr.

        "REJECT: Mesas libres"
        mesasLibres := miRestaurante mesas reject: [ :mesa | mesa verEstado ].
        Transcript show: 'Mesas libres (No ocupadas): '; cr.
        mesasLibres do: [ :m | Transcript show: '  - Mesa Nro: ', m numero printString; cr ].

        "DETECT: Encontrar a Juan Perez"
        empleadoJuan := miRestaurante empleados 
            detect: [ :emp | emp nombre = 'Juan Perez' ] 
            ifNone: [ nil ].
        Transcript show: 'Buscando a Juan Perez... '; cr.
        (empleadoJuan notNil)
            ifTrue: [ Transcript show: '  Encontrado: ', empleadoJuan nombre ]
            ifFalse: [ Transcript show: '  No se encontro.' ].
        Transcript cr.
    ].

    "--- OPCION 2: (5.c) Diccionario ---"
    opcion = '2' ifTrue: [
        Transcript show: '--- 5.c) Conteo de Platos Pedidos (con Dictionary) ---'; cr.
        
        miRestaurante pedidos isEmpty
            ifTrue: [ Transcript show: 'No hay pedidos registrados para contar.'; cr ]
            ifFalse: [
                conteoPlatos := Dictionary new.
                miRestaurante pedidos do: [ :pedido |
                    pedido platos do: [ :plato |
                        nombrePlato := plato nombre.
                        conteoPlatos at: nombrePlato put: (conteoPlatos at: nombrePlato ifAbsent: [ 0 ]) + 1.
                    ].
                ].
                
                conteoPlatos keysAndValuesDo: [ :nombre :cantidad |
                    Transcript show: '  ', nombre, ': ', cantidad printString, ' veces'; cr.
                ].
            ].
        Transcript cr.
    ].
    
    "--- OPCION 3: (5.d) Ordenado ---"
    opcion = '3' ifTrue: [
        Transcript show: '--- 5.d) Menu ordenado por Precio (ascendente) ---'; cr.
        
        menuOrdenado := miRestaurante menu asSortedCollection: [ :platoA :platoB |
            platoA verPrecio < platoB verPrecio
        ].
        
        menuOrdenado do: [ :plato |
            Transcript show: '  $', plato verPrecio printString, ' - ', plato nombre; cr.
        ].
        Transcript cr.
    ].

    "--- OPCION 4: (5.a) Simular Pedido Interactivo ---"
    opcion = '4' ifTrue: [
        Transcript show: '--- (5.a) Iniciando Simulacion de Pedido ---'; cr.
        clienteEncontrado := nil. "Reseteamos el cliente"

        "1. Buscar Mesa Libre"
        mesaLibre := miRestaurante mesas detect: [ :m | m verEstado = false ] ifNone: [ nil ].

        mesaLibre isNil
            ifTrue: [ MessageBox warning: 'No hay mesas libres en este momento.' ]
            ifFalse: [
                "2. Preguntar por Cliente (Nuevo o Recurrente)"
                tipoCliente := Prompter prompt: 'El cliente es: 1-Recurrente o 2-Nuevo?'.
                
                (tipoCliente isNil or: [tipoCliente isEmpty])
                    ifTrue: [ Transcript show: 'Simulacion cancelada.'; cr ]
                    ifFalse: [
                        
                        tipoCliente = '1' ifTrue: [
                            "Es RECURRENTE: lo buscamos"
                            clienteNombre := Prompter prompt: 'Ingrese el nombre del cliente (Ej: Ana, Luis):'.
                            (clienteNombre isNil or: [clienteNombre isEmpty])
                                ifFalse: [
                                    clienteEncontrado := miRestaurante clientes detect: [ :c | c nombre = clienteNombre ] ifNone: [ nil ].
                                    clienteEncontrado isNil ifTrue: [ MessageBox warning: 'Cliente no encontrado.' ]
                                ]
                        ].

                        tipoCliente = '2' ifTrue: [
                            "Es NUEVO: creamos la instancia"
                            Transcript show: 'Creando nuevo cliente...'; cr.
                            nombreNuevo := Prompter prompt: 'Ingrese Nombre:'.
                            telNuevo := Prompter prompt: 'Ingrese Telefono:'.
                            emailNuevo := Prompter prompt: 'Ingrese Email:'.
                            
                            (nombreNuevo isNil or: [nombreNuevo isEmpty])
                                ifTrue: [ MessageBox warning: 'El nombre no puede ser vacio.' ]
                                ifFalse: [
                                    clienteEncontrado := Cliente 
                                                            crearCliId: (miRestaurante clientes size + 100) 
                                                            nom: nombreNuevo 
                                                            tel: telNuevo 
                                                            email: emailNuevo.
                                    miRestaurante agregarCliente: clienteEncontrado.
                                    Transcript show: 'Cliente nuevo ', nombreNuevo, ' agregado.'; cr.
                                ]
                        ].

                        "3. Si tenemos un cliente (nuevo o encontrado), continuamos"
                        clienteEncontrado notNil
                            ifTrue: [
                                "Asignar Mozo (usamos el primero)"
                                mozoAsignado := miRestaurante empleados detect: [ :e | e rol = 'Mozo' ] ifNone: [ nil ].
                                
                                "Crear Pedido"
                                nuevoPedido := Pedido 
                                                crearPedidoId: (miRestaurante pedidos size + 500)
                                                fecha: DateAndTime now 
                                                estado: 'Abierto' 
                                                tipo: 'Salon' 
                                                nota: '' 
                                                emp: mozoAsignado 
                                                cli: clienteEncontrado.
                                

                                mesaLibre ocupar: nuevoPedido. 
                                
                                Transcript show: 'Cliente: ', clienteEncontrado nombre, ' asignado a Mesa: ', mesaLibre numero printString; cr.
                                Transcript show: 'Atendido por: ', mozoAsignado nombre; cr.

                                "5. Loop para cargar platos (POR ID)"
                                platoIdString := ''.
                                [ platoIdString ~= 'fin' ] whileTrue: [
                                    
                                    "*** MOSTRAMOS EL MENU CON ID ***"
                                    Transcript show: '--- Menu de Platos Disponibles ---'; cr.
                                    miRestaurante menu do: [ :plato |
                                        Transcript show: '  [', plato id printString, '] ', plato nombre, ' ($', plato verPrecio printString, ')'; cr.
                                    ].
                                    Transcript show: '----------------------------------'; cr.
                                    
                                    platoIdString := Prompter prompt: 'Ingrese ID de plato (o ''fin'' para terminar):'.
                                    
                                    (platoIdString isNil or: [platoIdString isEmpty])
                                        ifTrue: [ platoIdString := 'fin' ]. "Si cancela o deja vacio, termina"

                                    platoIdString = 'fin' 
                                        ifFalse: [
                                            platoEncontrado := miRestaurante menu 
                                                                detect: [ :p | p id printString = platoIdString ] 
                                                                ifNone: [ nil ].
                                            
                                            platoEncontrado isNil
                                                ifTrue: [ MessageBox warning: 'Plato con ese ID no encontrado.' ]
                                                ifFalse: [
                                                    nuevoPedido agregarPlato: platoEncontrado.
                                                    Transcript show: 'Agregado: ', platoEncontrado nombre; cr.
                                                ]
                                        ]
                                ].

                                "Finalizar y agregar (al historial del restaurante)"
                                miRestaurante agregarPedido: nuevoPedido.
                                Transcript show: '--- Pedido Finalizado ---'; cr.
                                Transcript show: 'Total del Pedido: $', nuevoPedido total printString; cr; cr.
                            ]
                            ifFalse: [
                                Transcript show: 'Simulacion cancelada (no se selecciono cliente).'; cr
                            ]
                    ]
            ]
    ].
    
    "--- OPCION 5: Ver Pedido de Mesa Ocupada ---"
    opcion = '5' ifTrue: [
        Transcript show: '--- Ver Pedido de Mesa ---'; cr.
        
        mesasOcupadas := miRestaurante mesas select: [ :m | m verEstado ].
        
        mesasOcupadas isEmpty
            ifTrue: [ Transcript show: 'No hay mesas ocupadas en este momento.'; cr ]
            ifFalse: [
                Transcript show: 'Mesas actualmente ocupadas:'; cr.
                mesasOcupadas do: [ :m | Transcript show: '  - Mesa Nro: ', m numero printString; cr ].
                Transcript show: '--------------------------'; cr.
                
                mesaIdString := Prompter prompt: 'Ingrese el numero de la mesa que desea ver:'.
                (mesaIdString isNil or: [mesaIdString isEmpty])
                    ifFalse: [
                        mesaEncontrada := miRestaurante mesaOcupadaPorNumero: mesaIdString.
                        mesaEncontrada isNil
                            ifTrue: [ MessageBox warning: 'Mesa no encontrada o no esta ocupada.' ]
                            ifFalse: [
                                Transcript show: '--- Pedido Actual Mesa Nro: ', mesaEncontrada numero printString, ' ---'; cr.
                                Transcript show: 'Total actual: $', mesaEncontrada pedidoActual total printString; cr.
                                Transcript show: 'Platos pedidos:'; cr.
                                mesaEncontrada pedidoActual platos do: [ :p |
                                    Transcript show: '  - ', p nombre; cr.
                                ].
                                Transcript cr.
                            ]
                    ]
                    ifTrue: [ Transcript show: 'Accion cancelada.'; cr ].
            ]
    ].

    "--- OPCION 6: Pagar y Desocupar Mesa ---"
    opcion = '6' ifTrue: [
        Transcript show: '--- Pagar y Desocupar Mesa ---'; cr.
        
        mesasOcupadas := miRestaurante mesas select: [ :m | m verEstado ].
        
        mesasOcupadas isEmpty
            ifTrue: [ Transcript show: 'No hay mesas ocupadas para pagar.'; cr ]
            ifFalse: [
                Transcript show: 'Mesas actualmente ocupadas:'; cr.
                mesasOcupadas do: [ :m | Transcript show: '  - Mesa Nro: ', m numero printString; cr ].
                Transcript show: '--------------------------'; cr.
        
                mesaIdString := Prompter prompt: 'Ingrese el numero de la mesa a pagar y liberar:'.
                
                (mesaIdString isNil or: [mesaIdString isEmpty])
                    ifFalse: [
                        mesaEncontrada := miRestaurante mesaOcupadaPorNumero: mesaIdString.
                        mesaEncontrada isNil
                            ifTrue: [ MessageBox warning: 'Mesa no encontrada o no esta ocupada.' ]
                            ifFalse: [
                                Transcript show: 'Cobrando $', mesaEncontrada pedidoActual total printString, ' de la Mesa ', mesaEncontrada numero printString; cr.
                                
                                "Liberamos la mesa"
                                mesaEncontrada desocupar.
                                
                                Transcript show: 'Mesa ', mesaEncontrada numero printString, ' ha sido liberada.'; cr.
                                Transcript cr.
                            ]
                    ]
                    ifTrue: [ Transcript show: 'Accion cancelada.'; cr ].
            ]
    ].
    
    "--- OPCION 0: Salir ---"
    opcion = '0' ifTrue: [
        Transcript show: 'Saliendo...'; cr.
    ].

    "Manejo de opcion invalida"
   (validOptions includes: opcion) 
        ifFalse: [
            Transcript show: 'Opcion invalida: ', opcion; cr.
        ].
    
    Transcript show: '----------------------------------------'; cr; cr.
].

Transcript show: '*** APLICACION FINALIZADA ***'; cr.