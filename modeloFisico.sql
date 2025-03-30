create database fincaElCedro;
use fincaElCedro;
set SQL_SAFE_UPDATES=0;
create table usuario(
documentoUsu int primary key,
nombreUsu varchar(40) not null,
tipoUsu varchar(40) not null, #hacer una lista desplegable# 
correoUsu varchar(40) not null,
descripcionActividad varchar(50) not null,
estadoUsu varchar(20) null
);

create table animal(
nombreAnimal varchar(10) primary key,
fechaDeNacimiento date not null,
fechaDeCargue date not null,
estadoDeSalud varchar(10) not null,
cantConcentradoanimal float not null,
edadAnimal INT,
fechaUltimoParto date not null,
cantParto int
);

create table terreno(
nombreTerreno varchar(10) primary key,
estadoTerreno varchar(10) not null,
fechaSalida date not null,
fechaIngreso date not null,
diasEnTerreno int
);

create table produccion(
fechaRegistro timestamp default current_timestamp primary key,
cantLitrosMañana int not null,
cantLitrosTarde int not null,
cantLitrosDia int not null,
nombreAnimalFK varchar(10) not null,
documentoUsuFK int not null,
nombreTerrenoFK varchar(10) not null
); 

describe produccion;
alter table terreno
add column fechaRegistroFK timestamp default current_timestamp;

ALTER TABLE produccion
  add constraint TERR
  FOREIGN KEY(nombreTerrenoFK)
  REFERENCES terreno(nombreTerreno);

ALTER TABLE produccion
ADD constraint USU
FOREIGN KEY(documentoUsuFK)
REFERENCES usuario(documentoUsu);

alter table produccion
add constraint ANI
foreign key (nombreAnimalFK)
references animal(nombreAnimal);


drop table usuario;
drop table animal;
drop table produccion;
drop table terreno;
drop table historialUsu;
drop procedure registrarUsuario;
drop trigger guardarUsuElim;



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


/*crear tabla de los usuarios eliminados*/
create table historialUsu(
documentoUsu int primary key,
nombreUsu varchar(40) not null,
tipoUsu varchar(20) not null, #hacer una lista desplegable# 
correoUsu varchar(50) not null,
descripcionActividad varchar(50) not null,
estadoUsu boolean null
);

/*Crear el trigger que guarda un historial de los usuarios eliminados, como una papelera*/
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


