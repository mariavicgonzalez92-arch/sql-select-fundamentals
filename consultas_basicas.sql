-- ══════════════════════════════════════════
-- TechStore — Consultas Básicas SELECT
-- Autor: Maria Victoria Gonzalez
-- Fecha: 26/07/2026
-- ══════════════════════════════════════════

-- Consulta 1: Exploración general de la tabla sales
-- NOTA DE USO DE 'SELECT *':
-- ¿Cuándo tiene sentido usar SELECT *?
-- Tiene sentido en entornos de desarrollo, pruebas o exploración puntual para conocer rápidamente
-- la estructura, los tipos de datos y los nombres de columnas de una tabla desconocida.
-- ¿Cuándo NO tiene sentido usar SELECT *?
-- No debe usarse en entornos de producción, dentro de código de aplicaciones ni en consultas periódicas/automatizadas,
-- ya que afecta negativamente el rendimiento, incrementa el consumo de red/memoria, puede exponer datos sensibles
-- y rompe la mantenibilidad del código si la estructura de la tabla cambia.

SELECT * 
FROM sales;


-- Consulta 2: Selección de columnas específicas para finanzas

SELECT 
    customer_id, 
    product_id, 
    total_amount
FROM sales;


-- Consulta 3: Selección con alias en español para stakeholders

SELECT 
    order_date AS fecha_pedido,
    product_name AS nombre_producto,
    quantity AS cantidad_unidades
FROM sales;
