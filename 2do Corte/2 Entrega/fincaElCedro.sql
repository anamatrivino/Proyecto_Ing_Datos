create database fincaElCedro;
use fincaElCedro;

create table Usuario(
documentoUsu int primary key,
nombreUsu varchar(40) not null,
tipoUsu enum('Administrador','Zootecnista','Veterinario','Trabajador Agrícola') not null, 
correoUsu varchar(40) not null,
descripcionActividadUsu varchar(50) not null
);

create table Animal(
idAnimal int AUTO_INCREMENT primary key,
nombreAnimal varchar(10) not null,
fechaDeNacimiento date not null,
fechaDeCargue date not null,
estadoDeSalud enum('Sano','Enfermo') not null,
cantConcentradoAnimal float not null,
edadAnimal int not null,
fechaUltimoParto date not null,
cantParto int not null
);

create table Terreno(
idTerreno int AUTO_INCREMENT primary key,
nombreTerreno varchar(10) not null,
estadoTerreno enum ('Apto', 'No apto') not null,
fechaIngreso date not null,
fechaSalida date not null,
diasTerreno int
);

create table Produccion(
idProduccion int AUTO_INCREMENT primary key,
fechaRegistro timestamp not null,
cantLitrosMañanaAnimal int not null,
cantLitrosTardeAnimal int not null,
cantLitrosDiaAnimal int not null,
idAnimalFK int not null,
documentoUsuFK int not null,
idTerrenoFK int not null
); 

/*Unir las llaves foraneas*/
ALTER TABLE Produccion ADD CONSTRAINT FKidTerreno FOREIGN KEY (idTerrenoFK) REFERENCES Terreno(idTerreno) ON DELETE CASCADE;
ALTER TABLE Produccion add constraint FKdocumentoUsu FOREIGN KEY(documentoUsuFK) REFERENCES Usuario(documentoUsu) ON DELETE CASCADE;
ALTER TABLE Produccion add constraint FKidAnimal FOREIGN KEY (idAnimalFK) REFERENCES Animal(idAnimal) ON DELETE CASCADE;

/*Código ANIMAL*/

/*Trigger que actualizara la cantidad de partos*/
DELIMITER //
CREATE TRIGGER registrarPartosAnimal
BEFORE UPDATE ON Animal
FOR EACH ROW
BEGIN
    IF NEW.fechaUltimoParto <> OLD.fechaUltimoParto THEN
	SET NEW.cantParto = OLD.cantParto + 1;
    END IF;
END //
DELIMITER ;

DELIMITER //

/*Procedimiento registrar animal*/
CREATE PROCEDURE registrarAnimal(
	IN p_nombreAnimal varchar(10),
		p_fechaDeNacimiento date, 
		p_fechaDeCargue date, 
        p_estadoDeSalud enum('Sano','Enfermo'), 
        p_cantConcentradoAnimal float, 
        p_fechaUltimoParto date
)
BEGIN
	DECLARE edadAnimal int;
    DECLARE cantParto int;
    
		SET edadAnimal=TIMESTAMPDIFF(year,p_fechaDeNacimiento,CURDATE());
        
		IF cantParto is null then
			SET cantParto=1;
		END IF;
		
        INSERT INTO Animal (
        nombreAnimal,
        fechaDeNacimiento,
        fechaDeCargue,
        estadoDeSalud,
        cantConcentradoAnimal,
        edadAnimal,
        fechaUltimoParto,
        cantParto
    )
    VALUES (
        p_nombreAnimal,
        p_fechaDeNacimiento,
        p_fechaDeCargue,
        p_estadoDeSalud,
        p_cantConcentradoAnimal,
        edadAnimal,
        p_fechaUltimoParto,
        cantParto);
END //
DELIMITER ;

-- 50 REGISTROS OBTENIDOS DE CHATGPT