/*registro de usuarios*/
CALL RegistrarUsuario(7310098, 'William Salvador Gómez', 'Administrador', 'willysgomezs@hotmail.com', 'Encargado del manejo financiero y logístico de la finca', 'Activo');
CALL RegistrarUsuario(1013259709, 'Juan Pablo Gómez', 'Trabajador Agrícola', 'juanpablo.gomezb@urosario.edu.co', 'Encargado del funcionamiento técnico de la finca y de los ordeños', 'Activo');
CALL RegistrarUsuario(1000077838, 'Ana Maria Triviño', 'Trabajador Agrícola', 'ana.trivino@urosario.edu.co', 'Encargada del funcionamiento técnico de la finca y de los ordeños', 'Activo');
CALL RegistrarUsuario(1000035548, 'Santiago Mora Camacho', 'Trabajador Agrícola', 'santiago.moraca@urosario.edu.co', 'Encargado del funcionamiento técnico de la finca y de los ordeños', 'Activo');
CALL RegistrarUsuario(46675765, 'Pedro Rivera', 'Trabajador Agrícola', 'rivpedro@gmail.com', 'Encargado del funcionamiento técnico de la finca y de los ordeños', 'Activo');
CALL RegistrarUsuario(78597054, 'Idinael Martinez', 'Trabajador Agrícola', 'maridinael@gmail.com', 'Encargado del funcionamiento técnico de la finca y de los ordeños', 'Activo');
CALL RegistrarUsuario(23481984, 'Maria Luisa Saavedra', 'Dueña', 'saavmaria@gmail.com', 'Toma de decisiones importantes sobre la finca', 'Activo');
CALL RegistrarUsuario(15216545, 'Luis Eduardo Gómez', 'Dueño', 'gomezeduardo@gmail.com', 'Toma de decisiones importantes sobre la finca', 'Inactivo');
CALL RegistrarUsuario(54984877, 'Ferney Rodrigues', 'Veterinario', 'rodriferney@gmail.com', 'Encargado de la salud de los animales y del tema reproductivo de los mismos', 'Inactivo');
CALL RegistrarUsuario(85132149, 'Tatiana Lizbeth Cabrera', 'Gerente de logística', 'tatianal.cabrera@urosario.edu.co', 'Supervisión del transporte y suministro', 'Activo');
CALL RegistrarUsuario(67890123, 'Miguel Ángel Torres', 'Administrador', 'miguel.torres@gmail.com', 'Gestión administrativa de la finca', 'Activo');
CALL RegistrarUsuario(78901234, 'Carolina López', 'Gerente de recursos', 'carolina.lopez@gmail.com', 'Supervisión y optimización de recursos disponibles', 'Activo');
CALL RegistrarUsuario(89012345, 'Fernando Vargas', 'Veterinario', 'fernando.vargas@gmail.com', 'Responsable de la salud de los animales', 'Inactivo');
CALL RegistrarUsuario(90123456, 'Luisa Martínez', 'Dueña', 'luisa.martinez@gmail.com', 'Decisiones estratégicas sobre la finca', 'Inactivo');
CALL RegistrarUsuario(12345000, 'José Rodríguez', 'Trabajador Agrícola', 'jose.rodriguez@gmail.com', 'Apoyo en tareas técnicas y mantenimiento', 'Activo');
CALL RegistrarUsuario(23456100, 'Paula Castro', 'Trabajadora Agrícola', 'paula.castro@gmail.com', 'Encargada del funcionamiento técnico de la finca', 'Inactivo');
CALL RegistrarUsuario(34561234, 'David Gómez', 'Veterinario', 'david.gomez@gmail.com', 'Encargado de la salud de los animales', 'Activo');
CALL RegistrarUsuario(45612345, 'Alejandra Hernández', 'Gerente de logística', 'alejandra.hernandez@gmail.com', 'Supervisión del transporte y suministro', 'Activo');
CALL RegistrarUsuario(56712345, 'Ricardo Pérez', 'Trabajador Agrícola', 'ricardo.perez@gmail.com', 'Encargado del funcionamiento técnico de la finca', 'Activo');
CALL RegistrarUsuario(67812345, 'Carmen Cruz', 'Veterinaria', 'carmen.cruz@gmail.com', 'Responsable de la salud de los animales y reproducción', 'Inactivo');
CALL RegistrarUsuario(78912345, 'Gabriel Ortiz', 'Administrador', 'gabriel.ortiz@gmail.com', 'Gestión financiera de la finca', 'Activo');
CALL RegistrarUsuario(89012349, 'Sofia Moreno', 'Dueña', 'sofia.moreno@gmail.com', 'Decisiones clave sobre la finca', 'Activo');
CALL RegistrarUsuario(90123446, 'Marcela Reyes', 'Gerente de logística', 'marcela.reyes@gmail.com', 'Supervisión del transporte y suministro', 'Inactivo');
CALL RegistrarUsuario(23456752, 'Esteban Alarcón', 'Trabajador Agrícola', 'esteban.alarcon@gmail.com', 'Responsable de tareas técnicas diarias', 'Activo');
CALL RegistrarUsuario(34567821, 'Isabel Fernández', 'Veterinaria', 'isabel.fernandez@gmail.com', 'Responsable de la salud de los animales', 'Activo');
CALL RegistrarUsuario(45678905, 'Antonio Ruiz', 'Veterinario', 'antonio.ruiz@gmail.com', 'Revisión y salud de animales', 'Activo');
CALL RegistrarUsuario(56789028, 'Camila Vargas', 'Dueña', 'camila.vargas@gmail.com', 'Responsable de decisiones estratégicas', 'Inactivo');
CALL RegistrarUsuario(67890132, 'Hugo Salazar', 'Trabajador Agrícola', 'hugo.salazar@gmail.com', 'Encargado de tareas técnicas', 'Activo');
CALL RegistrarUsuario(78901258, 'Vanesa Pardo', 'Dueña', 'vanesa.pardo@gmail.com', 'Decisiones clave sobre la finca', 'Activo');
CALL RegistrarUsuario(89012384, 'Julian Cifuentes', 'Administrador', 'julian.cifuentes@gmail.com', 'Gestión administrativa de la finca', 'Inactivo');
CALL RegistrarUsuario(90123496, 'Laura Mejía', 'Veterinaria', 'laura.mejia@gmail.com', 'Responsable de salud animal', 'Activo');
CALL RegistrarUsuario(12345637, 'Santiago Valencia', 'Trabajador Agrícola', 'santiago.valencia@gmail.com', 'Encargado del funcionamiento técnico de la finca', 'Inactivo');
CALL RegistrarUsuario(23456764, 'Silvia González', 'Trabajadora Agrícola', 'silvia.gonzalez@gmail.com', 'Encargada del funcionamiento técnico de la finca', 'Activo');
CALL RegistrarUsuario(34567881, 'Alfredo García', 'Trabajador Agrícola', 'alfredo.garcia@gmail.com', 'Mantenimiento técnico de la finca', 'Inactivo');
CALL RegistrarUsuario(45678976, 'Patricia Delgado', 'Dueña', 'patricia.delgado@gmail.com', 'Decisiones clave sobre la finca', 'Activo');
CALL RegistrarUsuario(56789542, 'Oscar Peña', 'Veterinario', 'oscar.pena@gmail.com', 'Revisión de salud y reproducción de animales', 'Inactivo');
CALL RegistrarUsuario(67890378, 'Daniela Ríos', 'Trabajador Agrícola', 'daniela.rios@gmail.com', 'Apoyo en tareas técnicas agrícolas', 'Activo');
CALL RegistrarUsuario(95654132, 'Carlos Blanco', 'Administrador', 'carlos.blanco@gmail.com', 'Gestión logística y financiera', 'Activo');
CALL RegistrarUsuario(23151841, 'Valeria Muñoz', 'Gerente de recursos', 'valeria.munoz@gmail.com', 'Optimización de recursos y supervisión', 'Activo');
CALL RegistrarUsuario(96518812, 'Sebastián Torres', 'Trabajador Agrícola', 'sebastian.torres@gmail.com', 'Encargado del funcionamiento técnico diario', 'Inactivo');
CALL RegistrarUsuario(65468123, 'Natalia Morales', 'Veterinaria', 'natalia.morales@gmail.com', 'Responsable de la salud y bienestar animal', 'Activo');
CALL RegistrarUsuario(28735688, 'Edgar Cuellar', 'Trabajador Agrícola', 'edgar.cuellar@gmail.com', 'Encargado del funcionamiento técnico de la finca', 'Inactivo');
CALL RegistrarUsuario(1013259710, 'María Fernanda López', 'Trabajadora Agrícola', 'maria.lopezb@urosario.edu.co', 'Encargada de supervisar los cultivos y la cosecha', 'Activo');
CALL RegistrarUsuario(1013259711, 'Carlos Eduardo Rodríguez', 'Trabajador Agrícola', 'carlos.rodriguezb@urosario.edu.co', 'Encargado de la maquinaria agrícola', 'Activo');
CALL RegistrarUsuario(1013259712, 'Ana Sofía Martínez', 'Trabajadora Agrícola', 'ana.martinezb@urosario.edu.co', 'Responsable del control de calidad de los productos', 'Activo');
CALL RegistrarUsuario(1013259713, 'Jorge Andrés Gómez', 'Trabajador Agrícola', 'jorge.gomezb@urosario.edu.co', 'Responsable de la irrigación y manejo de aguas', 'Activo');
CALL RegistrarUsuario(1013259714, 'Lucía Gabriela Torres', 'Trabajadora Agrícola', 'lucia.torresb@urosario.edu.co', 'Supervisora de los procesos de empaque', 'Activo');
CALL RegistrarUsuario(1013259715, 'Miguel Ángel Ramírez', 'Trabajador Agrícola', 'miguel.ramirezb@urosario.edu.co', 'Encargado de fertilización y control de plagas', 'Activo');
CALL RegistrarUsuario(1013259716, 'Laura Isabel Castro', 'Trabajadora Agrícola', 'laura.castrob@urosario.edu.co', 'Monitoreo de crecimiento de cultivos', 'Activo');
CALL RegistrarUsuario(1013259717, 'Diego Alejandro Vargas', 'Trabajador Agrícola', 'diego.vargasb@urosario.edu.co', 'Gestión de almacenes y suministros', 'Activo');
CALL RegistrarUsuario(1013259718, 'Valentina Camila Sánchez', 'Trabajadora Agrícola', 'valentina.sanchezb@urosario.edu.co', 'Mantenimiento de infraestructura agrícola', 'Activo');

