# Documentación del Proyecto - Buenas Prácticas SQL

---

## 1. ¿Por qué es una mala práctica usar `SELECT *` en producción?

Utilizar `SELECT *` en entornos de producción genera problemas significativos en el sistema. A continuación se detallan las razones principales:

### 1. Rendimiento y consumo de recursos
Al consultar todas las columnas de una tabla, la base de datos se ve obligada a leer de disco e intercambiar por red datos innecesarios.
* **Sobrecarga de Red y Memoria:** Si una tabla tiene 50 columnas y solo se necesitan 3, se está transfiriendo hasta un 90% más de volumen de datos de lo requerido.
* **Inhabilitación de Índices:** Impide que el motor de la base de datos aproveche los *covering indexes* (índices que contienen exactamente las columnas solicitadas), obligándolo a hacer lecturas completas a la tabla (*table scans* o *lookup* a disco).

### 2. Mantenibilidad y fragilidad del código
El uso de `SELECT *` acopla la aplicación a la estructura física exacta de la tabla.
* **Rompe la lógica de la aplicación:** Si en el futuro se añade, elimina o reordena una columna en la base de datos, el orden de los datos devueltos cambia o la aplicación puede fallar al intentar mapear los campos esperados.
* **Falta de claridad:** Quien revise la consulta o el código no podrá saber qué datos específicos requiere ese proceso sin inspeccionar la tabla en la base de datos.

### 3. Seguridad y privacidad
Devolver todas las columnas expone innecesariamente información sensible.
* Si una tabla de usuarios contiene campos como `password_hash`, `dni` o `tarjeta_credito`, un `SELECT *` los traerá a la capa de aplicación aunque solo se necesite mostrar el `nombre_usuario`, incrementando el riesgo de filtración de datos sensibles.

---

## 2. ¿Por qué son importantes los alias para un stakeholder no técnico?

Los nombres técnicos de las columnas en las bases de datos suelen usar convenciones como *snake_case*, abreviaturas o términos genéricos diseñados para desarrolladores, los cuales resultan ambiguos o confusos para personas de negocio o finanzas.

El uso de **alias** (`AS`) permite renombrar las columnas en el resultado final para transformarlas en términos del dominio del negocio, haciendo que los reportes sean legibles y autoexplicativos.

### Ejemplo práctico

Imaginemos una consulta enviada al equipo de Finanzas:

**Sin alias:**
```sql
SELECT total_amount FROM orders WHERE status = 'completed';
SELECT 
    total_amount AS "Monto Total Facturado (USD con IVA)"
FROM orders 
WHERE status = 'completed';
