| id1 id2 mo me p1 p2 mo2 me2 pe pe2 |

id1 := (Prompter prompt: 'Ingresa id').
mo  := (Prompter prompt: 'Ingresa monto').
me  := Prompter prompt: 'Ingresa método'. 
pe  := (Prompter prompt: 'Ingresar id de pedido').

p1 := Pago crearPagoId: id1 monto: mo metodo: me pedido: pe.

id2 := (Prompter prompt: 'Ingresa id').
mo2 := (Prompter prompt: 'Ingresa monto').
me2 := Prompter prompt: 'Ingresa método'.
pe2 := (Prompter prompt: 'Ingresar id de pedido').

p2 := Pago crearPagoId: id2 monto: mo2 metodo: me2 pedido: pe2.

p1 inspect.
p2 inspect.