CALL registrarAnimal('ENRIQUETA', '2018-06-15', '2020-08-10', 'Sano', 4.5, '2023-07-01');
CALL registrarAnimal('MOJOSA', '2017-09-22', '2019-11-03', 'Enfermo', 3.8, '2022-05-14');
CALL registrarAnimal('PALOMA', '2019-03-30', '2021-06-21', 'Sano', 5.2, '2024-02-18');
CALL registrarAnimal('YERJOL', '2020-01-12', '2022-04-09', 'Sano', 4.1, '2023-09-05');
CALL registrarAnimal('PRESUMIDA', '2016-07-08', '2018-09-30', 'Sano', 4.7, '2022-12-11');
CALL registrarAnimal('ALEJANDRA', '2018-11-05', '2020-12-15', 'Enfermo', 3.6, '2023-03-20');
CALL registrarAnimal('MALU', '2017-05-18', '2019-07-27', 'Sano', 5.0, '2024-01-30');
CALL registrarAnimal('COSTEÑA', '2019-08-11', '2021-10-03', 'Sano', 4.2, '2023-11-14');
CALL registrarAnimal('GOMELA HIJA', '2020-02-25', '2022-06-19', 'Sano', 3.9, '2023-06-07');
CALL registrarAnimal('ROCOLA HIJA', '2018-04-17', '2020-05-23', 'Enfermo', 4.3, '2023-08-22');
CALL registrarAnimal('JERSY HIJA', '2019-09-05', '2021-11-29', 'Sano', 4.9, '2023-12-08');
CALL registrarAnimal('VARETO HIJA', '2017-12-20', '2019-04-15', 'Sano', 5.5, '2022-10-30');
CALL registrarAnimal('FLACA', '2021-03-10', '2023-05-18', 'Enfermo', 3.5, '2024-03-21');
CALL registrarAnimal('CARETA', '2016-11-30', '2018-12-09', 'Sano', 4.6, '2021-09-10');
CALL registrarAnimal('MECHAS', '2020-07-01', '2022-08-15', 'Sano', 4.8, '2023-10-05');
CALL registrarAnimal('VILLAMIL', '2019-05-28', '2021-07-17', 'Sano', 3.7, '2023-04-22');
CALL registrarAnimal('CACHIPORRA', '2018-08-09', '2020-09-13', 'Enfermo', 3.9, '2022-11-19');
CALL registrarAnimal('NUBIA', '2017-06-14', '2019-08-28', 'Sano', 4.4, '2023-06-30');
CALL registrarAnimal('TARZÁN', '2019-12-05', '2021-12-25', 'Sano', 4.0, '2023-07-15');
CALL registrarAnimal('TROMPITA', '2020-11-09', '2022-12-17', 'Sano', 5.1, '2024-02-01');
CALL registrarAnimal('PAJARITO', '2016-05-19', '2018-07-22', 'Enfermo', 3.2, '2021-12-14');
CALL registrarAnimal('CHISPAS', '2018-02-14', '2020-03-19', 'Sano', 4.5, '2023-09-25');
CALL registrarAnimal('ZANAHORIA', '2019-07-30', '2021-09-10', 'Sano', 4.3, '2023-12-20');
CALL registrarAnimal('MORCILLA', '2017-10-11', '2019-12-15', 'Sano', 5.0, '2022-08-09');
CALL registrarAnimal('TOTUMA', '2020-09-17', '2022-10-25', 'Enfermo', 3.6, '2024-01-07');
CALL registrarAnimal('CACHO LOCO', '2018-12-28', '2021-02-10', 'Sano', 4.9, '2023-05-23');
CALL registrarAnimal('TIBURÓN', '2016-08-05', '2018-10-12', 'Enfermo', 3.3, '2022-07-14');
CALL registrarAnimal('BEBÉ', '2019-02-22', '2021-04-05', 'Sano', 4.7, '2023-10-19');
CALL registrarAnimal('LLOVIZNA', '2017-04-29', '2019-06-13', 'Sano', 5.3, '2023-01-14');
CALL registrarAnimal('AZUCARITA', '2018-05-12', '2020-06-27', 'Sano', 4.1, '2022-09-05');
CALL registrarAnimal('MANCHITAS', '2020-04-21', '2022-07-01', 'Sano', 4.2, '2023-12-31');
CALL registrarAnimal('LUMBER', '2016-09-15', '2018-11-18', 'Enfermo', 3.4, '2021-11-08');
CALL registrarAnimal('CHOCOLATINA', '2019-10-07', '2021-12-20', 'Sano', 4.8, '2023-06-03');
CALL registrarAnimal('CAFÉ', '2020-08-29', '2022-09-30', 'Sano', 5.2, '2024-03-11');
CALL registrarAnimal('RAYITO', '2017-11-03', '2019-12-14', 'Enfermo', 3.5, '2022-10-01');
CALL registrarAnimal('PINTA', '2018-03-23', '2020-04-27', 'Sano', 4.6, '2023-02-17');
CALL registrarAnimal('GALLO', '2019-06-18', '2021-08-24', 'Sano', 5.0, '2023-07-09');
CALL registrarAnimal('RUMBA', '2016-07-20', '2018-08-30', 'Sano', 4.3, '2021-10-25');
CALL registrarAnimal('CAMILA', '2020-10-13', '2022-11-22', 'Sano', 4.0, '2023-11-06');
CALL registrarAnimal('MELCOCHA', '2019-01-28', '2021-03-09', 'Enfermo', 3.7, '2023-04-28');
CALL registrarAnimal('POLVO', '2017-05-10', '2019-07-20', 'Sano', 4.9, '2023-09-18');
CALL registrarAnimal('JUGUETE', '2018-09-08', '2020-10-19', 'Sano', 4.2, '2023-01-10');
CALL registrarAnimal('LACRA', '2021-02-05', '2023-03-14', 'Enfermo', 3.8, '2024-02-24');
CALL registrarAnimal('PACA', '2018-03-23', '2020-04-27', 'Sano', 4.6, '2023-02-17');
CALL registrarAnimal('LORETA', '2019-06-18', '2021-08-24', 'Sano', 5.0, '2023-07-09');
CALL registrarAnimal('ROMA', '2016-07-20', '2018-08-30', 'Sano', 4.3, '2021-10-25');
CALL registrarAnimal('SARA', '2020-10-13', '2022-11-22', 'Sano', 4.0, '2023-11-06');
CALL registrarAnimal('SASHA', '2019-01-28', '2021-03-09', 'Enfermo', 3.7, '2023-04-28');
CALL registrarAnimal('LARA', '2017-05-10', '2019-07-20', 'Sano', 4.9, '2023-09-18');
CALL registrarAnimal('MACARENA', '2018-09-08', '2020-10-19', 'Sano', 4.2, '2023-01-10');

-- Consulta básica
select * from Animal;

-- Animales enfermos con edad superior a 5 años
SELECT nombreAnimal, edadAnimal
FROM Animal
WHERE estadoDeSalud = 'Enfermo' AND edadAnimal > 5;

-- Animales que han tenido al menos 2 partos desde el 2024
SELECT nombreAnimal, fechaUltimoParto
FROM Animal
WHERE fechaUltimoParto >= '2024-01-01' and cantParto >2;

-- Promedio de concentrado por estado de salud
SELECT estadoDeSalud, AVG(cantConcentradoAnimal) AS promedio
FROM Animal
GROUP BY estadoDeSalud;

-- Vista para el nombre del animal
CREATE VIEW vistaNombreAnimal AS
SELECT nombreAnimal
FROM Animal;
select * from vistaNombreAnimal;

-- Vista para la edad del animal
CREATE VIEW vistaEdadAnimal AS
SELECT nombreAnimal, edadAnimal
FROM Animal;
select * from vistaEdadAnimal;

