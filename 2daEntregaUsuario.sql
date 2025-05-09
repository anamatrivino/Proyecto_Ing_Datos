Juan Pablo
/*Crear procedimiento para el registro de los usuarios */
DELIMITER //
CREATE PROCEDURE registrarUsuario(
    IN documentoUsu INT,
    IN nombreUsu VARCHAR(40),
    IN tipoUsu varchar(20),
    IN correoUsu VARCHAR(50),
    IN descripcionActividad VARCHAR(50),
    IN estadoUsu varchar(20)
)
BEGIN
    INSERT INTO usuario(documentoUsu, nombreUsu, tipoUsu, correoUsu, descripcionActividad, estadoUsu)
    VALUES (documentoUsu, nombreUsu, tipoUsu, correoUsu, descripcionActividad, estadoUsu);
END
//
DELIMITER ;


/crear tabla de los usuarios eliminados/
create table historialUsu(
documentoUsu int primary key,
nombreUsu varchar(40) not null,
tipoUsu varchar(20) not null, #hacer una lista desplegable# 
correoUsu varchar(50) not null,
descripcionActividad varchar(50) not null,
estadoUsu boolean null
);

/Crear el trigger que guarda un historial de los usuarios eliminados, como una papelera/
DELIMITER //
create trigger guardarUsuElim
before delete on usuario
for each row
begin 
	insert into historialUsu values (old.documentoUsu, old.nombreUsu, old.tipoUsu, old.correoUsu, old.descripcionActividad, old.estadoUsu);
end
//
DELIMITER ;
describe usuario;


