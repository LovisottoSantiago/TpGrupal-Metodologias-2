resto := Restaurante crearRestauranteId: 1 nom: 'Lovi’s' dir: 'Av. Mitre 123' tel: 5551234.

mesa1 := Mesa crearMesaId: 1 capa: 4.
mesa2 := Mesa crearMesaId: 2 capa: 2.

emp1 := Empleado crearEmpleadoId: 1 nom: 'Tomás' rol: 'Mozo'.
emp2 := Empleado crearEmpleadoId: 2 nom: 'Lucas' rol: 'Cocinero'.

cli1 := Cliente crearCliId: 1 nom: 'Santiago Lovisotto' tel: '11223344' email: 'santi@gmail.com'.
cli2 := Cliente crearCliId: 2 nom: 'Ana Pérez' tel: '11998877' email: 'ana@gmail.com'.

plato1 := Plato crearPlaId: 1 nom: 'Milanesa con puré' desc: 'Clásico plato argentino' pre: 6500.
plato2 := Plato crearPlaId: 2 nom: 'Pizza especial' desc: 'Jamón, morrones y aceitunas' pre: 7800.
plato3 := Plato crearPlaId: 3 nom: 'Ensalada César' desc: 'Lechuga, pollo y aderezo' pre: 5200.


resto agregarMesa: mesa1.
resto agregarMesa: mesa2.

resto agregarEmpleado: emp1.
resto agregarEmpleado: emp2.

resto agregarCliente: cli1.
resto agregarCliente: cli2.

resto agregarPlato: plato1.
resto agregarPlato: plato2.
resto agregarPlato: plato3.


res1 := Reserva crearReservaFecha: DateAndTime now com: 2 notas: 'Ventana' cliente: cli1.
resto agregarReserva: res1.
cli1 agregarReserva: res1.



pedido1 := Pedido crearPedidoId: 1 
    fecha: DateAndTime now 
    estado: 'Pendiente' 
    tipo: 'En salón' 
    nota: 'Sin sal' 
    emp: emp1 
    cli: cli1.

pedido1 agregarPlato: plato1.
pedido1 agregarPlato: plato3.

cli1 agregarPedido: pedido1.
emp1 agregarPedido: pedido1.
mesa1 agregarPedido: pedido1.



pago1 := Pago crearPagoId: 1 
    fecha: DateAndTime now 
    monto: pedido1 total 
    metodo: 'Efectivo' 
    pedido: pedido1.

pedido1 asignarPago: pago1.



Transcript clear.
Transcript show: 'Restaurante: ', resto verNombre; cr.
Transcript show: 'Empleados: ', (resto verEmpleados collect: [:e | e verNombre]) asString; cr.
Transcript show: 'Clientes: ', (resto verClientes collect: [:c | c verNombre]) asString; cr.
Transcript show: 'Pedido 1 total: ', pedido1 total printString; cr.
Transcript show: 'Pago método: ', pago1 verMetodo; cr.
Transcript show: 'Reserva de: ', res1 verCliente verNombre; cr.
Transcript show: 'Mesa 1 pedidos: ', (mesa1 verPedidos size) printString; cr.