-- Vista para la ultima fecha del cargue del animal
CREATE VIEW vistaFechaDeCargueAnimal AS
SELECT nombreAnimal, FechaDeCargue
FROM Animal;
select * from vistaFechaDeCargueAnimal;

-- Vista para el estado de salud del animal
CREATE VIEW vistaSaludAnimal AS
SELECT nombreAnimal, estadoDeSalud
FROM Animal;
select * from vistaSaludAnimal;

-- Vista para la cantidad de concentrado suministrado al animal
CREATE VIEW vistaCantConcentradoAnimal AS
SELECT nombreAnimal, CantConcentradoAnimal
FROM Animal;
select * from vistaCantConcentradoAnimal;

-- Vista para la cantidad de partos que ha tenido el animal
CREATE VIEW vistaCantPartoAnimal AS
SELECT nombreAnimal, cantParto
FROM Animal;
select * from vistaCantPartoAnimal;

-- Vista para las fechas de partos del animal
CREATE VIEW vistaFechaAnimal AS
SELECT nombreAnimal, fechaUltimoParto
FROM Animal;
select * from vistaCantPartoAnimal;

-- Modificaciones

-- Procedure que modifica el estado de salud del animal
DELIMITER //
CREATE PROCEDURE modificarSaludAnimal(
	IN a_nombreAnimal varchar(10),
    IN a_estadoDeSalud varchar(10)
)
BEGIN
	UPDATE Animal
		SET estadoDeSalud = a_estadoDeSalud
        where nombreAnimal = a_nombreAnimal;
END //
DELIMITER ;
CALL modificarSaludAnimal('YERJOL','ENFERMO');
describe Animal;
select nombreAnimal, estadoDeSalud from Animal where nombreAnimal='YERJOL';

-- Procedure que modifica la cantidad de concentrado suministrado al animal
DELIMITER //
CREATE PROCEDURE modificarCantConcentradoAnimal(
	IN a_nombreAnimal varchar(10),
    IN a_cantConcentradoAnimal float
)
BEGIN
	UPDATE Animal
		SET cantConcentradoAnimal = a_cantConcentradoAnimal
        where nombreAnimal = a_nombreAnimal;
END //
DELIMITER ;
CALL modificarCantConcentradoAnimal('ENRIQUETA',5.3);
CALL modificarCantConcentradoAnimal('PRESUMIDA',3.5);

describe Animal;
select nombreAnimal, cantConcentradoAnimal from Animal where nombreAnimal='ENRIQUETA' OR nombreAnimal='PRESUMIDA';

-- Procedure que modifica la fecha del ultimo parto del animal
DELIMITER //
CREATE PROCEDURE modificarFechaParto(
	IN a_nombreAnimal varchar(10),
    IN a_fechaUltimoParto date
)
BEGIN
	UPDATE Animal
		SET fechaUltimoParto = a_fechaUltimoParto
        where nombreAnimal = a_nombreAnimal;
END //
DELIMITER ;
CALL modificarFechaParto('ENRIQUETA','2024-03-19');
CALL modificarFechaParto('YERJOL','2024-09-10');
CALL modificarFechaParto('ALEJANDRA','2023-01-05');

describe Animal;
select nombreAnimal, fechaUltimoParto from Animal where nombreAnimal='ENRIQUETA' OR nombreAnimal='PRESUMIDA' OR nombreAnimal='ALEJANDRA';

-- Eliminacion
-- Delete para los que hayan fallecido
/*Trigger que funciona si se elimina un animal de la tabla Animal*/
CREATE TABLE eliminarAnimal (
	idDefuncion int AUTO_INCREMENT primary key,
    nombreAnimal VARCHAR(10) NOT NULL,
    edadAnimal INT NOT NULL,
    fechaDefuncion DATE NOT NULL
);

DELIMITER //
CREATE TRIGGER defuncionAnimal
BEFORE DELETE ON Animal
FOR EACH ROW
BEGIN
    INSERT INTO eliminarAnimal (nombreAnimal, edadAnimal, fechaDefuncion) 
    VALUES (OLD.nombreAnimal, OLD.edadAnimal, CURDATE());
END //
DELIMITER ;

DELETE FROM Animal WHERE idAnimal = 1;
select * from eliminarAnimal;

/*Código Usuario*/
/*Crear procedimiento para el registro de los usuarios */
DELIMITER //
CREATE PROCEDURE registrarUsuario(
    IN P_documentoUsu INT,
    IN P_nombreUsu VARCHAR(40),
    IN P_tipoUsu enum('Administrador','Zootecnista','Veterinario','Trabajador Agrícola'),
    IN P_correoUsu VARCHAR(40),
    IN P_descripcionActividadUsu VARCHAR(50)
)
BEGIN
	INSERT INTO Usuario (documentoUsu, nombreUsu, tipoUsu, correoUsu, descripcionActividadUsu)
	VALUES (p_documentoUsu, p_nombreUsu, p_tipoUsu, p_correoUsu, p_descripcionActividadUsu);
END
//
DELIMITER ;

