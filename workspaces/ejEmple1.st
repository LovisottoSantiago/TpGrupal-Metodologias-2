|i n r e|
n := Prompter prompt: 'Ingrese un nombre'.
i := Prompter prompt: 'Ingrese un id'.
r := Prompter prompt: 'Ingrese un rol'.
e := Empleado crearEmpleId: i nom: n.
e asignarRol: r.
e inspect.
