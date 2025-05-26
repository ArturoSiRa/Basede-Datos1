--COMANDOS PROYECTO BASE DE DATOS MAYO


CREATE database proyecto_mayo;

USE proyecto_mayo;

CREATE table regiones(
      id_region INT PRIMARY KEY AUTO_INCREMENT,
      rnombre VARCHAR(40) NOT NULL
      );

CREATE TABLE pueblos(
      id_pueblo INT PRIMARY KEY AUTO_INCREMENT,
      pnombre VARCHAR(100) NOT NULL,
      num_habitantes INT NOT NULL,
      id_region INT NOT NULL,
      FOREIGN KEY (id_region) REFERENCES regiones(id_region)
      );

CREATE TABLE atracciones(
      id_atraccion INT PRIMARY KEY AUTO_INCREMENT,
      anombre VARCHAR(60) NOT NULL,
      turistas_anio INT NOT NULL,
      id_pueblo INT,
      FOREIGN KEY (id_pueblo) REFERENCES pueblos(id_pueblo)
      );



INSERT INTO regiones (rnombre) VALUES
      ('Valles Centrales'),
      ('Sierra Norte'),
      ('Sierra Sur'),
      ('Costa'),
      ('Istmo'),
      ('Mixteca'),
      ('Papaloapan'),
      ('Cañada');


INSERT INTO pueblos (pnombre, num_habitantes, id_region) VALUES
('San Pablo Villa de Mitla', 10000, 1),   
('Capulálpam de Méndez', 2000, 2),       
('San Pedro y San Pablo Teposcolula', 5000, 6),
('Huautla de Jiménez', 35000, 8), 
('Mazunte', 1500, 4); 

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Zona Arqueológica de Mitla', 350000, 1),
('Iglesia de San Pablo Apóstol', 180000, 1),
('Fábricas de Mezcal de Mitla', 120000, 1),
('Mercado de Artesanías de Mitla', 150000, 1);

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Templo de San Mateo', 50000, 2),
('Mirador de la Cruz', 40000, 2),
('Centro de Medicina Tradicional', 25000, 2),
('Senderos Ecoturísticos', 30000, 2);


INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Ex Convento de San Pedro y San Pablo', 70000, 3),
('Capilla Abierta', 60000, 3),
('Casa de la Cacica', 30000, 3),
('Ruinas del Cerro del Pueblo Viejo', 20000, 3);


INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Casa de María Sabina', 90000, 4),
('Cerro de la Adoración', 50000, 4),
('Grutas de San Agustín', 60000, 4),
('Mercado Tradicional de Huautla', 75000, 4);

INSERT INTO atracciones (anombre, turistas_anio, id_pueblo) VALUES
('Playa Mazunte', 200000, 5),
('Punta Cometa', 180000, 5),
('Centro Mexicano de la Tortuga', 150000, 5),
('Playa Mermejita', 100000, 5);