-- Se realizan los 50 registros, fueron tomados de ChatGPT
CALL registrarUsuario(7310098, 'William Salvador Gómez', 'Administrador', 'willysgomezs@hotmail.com', 'Manejo financiero y logístico');
CALL registrarUsuario(1013259709, 'Juan Pablo Gómez', 'Zootecnista', 'juanpablo.gomezb@urosario.edu.co', 'Ordeños y revisión técnica');
CALL registrarUsuario(1000077838, 'Ana Maria Triviño', 'Zootecnista', 'ana.trivino@urosario.edu.co', 'Sanidad animal y reproducción');
CALL registrarUsuario(34561234, 'David Gómez', 'Zootecnista', 'david.gomez@gmail.com', 'Nutrición y bienestar animal');
CALL registrarUsuario(67812345, 'Carmen Cruz', 'Zootecnista', 'carmen.cruz@gmail.com', 'Gestión reproductiva animal');
CALL registrarUsuario(78912345, 'Gabriel Ortiz', 'Zootecnista', 'gabriel.ortiz@gmail.com', 'Revisión técnica de ganado');
CALL registrarUsuario(54984877, 'Ferney Rodrigues', 'Veterinario', 'rodriferney@gmail.com', 'Salud de animales y reproducción');
CALL registrarUsuario(89012345, 'Fernando Vargas', 'Veterinario', 'fernando.vargas@gmail.com', 'Vacunación y control sanitario');
CALL registrarUsuario(45678905, 'Antonio Ruiz', 'Veterinario', 'antonio.ruiz@gmail.com', 'Revisión y salud de animales');
CALL registrarUsuario(34567821, 'Isabel Fernández', 'Veterinario', 'isabel.fernandez@gmail.com', 'Supervisión sanitaria');
CALL registrarUsuario(65468123, 'Natalia Morales', 'Veterinario', 'natalia.morales@gmail.com', 'Control de enfermedades');
CALL registrarUsuario(1000035548, 'Santiago Mora Camacho', 'Trabajador Agrícola', 'santiago.moraca@urosario.edu.co', 'Ordeños y alimentación');
CALL registrarUsuario(46675765, 'Pedro Rivera', 'Trabajador Agrícola', 'rivpedro@gmail.com', 'Ordeño y logística');
CALL registrarUsuario(78597054, 'Idinael Martinez', 'Trabajador Agrícola', 'maridinael@gmail.com', 'Recolección y mantenimiento');
CALL registrarUsuario(12345000, 'José Rodríguez', 'Trabajador Agrícola', 'jose.rodriguez@gmail.com', 'Mantenimiento técnico');
CALL registrarUsuario(23456100, 'Paula Castro', 'Trabajador Agrícola', 'paula.castro@gmail.com', 'Funcionamiento técnico');
CALL registrarUsuario(56712345, 'Ricardo Pérez', 'Trabajador Agrícola', 'ricardo.perez@gmail.com', 'Tareas técnicas');
CALL registrarUsuario(67890132, 'Hugo Salazar', 'Trabajador Agrícola', 'hugo.salazar@gmail.com', 'Apoyo agrícola');
CALL registrarUsuario(28735688, 'Edgar Cuellar', 'Trabajador Agrícola', 'edgar.cuellar@gmail.com', 'Asistente técnico');
CALL registrarUsuario(1013259710, 'María Fernanda López', 'Trabajador Agrícola', 'maria.lopezb@urosario.edu.co', 'Supervisión de cultivos');
CALL registrarUsuario(1013259711, 'Carlos Eduardo Rodríguez', 'Trabajador Agrícola', 'carlos.rodriguezb@urosario.edu.co', 'Manejo de maquinaria');
CALL registrarUsuario(1013259712, 'Ana Sofía Martínez', 'Trabajador Agrícola', 'ana.martinezb@urosario.edu.co', 'Control de calidad');
CALL registrarUsuario(1013259713, 'Jorge Andrés Gómez', 'Trabajador Agrícola', 'jorge.gomezb@urosario.edu.co', 'Riego e irrigación');
CALL registrarUsuario(1013259714, 'Lucía Gabriela Torres', 'Trabajador Agrícola', 'lucia.torresb@urosario.edu.co', 'Empaque y distribución');
CALL registrarUsuario(1013259715, 'Miguel Ángel Ramírez', 'Trabajador Agrícola', 'miguel.ramirezb@urosario.edu.co', 'Fertilización y plagas');
CALL registrarUsuario(1013259716, 'Laura Isabel Castro', 'Trabajador Agrícola', 'laura.castrob@urosario.edu.co', 'Monitoreo de cultivos');
CALL registrarUsuario(1013259717, 'Diego Alejandro Vargas', 'Trabajador Agrícola', 'diego.vargasb@urosario.edu.co', 'Almacenes y suministros');
CALL registrarUsuario(1013259718, 'Valentina Camila Sánchez', 'Trabajador Agrícola', 'valentina.sanchezb@urosario.edu.co', 'Infraestructura agrícola');

/*RQF*/
/*consulta basica de la tabla usuario*/
select*from usuario;

/*consultar nombres de usuarios*/
create view consultarNombreUsuario as
select nombreUsu, documentoUsu from usuario;
select*from consultarNombreUsuario where nombreUsu='William Salvador Gómez';
select*from consultarNombreUsuario where nombreUsu='Pedro Rivera';
select*from consultarNombreUsuario where nombreUsu='Maria Luisa Saavedra';

/*Consultar tipo de usuario*/
create view consultarTipoUsuario as
select documentoUsu, nombreUsu, tipoUsu from usuario;
select*from consultarTipoUsuario where tipoUsu='Administrador';
select*from consultarTipoUsuario where tipoUsu='Zootecnista';

/*Consultar actividad por usuario*/
describe Usuario;
create view consultarActividadUsuario as
select nombreUsu, documentoUsu, descripcionActividadUsu from usuario;
select*from consultarActividadUsuario where documentoUsu=7310098;
select*from consultarActividadUsuario where documentoUsu=45678905;

/*Modificar correo de usuario*/
DELIMITER //
create procedure modificarCorreoUsu(in nuevoCorreoUsu varchar(40), in ConsultadocumentoUsu int)
begin
	update usuario set correoUsu = nuevoCorreoUsu where documentoUsu=ConsultadocumentoUsu;
end
//
DELIMITER ;

call modificarCorreoUsu('riverapedro@gmail.com', 46675765);
call modificarCorreoUsu('willysgomezs@gmail.com', 7310098);
select documentoUsu,nombreUsu,correoUsu from Usuario where documentoUsu=46675765 or documentoUsu=7310098;