/registro de usuarios/
call registrarUsuario(7310098, 'William Salvador Gómez', 'Administrador', 'willysgomezs@hotmail.com', 'Encargado del manejo financiero y logistico de la finca', 'Activo');
call registrarusuario(1013259709, 'Juan Pablo Gómez', 'Desarrollador y Analista de datos', 'juanpablo.gomezb@urosario.edu.co', 'Encargado el desarrollo del proyecto y el analisis de los datos para cumplir con los requerimientos solicitados por el cliente', 'Activo');
call registrarUsuario(1000077838, 'Ana Maria Triviño', 'Desarrollador y Analista de datos', 'ana.trivino@urosario.edu.co', 'Encargado el desarrollo del proyecto y el analisis de los datos para cumplir con los requerimientos solicitados por el cliente', 'Activo');
call registrarUsuario(1000035548, 'Santiago Mora Camacho', 'Desarrollador y Analista de datos','santiago.moraca@urosario.edu.co', 'Encargado el desarrollo del proyecto y el analisis de los datos para cumplir con los requerimientos solicitados por el cliente', 'Activo');
call registrarUsuario(46675765, 'Pedro Rivera', 'Trabajador Agricola', 'rivpedro@gmail.com', 'Encargado del funcionamiento tecnico de la finca y de los ordeños', 'Activo');
call registrarUsuario(78597054, 'Idinael Martinez', 'Trabajador Agricola', 'maridinael@gmail.com', 'Encargado del funcionamiento tecnico de la finca y de los ordeños', 'Activo');
call registrarUsuario(23481984, 'Maria Luisa Saavedra', 'Dueña','saavmaria@gmail.com', 'Toma de decisiones importantes sobre la finca', 'Activo');
call registrarUsuario(15216545, 'Luis Eduardo Gómez', 'Dueño', 'gomezeduardo@gmail.com', 'Toma de decisiones imortantes sobre la finca', 'Inactivo');
call registrarUsuario(54984877, 'Ferney Rodrigues', 'Veterinario', 'rodriferney@gmail.com', 'Encargado de la salud de los animales y del tema reproductivo de los mismos', 'Inactivo');
call registrarUsuario(85132149, 'Tatiana Lizbeth Cabrera', 'Gerente de tecnología', 'tatianal.cabrera@urosario.edu.co', 'Encargada de la supervisión del proyecto', 'Activo');
CALL RegistrarUsuario(67890123, 'Miguel Ángel Torres', 'Administrador', 'miguel.torres@gmail.com', 'Gestión administrativa de la finca', 'Activo');
CALL RegistrarUsuario(78901234, 'Carolina López', 'Gerente de recursos', 'carolina.lopez@gmail.com', 'Supervisión y optimización de recursos disponibles', 'Activo');
CALL RegistrarUsuario(89012345, 'Fernando Vargas', 'Veterinario', 'fernando.vargas@gmail.com', 'Responsable de la salud de los animales', 'Inactivo');
CALL RegistrarUsuario(90123456, 'Luisa Martínez', 'Dueña', 'luisa.martinez@gmail.com', 'Decisiones estratégicas sobre la finca', 'Inactivo');
CALL RegistrarUsuario(12345000, 'José Rodríguez', 'Trabajador Agrícola', 'jose.rodriguez@gmail.com', 'Apoyo en tareas técnicas y mantenimiento', 'Activo');
CALL RegistrarUsuario(23456100, 'Paula Castro', 'Desarrolladora', 'paula.castro@gmail.com', 'Desarrollo de software para optimización agrícola', 'Inactivo');
CALL RegistrarUsuario(34561234, 'David Gómez', 'Analista de datos', 'david.gomez@gmail.com', 'Análisis de datos para mejorar procesos', 'Activo');
CALL RegistrarUsuario(45612345, 'Alejandra Hernández', 'Gerente de tecnología', 'alejandra.hernandez@gmail.com', 'Supervisión tecnológica de proyectos', 'Activo');
CALL RegistrarUsuario(56712345, 'Ricardo Pérez', 'Trabajador Agrícola', 'ricardo.perez@gmail.com', 'Encargado del funcionamiento técnico de la finca', 'Activo');
CALL RegistrarUsuario(67812345, 'Carmen Cruz', 'Veterinaria', 'carmen.cruz@gmail.com', 'Responsable de la salud de los animales y reproducción', 'Inactivo');
CALL RegistrarUsuario(78912345, 'Gabriel Ortiz', 'Administrador', 'gabriel.ortiz@gmail.com', 'Gestión financiera de la finca', 'Activo');
CALL RegistrarUsuario(89012349, 'Sofia Moreno', 'Dueña', 'sofia.moreno@gmail.com', 'Decisiones clave sobre la finca', 'Activo');
CALL RegistrarUsuario(90123446, 'Marcela Reyes', 'Gerente de logística', 'marcela.reyes@gmail.com', 'Supervisión del transporte y suministro', 'Inactivo');
CALL RegistrarUsuario(23456752, 'Esteban Alarcón', 'Trabajador Agrícola', 'esteban.alarcon@gmail.com', 'Responsable de tareas técnicas diarias', 'Activo');
CALL RegistrarUsuario(34567821, 'Isabel Fernández', 'Desarrolladora y Analista', 'isabel.fernandez@gmail.com', 'Análisis técnico de datos agrícolas', 'Activo');
CALL RegistrarUsuario(45678905, 'Antonio Ruiz', 'Veterinario', 'antonio.ruiz@gmail.com', 'Revisión y salud de animales', 'Activo');
CALL RegistrarUsuario(56789028, 'Camila Vargas', 'Dueña', 'camila.vargas@gmail.com', 'Responsable de decisiones estratégicas', 'Inactivo');
CALL RegistrarUsuario(67890132, 'Hugo Salazar', 'Trabajador Agrícola', 'hugo.salazar@gmail.com', 'Encargado de tareas técnicas', 'Activo');
CALL RegistrarUsuario(78901258, 'Vanesa Pardo', 'Gerente de tecnología', 'vanesa.pardo@gmail.com', 'Encargada de supervisión tecnológica', 'Activo');
CALL RegistrarUsuario(89012384, 'Julian Cifuentes', 'Administrador', 'julian.cifuentes@gmail.com', 'Gestión administrativa de la finca', 'Inactivo');
CALL RegistrarUsuario(90123496, 'Laura Mejía', 'Veterinaria', 'laura.mejia@gmail.com', 'Responsable de salud animal', 'Activo');
CALL RegistrarUsuario(12345637, 'Santiago Valencia', 'Analista de datos', 'santiago.valencia@gmail.com', 'Análisis para optimización de procesos', 'Inactivo');
CALL RegistrarUsuario(23456764, 'Silvia González', 'Desarrolladora y Analista', 'silvia.gonzalez@gmail.com', 'Desarrollo técnico para mejoras agrícolas', 'Activo');
CALL RegistrarUsuario(34567881, 'Alfredo García', 'Trabajador Agrícola', 'alfredo.garcia@gmail.com', 'Mantenimiento técnico de la finca', 'Inactivo');
CALL RegistrarUsuario(45678976, 'Patricia Delgado', 'Dueña', 'patricia.delgado@gmail.com', 'Decisiones clave sobre la finca', 'Activo');
CALL RegistrarUsuario(56789542, 'Oscar Peña', 'Veterinario', 'oscar.pena@gmail.com', 'Revisión de salud y reproducción de animales', 'Inactivo');
CALL RegistrarUsuario(67890378, 'Daniela Ríos', 'Trabajador Agrícola', 'daniela.rios@gmail.com', 'Apoyo en tareas técnicas agrícolas', 'Activo');
CALL RegistrarUsuario(95654132, 'Carlos Blanco', 'Administrador', 'carlos.blanco@gmail.com', 'Gestión logística y financiera', 'Activo');
CALL RegistrarUsuario(23151841, 'Valeria Muñoz', 'Gerente de recursos', 'valeria.munoz@gmail.com', 'Optimización de recursos y supervisión', 'Activo');
CALL RegistrarUsuario(96518812, 'Sebastián Torres', 'Trabajador Agrícola', 'sebastian.torres@gmail.com', 'Encargado del funcionamiento técnico diario', 'Inactivo');
CALL RegistrarUsuario(65468123, 'Natalia Morales', 'Veterinaria', 'natalia.morales@gmail.com', 'Responsable de la salud y bienestar animal', 'Activo');
CALL RegistrarUsuario(28735688, 'Edgar Cuellar', 'Analista de datos', 'edgar.cuellar@gmail.com', 'Análisis de datos para decisiones agrícolas', 'Inactivo');
CALL RegistrarUsuario(21351325, 'Manuela Nieto', 'Desarrolladora y Analista', 'manuela.nieto@gmail.com', 'Mejoras técnicas en procesos agrícolas', 'Activo');
CALL RegistrarUsuario(13554758, 'Fabio Silva', 'Veterinario', 'fabio.silva@gmail.com', 'Cuidado reproductivo y salud de animales', 'Activo');
CALL RegistrarUsuario(16554213, 'Claudia Vargas', 'Trabajador Agrícola', 'claudia.vargas@gmail.com', 'Apoyo técnico y operativo en la finca', 'Inactivo');
CALL RegistrarUsuario(65668410, 'Guillermo Hernández', 'Gerente de tecnología', 'guillermo.hernandez@gmail.com', 'Supervisión y desarrollo tecnológico', 'Activo');
CALL RegistrarUsuario(65418948, 'Andrea Ramírez', 'Veterinaria', 'andrea.ramirez@gmail.com', 'Encargada de salud animal y reproducción', 'Inactivo');
CALL RegistrarUsuario(23265911, 'Roberto Pérez', 'Trabajador Agrícola', 'roberto.perez@gmail.com', 'Tareas técnicas y mantenimiento agrícola', 'Activo');


