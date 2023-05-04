/*								EVALUACION FINAL MODULO 3
							     “Te lo vendo” – Sprint
						Desarrollo Final del Módulo Bases de datos.
            
Nombres: Jorge Moraga C., Gustavo Ruiz S., Juan Pino C., Harold Klapp

	Ingreso de datos a la BD y consultas requeridas:
*/

-- Deben crear un usuario con privilegios para crear, eliminar y modificar tablas, insertar registros.
CREATE USER 'admintlv'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON telovendo.* TO 'admintlv'@'localhost';
FLUSH PRIVILEGES;
USE telovendo;

-- Agregue 5 proveedores a la base de datos.
INSERT INTO proveedores (nombre_representante_legal, nombre_corporativo, nombre_contacto, correo_electronico, categoria_productos)
VALUES 
('Juan Perez', 'Perez Computing', 'Juan Perez', 'juan@perezcomputing.com', 'Informática y Computación'),
('María García', 'García Computación', 'María García', 'maria@garciacomputacion.com', 'Electronica'),
('Pedro Rodríguez', 'Rodríguez Sistemas', 'Pedro Rodríguez', 'pedro@rodriguezsistemas.com', 'Computacion y perifericos'),
('Ana López', 'López Tecnología', 'Ana López', 'ana@lopeztec.com', 'Informática y Computación'),
('Luis Gutiérrez', 'Gutiérrez Soluciones', 'Luis Gutiérrez', 'luis@gutierrezsoluciones.com', 'Informática y Computación');
SELECT * FROM proveedores;

-- TeLoVendo tiene actualmente muchos clientes, pero nos piden que ingresemos solo 5 para probar la nueva base de datos. 
-- Cada cliente tiene un nombre, apellido, dirección (solo pueden ingresar una).
INSERT INTO clientes (id, nombre, apellido, direccion)
VALUES 
(1, 'Martín', 'González', 'Av. Providencia 123, Santiago, Chile'),
(2, 'Ana', 'Martínez', 'Calle San Martín 456, Santiago, Chile'),
(3, 'Juan', 'Rodríguez', 'Av. Las Condes 789, Santiago, Chile'),
(4, 'María', 'Fernández', 'Calle Huérfanos 321, Santiago, Chile'),
(5, 'Lucas', 'García', 'Av. Vicuña Mackenna 654, Santiago, Chile');
SELECT * FROM clientes;

-- Ingrese 10 productos y su respectivo stock. Cada producto tiene información sobre su precio, su categoría, proveedor y color.
INSERT INTO productos (nombre, precio, categoria, color, stock)
VALUES
('Laptop Dell', '300000', 'Computación', 'Negro', '20'),
('Smartphone Samsung', '200000', 'Electrónica', 'Gris', '15'),
('Monitor LG', '100000', 'Computación', 'Negro', '25'),
('Tablet Lenovo', '150000', 'Computación', 'Blanco', '12'),
('Impresora HP', '80000', 'Computación', 'Blanco', '18'),
('Smartwatch Xiaomi', '50000', 'Electrónica', 'Rojo', '10'),
('Altavoz Bose', '400000', 'Electrónica', 'Gris', '22'),
('Cámara Canon', '350000', 'Electrónica', 'Negro', '16'),
('Teclado Logitech', '60000', 'Computación', 'Negro', '19'),
('Auriculares Sony', '120000', 'Electrónica', 'Rojo', '14');
SELECT * FROM productos;

-- *Ingresamos datos a las tablas referenciadas creadas en el MER para responder a los requerimientos
-- tabla telefonos:  creada a partir de la necesidad de almacenar 2 telefonos asociados a un proveedor
INSERT INTO telefonos (numero, numero_contacto, proveedor_id)
VALUES
('+5692255522', '+5692255533',1 ),
('+5692211133', '+5692266677',2 ),
('+5692233344', '+5692277788',3 ),
('+5692244455', '+5692288899',4 ),
('+5692255566', '+5692299900',5 );
SELECT * FROM telefonos;

-- tabla producto_proveedores: creada por la relacion muchos a muchos. Un producto tiene mas de un proveedor
-- y un proveedor tiene muchos productos
INSERT INTO producto_proveedores (id_producto, id_proveedor)
VALUES
(2,1),
(4,1),
(8,1),
(1,2),
(9,2),
(3,3),
(2,3),
(6,3),
(2,4),
(10,4),
(7,4),
(3,4),
(1,5),
(4,5),
(5,5);
SELECT * FROM producto_proveedores;

 
/* Luego debemos realizar consultas SQL que indiquen: */

-- Cuál es la categoría de productos que más se repite.
	-- Categoria Computacion, con 5 registros
SELECT categoria, COUNT(*) as total
FROM productos
GROUP BY categoria
ORDER BY total DESC -- ordenamos de mayor a menor para obtener con LIMIT el primero de la lista (mayor)
LIMIT 1;

-- Cuáles son los productos con mayor stock
	-- Los 3 productos que tienen más stock son Monitor LG con 25 unidades, Altavoz Bose con 22 unidades y Laptop Dell con 20 unidades
SELECT nombre, stock
FROM productos
ORDER BY stock DESC -- ordenamos de mayor a menor para obtener con LIMIT los 3 primeros elementos de la lista (mayor)
LIMIT 3;

-- Qué color de producto es más común en nuestra tienda.
	-- El color de producto mas comun es el Negro con 4 productos con este color
SELECT color, COUNT(*) AS total  -- seleccionamos los datos a mostrar, con COUNT(*) contamos las veces que se repite el color
FROM productos
GROUP BY color
ORDER BY total DESC -- ordenamos de mayor a menor para obtener con LIMIT el primero de la lista (mayor)
LIMIT 1;

-- Cual o cuales son los proveedores con menor stock de productos.
	-- El proveedor con menor stock de productos en Telovendo es Gutierrez Soluciones con 18 productos en stock
SELECT proveedores.nombre_corporativo, SUM(productos.stock) AS total_stock -- seleccionamos los datos a mostrar incluida la suma de los productos en stock por proveedor
FROM proveedores
JOIN producto_proveedores ON proveedores.id_proveedor = producto_proveedores.id_proveedor  -- hacemos JOIN entre las tablas producto_proveedores y proveedores
JOIN productos ON producto_proveedores.id_producto = productos.id_producto -- hacemos JOIN entre la tabla producto_proveedores y productos
GROUP BY proveedores.id_proveedor, proveedores.nombre_corporativo  -- agrupamos los resultados el provedor y por el nombre corporativo del proveedor
ORDER BY total_stock ASC -- ordenamos de menor a mayor para poder obtener con LIMIT los 3 primeros elementos de la lista (menor)
LIMIT 3;


-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
	-- Se cambia la categoria "Computacion" que en total hay 94 productos en stock por "Electrónica y computación"
 
/*
UPDATE productos
SET categoria = 'Electrónica y computación'
WHERE categoria = (
  SELECT categoria
  FROM productos 
  GROUP BY categoria
  ORDER BY SUM(stock) DESC
  LIMIT 1
) ;
SELECT * FROM productos;
*/

UPDATE productos set categoria = 'Electrónica y computación'
WHERE categoria = 
( SELECT cate FROM (select categoria as cate, SUM(stock) as total_stock from productos group by categoria order by total_stock  desc LIMIT 1) AS subconsulta);