/*Modificar actividad de usuario*/
DELIMITER //
create procedure modificarActividadUsu(in nuevaDescripcionActividad varchar(40), in ConsultadocumentoUsu int)
begin
	update usuario set descripcionActividadUsu = nuevaDescripcionActividad where documentoUsu=ConsultadocumentoUsu;
end
//
DELIMITER ;

call modificarActividadUsu ('Gestión de compras de implementos',1013259718);
call modificarActividadUsu ('Revisar el stock de concentrado en la finca',78597054);
select documentoUsu,nombreUsu,descripcionActividadUsu from Usuario where documentoUsu=1013259718 or documentoUsu=78597054;

/*Proceso de eliminar un usuario por encontrarse inactivo*/
/*crear tabla de los usuarios eliminados*/
create table historialUsu(
documentoUsu int primary key,
nombreUsu varchar(40) not null,
tipoUsu enum('Administrador','Zootecnista','Veterinario','Trabajador Agrícola'),
correoUsu varchar(40) not null,
descripcionActividadUsu varchar(50) not null
);

/*Crear el trigger que guarda un historial de los usuarios eliminados, como una papelera*/
DELIMITER //
create trigger guardarUsuElim
before delete on usuario
for each row
begin 
	INSERT INTO historialUsu (
		documentoUsu, nombreUsu, tipoUsu, correoUsu, descripcionActividadUsu
	)
	VALUES (
		OLD.documentoUsu, OLD.nombreUsu, OLD.tipoUsu, OLD.correoUsu, OLD.descripcionActividadUsu
	);
end
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE eliminarUsuario(
    IN I_documentoUsu INT
)
BEGIN
    DELETE FROM Usuario
    WHERE documentoUsu = I_documentoUsu;
END
//
DELIMITER ;
/*Eliminar todos los usuarios que no hacen parte del proceso*/
call eliminarUsuario(78597054);
call eliminarUsuario(1000077838);
call eliminarUsuario(1000035548);
CALL eliminarUsuario(85132149);
CALL eliminarUsuario(67890123);
CALL eliminarUsuario(78901234);
CALL eliminarUsuario(89012345);
CALL eliminarUsuario(90123456);
CALL eliminarUsuario(12345000);
CALL eliminarUsuario(23456100);
CALL eliminarUsuario(34561234);
CALL eliminarUsuario(45612345);
CALL eliminarUsuario(56712345);
CALL eliminarUsuario(67812345);
CALL eliminarUsuario(78912345);
CALL eliminarUsuario(89012349);
CALL eliminarUsuario(90123446);
CALL eliminarUsuario(23456752);
CALL eliminarUsuario(34567821);
CALL eliminarUsuario(45678905);
CALL eliminarUsuario(56789028);
CALL eliminarUsuario(67890132);
CALL eliminarUsuario(78901258);
CALL eliminarUsuario(89012384);
CALL eliminarUsuario(90123496);
CALL eliminarUsuario(12345637);
CALL eliminarUsuario(23456764);
CALL eliminarUsuario(34567881);
CALL eliminarUsuario(45678976);
CALL eliminarUsuario(56789542);
CALL eliminarUsuario(67890378);
CALL eliminarUsuario(95654132);
CALL eliminarUsuario(23151841);
CALL eliminarUsuario(96518812);
CALL eliminarUsuario(65468123);
CALL eliminarUsuario(28735688);
CALL eliminarUsuario(1013259710);
CALL eliminarUsuario(1013259711);
CALL eliminarUsuario(1013259712);
CALL eliminarUsuario(1013259713);
CALL eliminarUsuario(1013259714);
CALL eliminarUsuario(1013259715);
CALL eliminarUsuario(1013259716);
CALL eliminarUsuario(1013259717);
CALL eliminarUsuario(1013259718);

select * from Usuario;

/*Código Terreno*/

/*Se crea un procedimiento para registrar Terreno*/
DELIMITER //
CREATE PROCEDURE RegistrarTerreno(
	IN p_nombreTerreno VARCHAR(10),
    IN p_estadoTerreno enum ('Apto', 'No apto'),
    IN p_fechaIngreso DATE,
    IN p_fechaSalida DATE
)

BEGIN
    DECLARE diasEnTerreno int;
    
    SET diasEnTerreno = TIMESTAMPDIFF(DAY, p_fechaIngreso, p_fechaSalida);
	
    INSERT INTO terreno VALUES (' ',p_nombreTerreno, p_estadoTerreno, p_fechaIngreso, p_fechaSalida, diasEnTerreno);
		
END //
DELIMITER ;

