CREATE DATABASE IF NOT EXISTS ordinario;
USE ordinario;



CREATE TABLE miembros (
    id_miembro INT AUTO_INCREMENT PRIMARY KEY,
    nombre_miembro VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    fecha_registro DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE bibliotecas (
    id_biblioteca INT AUTO_INCREMENT PRIMARY KEY,
    nombre_biblioteca VARCHAR(200) NOT NULL UNIQUE,
    direccion VARCHAR(255),
    telefono VARCHAR(15)
);

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_autor VARCHAR(100) NOT NULL,
    apellido_autor VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50)
);

CREATE TABLE editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre_editorial VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL,
    año_publicacion YEAR,
    genero VARCHAR(50) NOT NULL, 
    num_paginas SMALLINT,
    total_ejemplares INT NOT NULL DEFAULT 0,
    disponibles INT NOT NULL DEFAULT 0,
    id_autor INT NOT NULL, 
    id_editorial INT NOT NULL,
    id_biblioteca INT NOT NULL, 
    FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_biblioteca) REFERENCES bibliotecas(id_biblioteca)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    UNIQUE (isbn, id_biblioteca)
);

CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_libro INT NOT NULL,  
    id_miembro INT NOT NULL,  
    fecha_prestamo DATE DEFAULT (CURRENT_DATE),
    fecha_vencimiento DATE NOT NULL,
    fecha_devolucion_real DATE,
    estado_prestamo ENUM('Activo', 'Devuelto', 'Vencido') DEFAULT 'Activo',
    FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (id_miembro) REFERENCES miembros(id_miembro)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);



INSERT INTO miembros (nombre_miembro, email, telefono, fecha_registro) VALUES
('Felicidad García Cruz', 'felicidad.gc@email.com', '9511112233', '2024-01-10'),
('Benito Juárez Gómez', 'benito.jg@email.com', '9512223344', '2024-02-15'),
('Florinda Vásquez López', 'florinda.vl@email.com', '9513334455', '2024-03-20'),
('David Toledo Martínez', 'david.tm@email.com', '9514445566', '2024-04-25'),
('Cecilia Ruiz Hernández', 'cecilia.rh@email.com', '9515556677', '2024-05-30'),
('Mario Sánchez Guzmán', 'mario.sg@email.com', '9516667788', '2024-06-05');

INSERT INTO bibliotecas (nombre_biblioteca, direccion, telefono) VALUES
('Biblioteca Francisco de Burgoa', 'Av. Independencia #500, Centro, Oaxaca de Juárez', '9515165444'), 
('Biblioteca del Jardín Etnobotánico de Oaxaca', 'Reforma s/n, Centro, Oaxaca de Juárez', '9515016000'),
('Biblioteca del Museo Textil de Oaxaca', 'Hidalgo #917, Centro, Oaxaca de Juárez', '9515011045'), 
('Fondo de Cultura Económica "Rosario Castellanos"', 'Macedonio Alcalá #403, Centro, Oaxaca de Juárez', '9515147573'), 
('Centro Fotográfico Manuel Álvarez Bravo (CFMAB) - Acervo', 'M. Alcalá #407, Centro, Oaxaca de Juárez', '9515169800'),
('Biblioteca Henestrosa (Fundación Alfredo Harp Helú)', 'Av. Murguía #400, Centro, Oaxaca de Juárez', '9515018800'); 

INSERT INTO autores (nombre_autor, apellido_autor, nacionalidad) VALUES
('Francisco', 'Toledo', 'Mexicana'), 
('Demy', 'Cruz', 'Mexicana'), 
('Natalia', 'Toledo', 'Mexicana'), 
('Víctor de la', 'Cruz', 'Mexicana'),
('Rufino', 'Tamayo', 'Mexicana'), 
('Luis', 'Zamora', 'Mexicana'); 


INSERT INTO editoriales (nombre_editorial) VALUES
('Gedisa'),
('Almadía'),
('Artes de México'),
('UNAM'),
('Caza de Libros');

INSERT INTO libros (titulo, isbn, año_publicacion, genero, num_paginas, total_ejemplares, disponibles, id_autor, id_editorial, id_biblioteca) VALUES
('Crónica de Oaxaca Antigua', '9786070001015', 1980, 'Historia', 300, 2, 2, 3, 4, 1),
('El vuelo de la libélula', '9786078713001', 2020, 'Poesía', 150, 3, 3, 3, 2, 1),

('Plantas de Oaxaca para uso medicinal', '9786071400200', 2015, 'Botánica', 250, 4, 4, 2, 3, 2),
('Biodiversidad en los Valles Centrales', '9786070002022', 2018, 'Ecología', 400, 2, 2, 1, 4, 2),

('Textiles de Oaxaca: Tradición y Diseño', '9786070003033', 2019, 'Arte', 180, 3, 3, 5, 3, 3),
('El telar de cintura: Arte y resistencia', '9786070004044', 2021, 'Antropología', 220, 2, 2, 4, 2, 3),

('La palabra y el silencio: cuentos de Oaxaca', '9786071605055', 2022, 'Cuento', 160, 5, 5, 6, 1, 4),
('Cocina Tradicional de Oaxaca', '9786070006066', 2018, 'Gastronomía', 280, 4, 4, 1, 2, 4),

('Oaxaca a través de la lente', '9786070007077', 2010, 'Fotografía', 200, 3, 3, 5, 3, 5),
('Retratos del Istmo: La fotografía de estudio en Juchitán', '9786070008088', 2015, 'Fotografía', 170, 2, 2, 4, 2, 5),

('La vida en el Istmo', '9786070009099', 1975, 'Novela', 250, 3, 3, 3, 1, 6),
('Mitos y Leyendas de Oaxaca', '9786070010101', 2005, 'Folclore', 190, 4, 4, 2, 5, 6);

INSERT INTO prestamos (id_libro, id_miembro, fecha_prestamo, fecha_vencimiento, fecha_devolucion_real, estado_prestamo) VALUES
(1, 1, '2025-05-01', '2025-05-15', NULL, 'Activo'), 
(3, 2, '2025-04-20', '2025-05-04', '2025-05-03', 'Devuelto'), 
(5, 3, '2025-05-10', '2025-05-24', NULL, 'Activo'),
(7, 4, '2025-03-01', '2025-03-15', '2025-03-20', 'Vencido'), 
(9, 5, '2025-05-28', '2025-06-11', NULL, 'Activo'), 
(11, 6, '2025-04-05', '2025-04-19', '2025-04-18', 'Devuelto'); 

UPDATE libros SET disponibles = disponibles - 1 WHERE id_libro IN (1, 2, 3, 4, 5, 6, 7, 8, 9);