/RQF/
/consulta basica de la tabla usuario/
select*from usuario;

/consultar nombres de usuarios/
create view consultarNombreUsuario as
select nombreUsu, documentoUsu from usuario;
select*from consultarNombreUsuario where nombreUsu='Juan Pablo Gómez';
select*from consultarNombreUsuario where nombreUsu='Ana Maria Triviño';
select*from consultarNombreUsuario where nombreUsu='Santiago Mora Camacho';


/Consultar tipo de usuario/
create view consultarTipoUsuario as
select documentoUsu, nombreUsu, tipoUsu from usuario;
select*from consultarTipoUsuario where tipoUsu='dueña';
select*from consultarTipoUsuario where tipoUsu='Administrador';


/Consultar actividad por usuario/
create view consultarActividadUsuario as
select nombreUsu, documentoUsu, descripcionActividad from usuario;
select*from consultarActividadUsuario where documentoUsu=7310098;
select*from consultarActividadUsuario where documentoUsu=78901234;

/Consultar estado por usuario/
create view consultarEstadoUsuario as
select nombreUsu, documentoUsu, estadoUsu from usuario;
select*from consultarEstadoUsuario where estadoUsu= 'Activo' order by nombreUsu asc;
select*from consultarEstadoUsuario where estadoUsu= 'Inactivo' order by nombreUsu asc;

/Modificar correo de usuario/
DELIMITER //
create procedure modificarCorreoUsu(in nuevoCorreoUsu varchar(40), in documentoUsu int)
begin
	update usuario set correoUsu = nuevoCorreoUsu where documentoUsu=documentoUsu;
end
//
DELIMITER ;

call modificarCorreoUsu('juanpixelesyt@gmail.com', 1013259709);
call modificarCorreoUsu('willysgomezs@gmail.com', 7310098);


/Modificar actividad de usuario/
DELIMITER //
create procedure modificarActividadUsu(in nuevaDescripcionActividad varchar(40), in documentoUsu int)
begin
	update usuario set descripcionActividad = nuevaDescripcionActividad where documentoUsu=documentoUsu;
end
//
DELIMITER ;

call modificarActividadUsu ('Gestión de compras de implementos',67890123);
call modificarActividadUsu ('Revisar el stock de concentrado en la finca',78901234)

/Modificar estado de usuario/

DELIMITER //
create procedure modificarEstadoUsuario(in nuevaDescripcionActividad varchar(40), in documentoUsu int)
begin
	update usuario set descripcionActividad = nuevaDescripcionActividad where documentoUsu=documentoUsu;
end
//
DELIMITER ;