/*Se registra la información del terreno tomada de ChatGpt*/
CALL RegistrarTerreno('TOPACIO', 'Apto', '2023-01-01', '2023-01-03');
CALL RegistrarTerreno('MATA DE FI', 'Apto', '2023-01-04', '2023-01-05');
CALL RegistrarTerreno('CACAO', 'Apto', '2023-01-06', '2023-01-08');
CALL RegistrarTerreno('SAN RAFAL1', 'Apto', '2023-01-09', '2023-01-11');
CALL RegistrarTerreno('SAN RAFAEL2', 'Apto', '2023-01-12', '2023-01-13');
CALL RegistrarTerreno('SAN RAFAEL3', 'Apto', '2023-01-14', '2023-01-15');
CALL RegistrarTerreno('PORVENIR 1', 'Apto', '2023-01-16', '2023-01-17');
CALL RegistrarTerreno('PORVENIR 2', 'Apto', '2023-01-18', '2023-01-20');
CALL RegistrarTerreno('PORVENIR 3', 'Apto', '2023-01-21', '2023-01-22');
CALL RegistrarTerreno('PORVENIR 4', 'Apto', '2023-01-23', '2023-01-25');
CALL RegistrarTerreno('CASA QUEMA', 'Apto', '2023-01-26', '2023-01-27');
CALL RegistrarTerreno('TOPA', 'Apto', '2023-01-28', '2023-01-30');
CALL RegistrarTerreno('MATARO', 'Apto', '2023-01-31', '2023-02-02');
CALL RegistrarTerreno('LOS SAUCES', 'Apto', '2023-02-03', '2023-02-05');
CALL RegistrarTerreno('EL CEDRO', 'Apto', '2023-02-06', '2023-02-07');
CALL RegistrarTerreno('LOS PINOS', 'Apto', '2023-02-08', '2023-02-09');
CALL RegistrarTerreno('SAN MIGUEL', 'Apto', '2023-02-10', '2023-02-11');
CALL RegistrarTerreno('BUENOS AIRES', 'Apto', '2023-02-12', '2023-02-13');
CALL RegistrarTerreno('NOGALES', 'Apto', '2023-02-14', '2023-02-15');
CALL RegistrarTerreno('EL ROBLE', 'Apto', '2023-02-16', '2023-02-17');
CALL RegistrarTerreno('PALMAR', 'Apto', '2023-02-18', '2023-02-19');
CALL RegistrarTerreno('AGUAZUL', 'Apto', '2023-02-20', '2023-02-21');
CALL RegistrarTerreno('EL JARDÍN', 'Apto', '2023-02-22', '2023-02-23');
CALL RegistrarTerreno('CARRIZAL', 'Apto', '2023-02-24', '2023-02-25');
CALL RegistrarTerreno('LA PRADERA', 'Apto', '2023-02-26', '2023-02-27');
CALL RegistrarTerreno('VISTA', 'Apto', '2023-02-28', '2023-03-01');
CALL RegistrarTerreno('ELBA', 'Apto', '2023-03-02', '2023-03-03');
CALL RegistrarTerreno('MONTE VERDE', 'Apto', '2023-03-04', '2023-03-06');
CALL RegistrarTerreno('MONTES', 'Apto', '2023-03-07', '2023-03-08');
CALL RegistrarTerreno('ESPERANZA', 'Apto', '2023-03-09', '2023-03-10');
CALL RegistrarTerreno('LOS NARANJOS', 'Apto', '2023-03-11', '2023-03-13');
CALL RegistrarTerreno('ALTOS', 'Apto', '2023-03-14', '2023-03-15');
CALL RegistrarTerreno('ALVAREZ', 'Apto', '2023-03-16', '2023-03-17');
CALL RegistrarTerreno('MONTE VERDE 1', 'Apto', '2023-03-18', '2023-03-19');
CALL RegistrarTerreno('MONTES 1', 'Apto', '2023-03-20', '2023-03-21');
CALL RegistrarTerreno('LOS NARANJOS 1', 'Apto', '2023-03-22', '2023-03-23');
CALL RegistrarTerreno('MONTE VERDE 2', 'Apto', '2023-03-24', '2023-03-25');
CALL RegistrarTerreno('MONTES 2', 'Apto', '2023-03-26', '2023-03-27');
CALL RegistrarTerreno('MONTE VERDE 2', 'Apto', '2023-03-28', '2023-03-29');
CALL RegistrarTerreno('ELBA 1', 'Apto', '2023-03-30', '2023-03-31');
CALL RegistrarTerreno('ELBA 2', 'Apto', '2023-04-01', '2023-04-02');
CALL RegistrarTerreno('VISTA 1', 'Apto', '2023-04-03', '2023-04-04');
CALL RegistrarTerreno('VISTA 2', 'Apto', '2023-04-05', '2023-04-06');
CALL RegistrarTerreno('LA FELICIDAD', 'Apto', '2023-04-07', '2023-04-08');
CALL RegistrarTerreno('LA FELICIDAD 2', 'Apto', '2023-04-09', '2023-04-10');
CALL RegistrarTerreno('HANNAN', 'Apto', '2023-04-11', '2023-04-12');
CALL RegistrarTerreno('LA VISTA 2', 'Apto', '2023-04-13', '2023-04-14');
CALL RegistrarTerreno('TOPA', 'Apto', '2023-04-15', '2023-04-16');
CALL RegistrarTerreno('RAMIREZ', 'Apto', '2023-04-17', '2023-04-18');
CALL RegistrarTerreno('AUXIL', 'Apto', '2023-04-19', '2023-04-20');

select count(*) from Terreno;

/*Consulta básica de la información del Terreno*/
select * from Terreno;

/*Consultar nombre de terreno*/
CREATE VIEW nameTerreno as
select nombreTerreno from terreno;
select * from nameTerreno;

/*Consultar Estado del Terreno*/
CREATE VIEW stateTerreno as
select nombreTerreno,estadoTerreno from terreno
where estadoTerreno='Apto';
select * from stateTerreno;

/*Consultar fechas de entrada y salida de terreno*/
CREATE VIEW fechasTerreno as
select nombreTerreno,fechaIngreso,fechaSalida from terreno where estadoTerreno='Apto';
select * from fechasTerreno;

/*Consultar terreno que dure menos de 2 días*/
CREATE VIEW TerrenoMenosDias as
select nombreTerreno,diasTerreno from terreno where diasTerreno < 2;
select * from TerrenoMenosDias;

/*Consultar Días en terreno*/
CREATE VIEW dayTerreno as
select nombreTerreno,diasTerreno from terreno where estadoTerreno='Apto';
select * from dayTerreno;

/*Modificar estado terreno*/
DELIMITER //
CREATE PROCEDURE modificarEstadoTerreno(
	IN a_nombreTerreno varchar(10),
    IN a_estadoTerreno varchar(10)
)
BEGIN
	UPDATE terreno
		SET estadoTerreno=a_estadoTerreno 
        where nombreTerreno=a_nombreTerreno;
