| id1 id2 mo me p1 p2 mo2 me2 |

id1 := (Prompter prompt: 'Ingresa id').
mo  := (Prompter prompt: 'Ingresa monto').
me  := Prompter prompt: 'Ingresa método'. 


p1 := Pago crearPagoId: id1 mon: mo met: me.

id2 := (Prompter prompt: 'Ingresa id').
mo2 := (Prompter prompt: 'Ingresa monto').
me2 := Prompter prompt: 'Ingresa método'.


p2 := Pago crearPagoId: id2 mon: mo2 met: me2.

(p1 verMetodo = p2 verMetodo)
	ifTrue: [
		(p1 verMonto < p2 verMonto) 
			ifTrue: [(p1 verId) inspect]
			ifFalse:[(p2 verId) inspect]
]
ifFalse: [^'Los pagos no tienen el mismo metodo'].

p1 inspect.
p2 inspect.
