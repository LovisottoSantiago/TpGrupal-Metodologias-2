productos := OrderedCollection new.

productos add: (Producto crearProduCodigo: 1 nom: 'Leche' tipo: 'Lacteo' pre: 2500 sto: 10 stoMin: 15 pro: 'A').
productos add: (Producto crearProduCodigo: 2 nom: 'Detergente' tipo: 'Limpieza' pre: 1800 sto: 30 stoMin: 10 pro: 'B').
productos add: (Producto crearProduCodigo: 3 nom: 'Yogur' tipo: 'Lacteo' pre: 1200 sto: 5 stoMin: 8 pro: 'A').

productos add: (Producto crearProduCodigo: 4 
    nom: 'Queso Cremoso' 
    tipo: 'Lacteo' 
    pre: 3200 
    sto: 4 
    stoMin: 10 
    pro: 'C').

productos add: (Producto crearProduCodigo: 5 
    nom: 'Shampoo Pantene' 
    tipo: 'Limpieza' 
    pre: 2100 
    sto: 25 
    stoMin: 20 
    pro: 'B').

productos add: (Producto crearProduCodigo: 6 
    nom: 'Arroz Gallo Oro' 
    tipo: 'Alimento' 
    pre: 1600 
    sto: 50 
    stoMin: 30 
    pro: 'A').

productos add: (Producto crearProduCodigo: 7 
    nom: 'Jabón Rexona' 
    tipo: 'Limpieza' 
    pre: 900 
    sto: 60 
    stoMin: 25 
    pro: 'C').

productos add: (Producto crearProduCodigo: 8 
    nom: 'Manteca Sancor' 
    tipo: 'Lacteo' 
    pre: 2800 
    sto: 8 
    stoMin: 12 
    pro: 'A').

productos add: (Producto crearProduCodigo: 9 
    nom: 'Fideos Lucchetti' 
    tipo: 'Alimento' 
    pre: 1300 
    sto: 35 
    stoMin: 20 
    pro: 'B').

productos add: (Producto crearProduCodigo: 10 
    nom: 'Lavandina Ayudín' 
    tipo: 'Limpieza' 
    pre: 1500 
    sto: 5 
    stoMin: 15 
    pro: 'C').

(productos select: [ :p | p stock <= p stockMinimo ])
    collect: [ :p | p precio ].

cantA := (productos select: [ :p | p proveedor = 'A' ]) size.
cantB := (productos select: [ :p | p proveedor = 'B' ]) size.
cantA < cantB.

(productos select: [:p | p precio > 2000 ]) size > 0.

(productos select: [:p | p tipo = 'Lacteo'])
	collect: [:p | p nombre ].

(productos select: [:p | p tipo = 'Limpieza']) size.