END //
DELIMITER ;
SET SQL_SAFE_UPDATES=0;
CALL modificarEstadoTerreno('TOPACIO','NO APTO');
CALL modificarEstadoTerreno('PORVENIR 2','NO APTO');

select nombreTerreno,estadoTerreno from Terreno where nombreTerreno='TOPACIO' or nombreTerreno='PORVENIR 2';

/*Modificar fecha de ingreso y salida*/
DELIMITER //
CREATE PROCEDURE modificarFechasTerreno(
	IN a_nombreTerreno varchar(10),
    IN a_fechaIngreso date,
    IN a_fechaSalida date
)
BEGIN
	UPDATE terreno
		SET fechaIngreso=a_fechaIngreso,fechaSalida=a_fechaSalida
        where nombreTerreno=a_nombreTerreno;
END //
DELIMITER ;
CALL modificarFechasTerreno('LA VISTA 2','2023-03-04','2023-03-05');
CALL modificarFechasTerreno('CACAO','2023-03-10','2023-03-05');
CALL modificarFechasTerreno('MATA DE FI','2023-03-10','2023-03-08');

select nombreTerreno,fechaIngreso,fechaSalida from Terreno where nombreTerreno='LA VISTA 2' or nombreTerreno='CACAO' or nombreTerreno='MATA DE FI';

/*Eliminar terreno*/
DELIMITER //
CREATE PROCEDURE eliminarTerreno(
	IN  a_idTerreno varchar(10)
)
BEGIN
	DELETE FROM terreno
    where idTerreno=a_idTerreno;
END //
DELIMITER ;
CALL eliminarTerreno(1);
select * from Terreno;

/*Código Producción*/

/*Se crea un procedimiento para registrar producción*/
DELIMITER //
CREATE PROCEDURE RegistrarProduccion(
    IN p_fechaRegistro TIMESTAMP , 
    IN p_cantLitrosMañanaAnimal INT, 
    IN p_cantLitrosTardeAnimal INT, 
    IN p_idAnimalFK INT, 
    IN p_documentoUsuFK INT, 
    IN p_idTerrenoFK INT
)
BEGIN
    DECLARE p_cantLitrosDiaAnimal INT;
    
    SET p_cantLitrosDiaAnimal = p_cantLitrosMañanaAnimal + p_cantLitrosTardeAnimal;

    INSERT INTO Produccion (fechaRegistro,cantLitrosMañanaAnimal,cantLitrosTardeAnimal,cantLitrosDiaAnimal,idAnimalFK,documentoUsuFK,idTerrenoFK) 
    VALUES (p_fechaRegistro,p_cantLitrosMañanaAnimal,p_cantLitrosTardeAnimal,p_cantLitrosDiaAnimal,p_idAnimalFK,p_documentoUsuFK,p_idTerrenoFK);
END //
DELIMITER ;

/*Se registran los datos tomados del ChatGpt*/
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 2, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 3, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 4, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 5, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 6, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 7, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 8, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 9, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 10, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 11, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 12, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 13, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 14, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 15, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 16, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 17, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 18, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 19, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 20, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 21, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 22, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 23, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 24, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 25, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 26, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 27, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 28, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 29, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 30, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 31, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 32, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 33, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 34, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 35, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 36, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 37, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 38, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 39, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 40, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 41, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 42, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 43, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 44, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 45, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 9, 9, 46, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 10, 10, 47, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 11, 6, 48, 7310098, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 12, 7, 49, 1013259709, 4);
CALL RegistrarProduccion('2023-01-01 06:00:00', 8, 8, 50, 7310098, 4);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 2, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 3, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 4, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 5, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 6, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 7, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 8, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 9, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 10, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 11, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 12, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 13, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 14, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 15, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 16, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 17, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 18, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 19, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 20, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 21, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 22, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 23, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 24, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 25, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 26, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 27, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 28, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 29, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 30, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 31, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 32, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 33, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 34, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 35, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 36, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 37, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 38, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 39, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 40, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 41, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 42, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 43, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 44, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 45, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 9, 9, 46, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 10, 10, 47, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 11, 6, 48, 7310098, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 12, 7, 49, 1013259709, 6);
CALL RegistrarProduccion('2023-01-02 06:00:00', 8, 8, 50, 7310098, 6);

/*Consulta la cantidad de datos que se registraron*/
select count(*) from Produccion;

/*Consulta los registros*/
select * from produccion;

/*Consultar litros*/
CREATE VIEW litrosProduccion  AS
SELECT 
  DATE(fechaRegistro) AS fecha,
  SUM(cantLitrosMañanaAnimal) AS 'Litros por la Mañana',
  SUM(cantLitrosTardeAnimal) AS 'Litros por la Tarde',
  SUM(cantLitrosDiaAnimal) AS 'Total del día'
FROM Produccion
GROUP BY DATE(fechaRegistro)
ORDER BY fecha;

select * from litrosProduccion;

/*Consultar producción por día animal*/
/*Animales que tienen mayor produccion al día*/
SELECT a.idAnimal,a.nombreAnimal,SUM(p.cantLitrosDiaAnimal) AS totalLitros
FROM Produccion p JOIN Animal a ON p.idAnimalFK = a.idAnimal
GROUP BY a.idAnimal, a.nombreAnimal HAVING totalLitros = (SELECT MAX(totalPorAnimal) FROM (SELECT SUM(cantLitrosDiaAnimal) AS totalPorAnimal 
FROM Produccion GROUP BY idAnimalFK ) AS sub);

