USE tienda;

-- Reto 01 --
DESCRIBE articulo;
DESCRIBE empleado;
DESCRIBE puesto;
DESCRIBE venta;

/* Tipos de datos contenido en la DB Tienda:

    Tipo	    Descripción
    int	        Números enteros
    varchar	    Cadenas de caracteres
    timestamp	Fechas
    double	    Números con decimales

*/

-- Reto 02 --

SELECT nombre FROM empleado WHERE id_puesto = 4;
SELECT * FROM puesto WHERE salario > 10000;
SELECT * FROM articulo WHERE precio > 1000 AND iva > 100;
SELECT * FROM venta WHERE id_articulo IN (135, 963) AND id_empleado IN (835, 369);

-- Reto 03 --

SELECT * FROM puesto ORDER BY salario DESC LIMIT 5;