|mo me p1 p2 mo2 me2|
mo := Prompter prompt: 'Ingresa monto'.
me := Prompter prompt: 'Ingresa metodo'.
p1 := Pago crearPagoMont: mo met: me.
mo2 := Prompter prompt: 'Ingresa monto'.
me2 := Prompter prompt: 'Ingresa metodo'.
p2 := Pago crearPagoMont: mo2 met: me2.
p1 inspect.
p2 inspect.