/*Animales que tienen la menor producción por día*/
SELECT a.idAnimal, a.nombreAnimal,SUM(p.cantLitrosDiaAnimal) AS totalLitros
FROM Produccion p JOIN Animal a ON p.idAnimalFK = a.idAnimal GROUP BY  a.idAnimal, a.nombreAnimal
HAVING totalLitros = (SELECT MIN(totalPorAnimal) FROM (SELECT SUM(cantLitrosDiaAnimal) AS totalPorAnimal
FROM Produccion GROUP BY idAnimalFK) AS sub);

/*Consulta por animal en específico*/
DELIMITER //
CREATE PROCEDURE produccionAnimal(
	IN c_idAnimal int
)
BEGIN
	SELECT p.fechaRegistro,p.idAnimalFK,a.nombreAnimal,p.cantLitrosMañanaAnimal,p.cantLitrosTardeAnimal,p.cantLitrosDiaAnimal
    from produccion p
    join animal a on p.idAnimalFK=a.idAnimal
    where p.idAnimalFK=c_idAnimal;
END //
DELIMITER ;

call produccionAnimal(7);

/*Consultar producción por terreno*/
/*Terreno con menor produccion*/
SELECT t.idTerreno,t.nombreTerreno,SUM(p.cantLitrosDiaAnimal) AS totalLitros
FROM Produccion p JOIN Terreno t ON p.idTerrenoFK = t.idTerreno GROUP BY t.idTerreno, t.nombreTerreno
HAVING totalLitros = (SELECT MIN(totalPorTerreno) FROM (SELECT SUM(cantLitrosDiaAnimal) AS totalPorTerreno
FROM Produccion GROUP BY idTerrenoFK) AS sub);


/*Procedimiento de la producción total en un terreno*/
DELIMITER //
CREATE PROCEDURE produccionTerreno(
	IN c_idTerreno INT
)
BEGIN
	SELECT 
		p.idTerrenoFK AS 'ID',
		t.nombreTerreno 'Nombre del Terreno',
		t.diasTerreno AS 'Días en Terreno',
		SUM(p.cantLitrosDiaAnimal) AS 'Litros'
	FROM 
		Produccion p
	INNER JOIN 
		Terreno t ON p.idTerrenoFK = t.idTerreno
	WHERE 
		t.idTerreno = c_idTerreno
	GROUP BY 
		t.nombreTerreno, p.idTerrenoFK, t.diasTerreno;
END //
DELIMITER ;

CALL produccionTerreno(4);
  
/*Modificar producción de la mañana de un animal*/
DELIMITER //
CREATE PROCEDURE modificarProduccionManana(
    IN p_idProduccion INT,
    IN p_nuevaCantidad INT
)
BEGIN
    UPDATE Produccion
    SET 
        cantLitrosMañanaAnimal = p_nuevaCantidad,
        cantLitrosDiaAnimal = p_nuevaCantidad + cantLitrosTardeAnimal
    WHERE idProduccion = p_idProduccion;
END //
DELIMITER ;

CALL modificarProduccionManana(3,15);
CALL modificarProduccionManana(8,18);

select idProduccion,fechaRegistro,cantLitrosMañanaAnimal,cantLitrosTardeAnimal,cantLitrosDiaAnimal from produccion
where idProduccion=3 or idProduccion=8;

/*Modificar producción de la tarde de un animal*/
DELIMITER //
CREATE PROCEDURE modificarProduccionTarde(
    IN p_idProduccion INT,
    IN p_nuevaCantidad INT
)
BEGIN
    UPDATE Produccion
    SET 
        cantLitrosTardeAnimal = p_nuevaCantidad,
        cantLitrosDiaAnimal = cantLitrosMañanaAnimal + p_nuevaCantidad
    WHERE idProduccion = p_idProduccion;
END //
DELIMITER ;

CALL modificarProduccionTarde(8,4);
CALL modificarProduccionTarde(10,13);

select idProduccion,fechaRegistro,cantLitrosMañanaAnimal,cantLitrosTardeAnimal,cantLitrosDiaAnimal from produccion
where idProduccion=4 or idProduccion=10;

/*Eliminar producción*/
CREATE TABLE produccionDefectuosa (
	idDefecto int AUTO_INCREMENT PRIMARY KEY,
    fechaRegistro TIMESTAMP NOT NULL,
    jornada ENUM('Mañana','Tarde'),
    Litros INT NOT NULL
);

DELIMITER //
CREATE TRIGGER defectoLactosa
BEFORE UPDATE ON Produccion
FOR EACH ROW
BEGIN
    IF OLD.cantLitrosMañanaAnimal <> NEW.cantLitrosMañanaAnimal THEN
        INSERT INTO produccionDefectuosa (fechaRegistro, jornada, Litros)
        VALUES (OLD.fechaRegistro, 'Mañana', OLD.cantLitrosMañanaAnimal);
    END IF;
    IF OLD.cantLitrosTardeAnimal <> NEW.cantLitrosTardeAnimal THEN
        INSERT INTO produccionDefectuosa (fechaAfectada, turnoAnulado, litrosAfectados)
        VALUES (OLD.fechaRegistro, 'Tarde', OLD.cantLitrosTardeAnimal);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE defectoLactosa(
    IN p_fechaRegistro DATE,
    IN p_mañanaTarde BOOLEAN
)
BEGIN
    IF p_mañanaTarde = TRUE THEN
        UPDATE Produccion
        SET 
            cantLitrosMañanaAnimal = 0,
            cantLitrosDiaAnimal=cantLitrosTardeAnimal            
        WHERE DATE(fechaRegistro) = p_fechaRegistro;
    ELSE
        UPDATE Produccion
        SET 
            cantLitrosTardeAnimal = 0,
            cantLitrosDiaAnimal=cantLitrosMañanaAnimal 
        WHERE DATE(fechaRegistro) = p_fechaRegistro;
    END IF;
END //
DELIMITER ;

CALL defectoLactosa('2023-01-01 06:00:00', TRUE);

/*Consultar producciones eliminadas*/
select * from produccionDefectuosa;
