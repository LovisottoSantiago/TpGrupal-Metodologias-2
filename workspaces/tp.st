| miRestaurante opcion menuString plato1 plato2 plato3 plato4 mozo1 mozo2 cliente1 cliente2 mesa1 mesa2 mesa3 pedido1 pedido2 pedido3 platosCaros nombresEmpleados mesasLibres empleadoJuan conteoPlatos menuOrdenado validOptions nombrePlato |

"Inicializamos las variables"
miRestaurante := nil.
opcion := ''.
Transcript clear.
Transcript show: '*** BIENVENIDO A LA APLICACION DEL RESTAURANTE ***'; cr; cr.
Transcript show: 'Por favor, ejecute la opcion 1 para cargar los datos.'; cr; cr.
validOptions := #('0' '1' '2' '3' '4').

"Bucle principal del menu"
[ opcion ~= '0' ] whileTrue: [
    
    "Definimos el texto del menu"
    menuString := '*** Menu Interactivo Restaurante ***' , String cr ,
        'Estado: ' , (miRestaurante isNil 
                        ifTrue: [ 'SIN DATOS' ] 
                        ifFalse: [ miRestaurante nombre , ' (Cargado)' ]) , String cr ,
        '------------------------------------------' , String cr ,
        '1. (5.a) Cargar datos y simular pedidos' , String cr ,
        '2. (5.b) Ver consultas (select, collect, reject, detect)' , String cr ,
        '3. (5.c) Ver Conteo de Platos (Dictionary)' , String cr ,
        '4. (5.d) Ver Menu Ordenado por Precio' , String cr ,
        '------------------------------------------' , String cr ,
        '0. Salir' , String cr , String cr ,
        'Ingrese su opcion:'.
    
    "Pedimos la opcion al usuario - CORRECCION FINAL"
opcion := Prompter 
                prompt: menuString 
                initial: '1'.

    "Si el usuario aprieta Cancelar, opcion es nil. Lo tratamos como '0' (Salir)"
    opcion isNil ifTrue: [ opcion := '0' ].

    Transcript show: '--- Opcion Elegida: ', opcion, ' ---'; cr.

    "--- OPCION 1: (5.a) Cargar y simular ---"
    opcion = '1' ifTrue: [
        Transcript show: 'Cargando instancias...'; cr.
        
        "1. Crear Restaurante"
        miRestaurante := Restaurante new.
        miRestaurante nombre: 'El Rincon de Smalltalk'.
        
        "2. Cargar Platos (Menu)"
        plato1 := Plato crearPlaId: 10; nombre: 'Milanesa con Fritas'; descripcion: 'Clasica'; precio: 12000.
        plato2 := Plato crearPlaId: 20; nombre: 'Fideos con Tuco'; descripcion: 'Pasta'; precio: 9000.
        plato3 := Plato crearPlaId: 30; nombre: 'Ensalada Cesar'; descripcion: 'Pollo y aderezo'; precio: 10000.
        plato4 := Plato crearPlaId: 40; nombre: 'Agua sin Gas'; descripcion: 'Bebida'; precio: 3000.
        miRestaurante agregarPlato: plato1.
        miRestaurante agregarPlato: plato2.
        miRestaurante agregarPlato: plato3.
        miRestaurante agregarPlato: plato4.
        
        "3. Cargar Empleados"
        mozo1 := Empleado crearEmpleadoId: 1; nombre: 'Juan Perez'; rol: 'Mozo'.
        mozo2 := Empleado crearEmpleadoId: 2; nombre: 'Maria Gomez'; rol: 'Mozo'.
        miRestaurante agregarEmpleado: mozo1.
        miRestaurante agregarEmpleado: mozo2.
        
        "4. Cargar Mesas"
        mesa1 := Mesa crearMesaId: 1; capacidad: 4.
        mesa2 := Mesa crearMesaId: 2; capacidad: 2.
        mesa3 := Mesa crearMesaId: 3; capacidad: 4.
        miRestaurante agregarMesa: mesa1.
        miRestaurante agregarMesa: mesa2.
        miRestaurante agregarMesa: mesa3.
        
        "5. Cargar Clientes"
        cliente1 := Cliente crearCliId: 100; nombre: 'Ana'; email: 'ana@mail.com'.
        cliente2 := Cliente crearCliId: 101; nombre: 'Luis'; email: 'luis@mail.com'.
        miRestaurante agregarCliente: cliente1.
        miRestaurante agregarCliente: cliente2.

        "6. Simular Pedidos"
        pedido1 := Pedido crearPedidoId: 500; id_cliente: cliente1 id; id_empleado: mozo1 id.
        mesa1 ocupar.
        pedido1 agregarPlato: plato1. pedido1 agregarPlato: plato4.
        miRestaurante agregarPedido: pedido1.

        pedido2 := Pedido  crearPedidoId: 501; id_cliente: cliente2 id; id_empleado: mozo2 id.
        mesa2 ocupar.
        pedido2 agregarPlato: plato2.
        miRestaurante agregarPedido: pedido2.

        pedido3 := Pedido crearPedidoId: 502; id_cliente: cliente1 id; id_empleado: mozo1 id.
        pedido3 agregarPlato: plato1.
        miRestaurante agregarPedido: pedido3.
        
        Transcript show: 'DATOS CARGADOS Y SIMULADOS.'; cr.
        Transcript show: 'Total Pedidos en el sistema: ', miRestaurante pedidos size asString; cr; cr.
    ].

    "--- OPCION 2: (5.b) Consultas ---"
    opcion = '2' ifTrue: [
        miRestaurante isNil
            ifTrue: [ MessageBox warning: 'Por favor, ejecute la opcion 1 primero.' ]
            ifFalse: [
                Transcript show: '--- 5.b) Ejemplos de colecciones ---'; cr.
                
                "SELECT: Platos caros"
                platosCaros := miRestaurante menu select: [ :plato | plato precio > 9500 ].
                Transcript show: 'Platos caros (>$9500): '; cr.
                platosCaros do: [ :p | Transcript show: '  - ', p nombre; cr ].

                "COLLECT: Nombres de empleados"
                nombresEmpleados := miRestaurante empleados collect: [ :empleado | empleado nombre ].
                Transcript show: 'Nombres de empleados: '; cr.
                Transcript print: nombresEmpleados; cr.

                "REJECT: Mesas libres"
                mesasLibres := miRestaurante mesas reject: [ :mesa | mesa verEstado ].
                Transcript show: 'Mesas libres (No ocupadas): '; cr.
                mesasLibres do: [ :m | Transcript show: '  - Mesa Nro: ', m numero asString; cr ].

                "DETECT: Encontrar a Juan Perez"
                empleadoJuan := miRestaurante empleados 
                    detect: [ :emp | emp nombre = 'Juan Perez' ] 
                    ifNone: [ nil ].
                Transcript show: 'Buscando a Juan Perez... '; cr.
                (empleadoJuan notNil)
                    ifTrue: [ Transcript show: '  Encontrado: ', empleadoJuan nombre ]
                    ifFalse: [ Transcript show: '  No se encontro.' ].
                Transcript cr.
            ]
    ].

    "--- OPCION 3: (5.c) Diccionario ---"
    opcion = '3' ifTrue: [
        miRestaurante isNil
            ifTrue: [ MessageBox warning: 'Por favor, ejecute la opcion 1 primero.' ]
            ifFalse: [
                Transcript show: '--- 5.c) Conteo de Platos Pedidos (con Dictionary) ---'; cr.
                conteoPlatos := Dictionary new.
                
                miRestaurante pedidos do: [ :pedido |
                    pedido platos do: [ :plato |
                        nombrePlato := plato nombre.
                        conteoPlatos at: nombrePlato put: (conteoPlatos at: nombrePlato ifAbsent: [ 0 ]) + 1.
                    ].
                ].
                
                conteoPlatos keysAndValuesDo: [ :nombre :cantidad |
                    Transcript show: '  ', nombre, ': ', cantidad asString, ' veces'; cr.
                ].
                Transcript cr.
            ]
    ].
    
    "--- OPCION 4: (5.d) Ordenado ---"
    opcion = '4' ifTrue: [
        miRestaurante isNil
            ifTrue: [ MessageBox warning: 'Por favor, ejecute la opcion 1 primero.' ]
            ifFalse: [
                Transcript show: '--- 5.d) Menu ordenado por Precio (ascendente) ---'; cr.
                
                menuOrdenado := miRestaurante menu sorted: [ :platoA :platoB |
                    platoA precio < platoB precio
                ].
                
                menuOrdenado do: [ :plato |
                    Transcript show: '  $', plato precio asString, ' - ', plato nombre; cr.
                ].
                Transcript cr.
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