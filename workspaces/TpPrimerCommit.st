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
        '2. (b) Ver consultas (select, collect, reject, detect)' , String cr ,
        '3. (c) Ver Conteo de Platos (Dictionary)' , String cr ,
        '4. (d) Ver Menu Ordenado por Precio' , String cr ,
        '------------------------------------------' , String cr ,
        '0. Salir' , String cr , String cr ,
        'Ingrese su opcion:'.
    
    "Pedimos la opcion al usuario - Version simple (Prompter prompt:)"
    opcion := Prompter prompt: menuString.

    "Si el usuario aprieta Cancelar o deja vacio, opcion es nil/vacio. Lo tratamos como '0' (Salir)"
    (opcion isNil or: [opcion isEmpty]) ifTrue: [ opcion := '0' ].

    Transcript show: '--- Opcion Elegida: ', opcion, ' ---'; cr.

    "--- OPCION 1: (5.a) Cargar y simular (Usando TUS CONSTRUCTORES) ---"
    opcion = '1' ifTrue: [
        Transcript show: 'Cargando instancias...'; cr; cr.
        
        "1. Crear Restaurante (Asumo 'crearRestauranteId:nom:dir:tel:')"
        miRestaurante := Restaurante 
                            crearRestauranteId: 1 
                            nom: 'El Rincon de Smalltalk' 
                            dir: 'Calle Falsa 123' 
                            tel: '555-1234'.
        
        "2. Cargar Platos (Menu) (Usando 'crearPlaId:nom:desc:pre:')"
        plato1 := Plato crearPlaId: 10 nom: 'Milanesa con Fritas' desc: 'Clasica' pre: 12000.
        plato2 := Plato crearPlaId: 20 nom: 'Fideos con Tuco' desc: 'Pasta' pre: 9000.
        plato3 := Plato crearPlaId: 30 nom: 'Ensalada Cesar' desc: 'Pollo y aderezo' pre: 10000.
        plato4 := Plato crearPlaId: 40 nom: 'Agua sin Gas' desc: 'Bebida' pre: 3000.
        miRestaurante agregarPlato: plato1.
        miRestaurante agregarPlato: plato2.
        miRestaurante agregarPlato: plato3.
        miRestaurante agregarPlato: plato4.
        
        "3. Cargar Empleados (Asumo constructor 'crearEmpleadoId:nom:rol:')"
        mozo1 := Empleado crearEmpleadoId: 1 nom: 'Juan Perez' rol: 'Mozo'.
        mozo2 := Empleado crearEmpleadoId: 2 nom: 'Maria Gomez' rol: 'Mozo'.
        miRestaurante agregarEmpleado: mozo1.
        miRestaurante agregarEmpleado: mozo2.
        
        "4. Cargar Mesas (Usando 'crearMesaId:capa:')"
        mesa1 := Mesa crearMesaId: 1 capa: 4.
        mesa2 := Mesa crearMesaId: 2 capa: 2.
        mesa3 := Mesa crearMesaId: 3 capa: 4.
        miRestaurante agregarMesa: mesa1.
        miRestaurante agregarMesa: mesa2.
        miRestaurante agregarMesa: mesa3.
        
        "5. Cargar Clientes (Usando 'crearCliId:nom:tel:email:')"
        cliente1 := Cliente crearCliId: 100 nom: 'Ana' tel: '555-1111' email: 'ana@mail.com'.
        cliente2 := Cliente crearCliId: 101 nom: 'Luis' tel: '555-2222' email: 'luis@mail.com'.
        miRestaurante agregarCliente: cliente1.
        miRestaurante agregarCliente: cliente2.

        "6. Simular Pedidos (Usando tu constructor de 7 args y DateAndTime now)"
        pedido1 := Pedido 
                    crearPedidoId: 500 
                    fecha: DateAndTime now 
                    estado: 'Abierto' 
                    tipo: 'Salon' 
                    nota: '' 
                    emp: mozo1 
                    cli: cliente1.
        mesa1 ocupar.
        pedido1 agregarPlato: plato1. pedido1 agregarPlato: plato4.
        miRestaurante agregarPedido: pedido1.

        pedido2 := Pedido 
                    crearPedidoId: 501 
                    fecha: DateAndTime now 
                    estado: 'Abierto' 
                    tipo: 'Salon' 
                    nota: 'Sin sal' 
                    emp: mozo2 
                    cli: cliente2.
        mesa2 ocupar.
        pedido2 agregarPlato: plato2.
        miRestaurante agregarPedido: pedido2.

        pedido3 := Pedido 
                    crearPedidoId: 502 
                    fecha: DateAndTime now 
                    estado: 'Abierto' 
                    tipo: 'Salon' 
                    nota: 'Extra queso' 
                    emp: mozo1 
                    cli: cliente1.
        pedido3 agregarPlato: plato1.
        miRestaurante agregarPedido: pedido3.
        
        Transcript show: 'DATOS CARGADOS Y SIMULADOS.'; cr.
        Transcript show: 'Total Pedidos en el sistema: ', miRestaurante pedidos size printString; cr; cr.
    ].

    "--- OPCION 2: (5.b) Consultas ---"
    opcion = '2' ifTrue: [
        miRestaurante isNil
            ifTrue: [ MessageBox warning: 'Por favor, ejecute la opcion 1 primero.' ]
            ifFalse: [
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
                    Transcript show: '  ', nombre, ': ', cantidad printString, ' veces'; cr.
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
                
                menuOrdenado := miRestaurante menu asSortedCollection: [ :platoA :platoB |
    platoA verPrecio < platoB verPrecio
].
                
                menuOrdenado do: [ :plato |
                    Transcript show: '  $', plato verPrecio printString, ' - ', plato nombre; cr.
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