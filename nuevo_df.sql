use ny_project;

-- comprobamos que los datos se han importado correctamente
SELECT * FROM airbnb;
SELECT * FROM crimenes;

-- seleccionamos las columnas que queremos que se muestren
-- aplicamos función AVG a todas las columnas de crimenes porque es requisito para hacer el GROUP BY, aunque no repercute en el resultado final
-- hacemos join entre las tablas tomando el barrio como punto de referencia

CREATE TEMPORARY TABLE resumen_crimenes
SELECT 
	a.barrio AS barrios, ROUND(AVG(a.precio)) AS precio_medio, ROUND(AVG(a.numero_de_reviews)) AS num_medio_reviews,
	ROUND(AVG(c.numero_de_delitos)) AS numero_de_delitos, ROUND(AVG(c.numero_de_faltas)) AS numero_de_faltas, ROUND(AVG(c.numero_de_violaciones)) AS numero_de_violaciones, ROUND(AVG(c.diferencia_2017)) AS diferencia_crimenes_2016_2017, ROUND(AVG(c.diferencia_2018)) AS diferencia_crimenes_2017_2018
FROM ny_project.airbnb as a
JOIN ny_project.crimenes as c
ON a.barrio = c.barrio
GROUP BY a.barrio;

SELECT * FROM resumen_crimenes;

-- Este bloque crea el promedio de crímenes por cada barrio en relación al total
CREATE TEMPORARY TABLE resumen_crimenes_totales
SELECT *, numero_de_delitos + numero_de_faltas + numero_de_violaciones AS total_crimenes
FROM resumen_crimenes;

CREATE TEMPORARY TABLE sumatorio_total_crimenes
SELECT SUM(total_crimenes) AS crimenes_totales
FROM resumen_crimenes_totales;

SELECT barrios, (rc.total_crimenes/st.crimenes_totales) * 100 AS crimenes_promedio
FROM resumen_crimenes_totales AS rc
JOIN sumatorio_total_crimenes AS st;

-- Este bloque calcula el promedio de precio de cada barrio en relación al total de barrios

CREATE TEMPORARY TABLE precios_medios_totales
SELECT SUM(precio_medio) AS precio_medio_total
FROM resumen_crimenes;

SELECT barrios, (rc.precio_medio/pm.precio_medio_total) * 100 AS promedio_de_precio
FROM resumen_crimenes_totales AS rc
JOIN precios_medios_totales AS pm;

-- Este bloque calcula el promedio de reviews de cada barrio en relación al total de barrios

CREATE TEMPORARY TABLE num_medio_reviews_totales
SELECT SUM(num_medio_reviews) AS num_medio_reviews_total
FROM resumen_crimenes;

SELECT barrios, (rc.num_medio_reviews/nmr.num_medio_reviews_total) * 100 AS promedio_de_reviews
FROM resumen_crimenes_totales AS rc
JOIN num_medio_reviews_totales AS nmr;

-- Promedios totales de cada tipo de infracción por barrio

CREATE TEMPORARY TABLE numero_total_de_delitos
SELECT SUM(numero_de_delitos) AS numero_total_delitos
FROM resumen_crimenes;

CREATE TEMPORARY TABLE numero_total_de_faltas
SELECT SUM(numero_de_faltas) AS numero_total_faltas
FROM resumen_crimenes;

CREATE TEMPORARY TABLE numero_total_de_violaciones
SELECT SUM(numero_de_violaciones) AS numero_total_violaciones
FROM resumen_crimenes;

SELECT barrios,
	   (rc.numero_de_delitos/ntd.numero_total_delitos) * 100 AS promedio_de_delitos,
       (rc.numero_de_faltas/ntf.numero_total_faltas) * 100 AS promedio_de_faltas,
       (rc.numero_de_violaciones/ntv.numero_total_violaciones) * 100 AS promedio_de_violaciones
FROM resumen_crimenes_totales AS rc
JOIN numero_total_de_delitos AS ntd
JOIN numero_total_de_faltas AS ntf
JOIN numero_total_de_violaciones AS ntv;