/*RQF*/
/*consulta basica de la tabla usuario*/
select*from usuario;

/*consultar nombres de usuarios*/
create view consultarNombreUsuario as
select nombreUsu, documentoUsu from usuario;
select*from consultarNombreUsuario where nombreUsu='Juan Pablo Gómez';
select*from consultarNombreUsuario where nombreUsu='Ana Maria Triviño';
select*from consultarNombreUsuario where nombreUsu='Santiago Mora Camacho';


/*Consultar tipo de usuario*/
create view consultarTipoUsuario as
select documentoUsu, nombreUsu, tipoUsu from usuario;
select*from consultarTipoUsuario where tipoUsu='dueña';
select*from consultarTipoUsuario where tipoUsu='Administrador';


/*Consultar actividad por usuario*/
create view consultarActividadUsuario as
select nombreUsu, documentoUsu, descripcionActividad from usuario;
select*from consultarActividadUsuario where documentoUsu=7310098;
select*from consultarActividadUsuario where documentoUsu=78901234;

/*Consultar estado por usuario*/
create view consultarEstadoUsuario as
select nombreUsu, documentoUsu, estadoUsu from usuario;
select*from consultarEstadoUsuario where estadoUsu= 'Activo' order by nombreUsu asc;
select*from consultarEstadoUsuario where estadoUsu= 'Inactivo' order by nombreUsu asc;

/*Modificar correo de usuario*/
DELIMITER //
create procedure modificarCorreoUsu(in nuevoCorreoUsu varchar(40), in documentoUsu int)
begin
	update usuario set correoUsu = nuevoCorreoUsu where documentoUsu=documentoUsu;
end
//
DELIMITER ;

call modificarCorreoUsu('juanpixelesyt@gmail.com', 1013259709);
call modificarCorreoUsu('willysgomezs@gmail.com', 7310098);


/*Modificar actividad de usuario*/
DELIMITER //
create procedure modificarActividadUsu(in nuevaDescripcionActividad varchar(40), in documentoUsu int)
begin
	update usuario set descripcionActividad = nuevaDescripcionActividad where documentoUsu=documentoUsu;
end
//
DELIMITER ;

call modificarActividadUsu ('Gestión de compras de implementos',67890123);
call modificarActividadUsu ('Revisar el stock de concentrado en la finca',78901234)

/*Modificar estado de usuario*/

DELIMITER //
create procedure modificarEstadoUsuario(in nuevoEstadoUSu varchar(20), in documentoUsu int)
begin
	update usuario set estadoUsu = nuevoEstadoUsu where documentoUsu=documentoUsu;
end
//
DELIMITER ;

call modificarEstadoUsuario('Inactivo', 7310098)

/*Proceso de eliminar un usuario por el documento*/
DELIMITER //
CREATE PROCEDURE eliminarUsuario(
    IN documentoUsu INT
)
BEGIN
    DELETE FROM Usuario
    WHERE documentoUsu = documentoUsu;
END
//
DELIMITER ;

call eliminarUsuario(1013259709)