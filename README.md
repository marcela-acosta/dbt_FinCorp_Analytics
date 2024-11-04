# Proyecto Final: Transformación de Datos con dbt

## Integrantes del grupo

- Marcela Acosta
- Leandro García
- Diego Teijeiro

## Introducción

Este proyecto final del curso **"Transformación de Datos con dbt"** te permitirá aplicar los conocimientos adquiridos durante el curso. Trabajarás en la construcción y optimización de un flujo de transformación de datos para la simulación de un sistema de análisis financiero.

El escenario está basado en una compañía ficticia llamada **"FinCorp Analytics"**, que maneja transacciones bancarias y necesita un sistema eficiente para gestionar y analizar estas transacciones, generando reportes detallados de balances, movimientos por cuenta, y cambios en las cuentas a lo largo del tiempo.

## Configuración Inicial

### Paso 1: Generar un schema en la database postgres con el nombre "raw_data".
### Paso 2: Botón derecho sobre el schema "raw_data", import data y seleccionar "import from csv".
### Paso 3: Seleccionar los 3 csv adjuntos para cargarlos a la base y dar click en siguiente.
### Paso 4: Seleccionar account.csv y dar click en "configure".
### Paso 5: Cambiar el tipo de dato de las columnas "opening_date" y "balance" a "date" e "integer", luego aceptar.
### Paso 6: Aplicar lo mismo para transactions.csv. En este caso para las columnas "transaction_date" y "transaction_amount".
### Paso 7: Siguiente y continuar para empezar a generar las tablas.

Tener en cuenta estos pasos previo a verificar los siguientes puntos del proyecto.
Este desarrollo requiere que las fechas y montos estén configurados correctamente.

## Parte 1: **Carga y Gestión de Fuentes de Datos**
   - Definir las fuentes de datos (`sources`) de las tablas crudas en dbt que contienen información de transacciones y cuentas.
   - Estas tablas deben estar correctamente definidas en el archivo `schema.yml` con las descripciones correspondientes para cada columna.

Creamos el archivo `_sources.yml` para definir las fuentes necesarias para el proyecto.
En este mismo archivo incorporamos las descripciones y tests correspondientes solicitadas en el punto 2.

## Parte 2: **Construcción de Modelos**
   - Crear los modelos que gestionen y transformen los datos crudos en tablas analíticas:
     - `dim_accounts`: Tabla dimensional con información de las cuentas, incluído el tipo de cuenta. Materialización como _tabla_.
     - `fact_transactions`: Fact table con los detalles de las transacciones, incluyendo el balance acumulado por cuenta (de la tabla accounts) y transacción. Materialización como _tabla_.
     - `agg_daily_balances`: Tabla agregada que muestra el balance diario de cada cuenta. Materialización como _incremental_.
     - Puede incluir todos los modelos intermedios que entienda necesarios.

Creamos 3 directorios que representan las distintas etapas del proceso:
  Staging: Para obtener los datos desde la fuente. Lo materializamos como vista.
  Intermediate: Para realizar cálculos, métricas y demás pasos necesarios con el fin de preparar la data para los Marts. Lo materializamos como tablas.
  Mart: Para definir los modelos finales que serán utilizados por el usuario.

En el Mart, generamos 3 modelos según los criterios definidos.
  dim_accounts: Creamos la tabla incluyendo el campo "account_type_id" ya que la columna "account_type" se incluye por defecto en el archivo. Lo materializamos como tabla.
  fact_transactions: Creamos una FT materializada como tabla e incorporamos el campo "balance" obtenido desde la tabla "accounts". Materializado como tabla.
  agg_daily_balances: Creamos una con el balance diario de transacciones por cuenta (suma de las transacciones diarias por cada cuenta) configurada como tabla incremental.
  Para la configuración utilizamos los siguientes parámetros.
  Unique key = Definimos la clave de la tabla.
  On Schema Change = En caso de que se incorporen nuevas columnas, estas se agregan a la tabla sin dar error y cortar el proceso. Para datos previamente cargados, el valor de la nueva columna será null.

## Parte 3: **Snapshots**
   - Crear un modelo de snapshot `snapshot_accounts` para rastrear cambios en el estado de las cuentas (cuenta, balance y tipo de cuenta) en el tiempo.
   - Definir y ejecutar el snapshot para almacenar los cambios históricos.

Creamos un modelo dentro de la carpeta snapshots llamado `snapshot_accounts` para detectar cambios en la data recibida para las cuentas. El objetivo es analizar y detectar posibles    cambios sobre los registros almacenados en la tabla.
Entre las configuraciones aplicadas para este snapshot, destacamos las siguientes:
Unique key = Clave de la tabla
Strategy = Check. Esto comprueba si el valor recibido es el mismo que se tiene almacenado en la tabla.
Check Cols = Donde se definen las columnas que deseamos comprobar si tuvieron algún cambio.

Aclaración: La tabla del snapshot no se utiliza para los modelos desarrollados para no complejizar las consultas desarrolladas. Existe únicamente para mostrar el funcionamiento de los snapshots en general.

Se hicieron pruebas para comprobar el funcionamiento modificando registros en el source y comprobando los cambios al regenerar el snapshot.

## Parte 4: **Validación y Pruebas de Datos**
   - Añadir pruebas para asegurar la calidad de los datos:
     - Pruebas de unicidad y no nulos en los campos `account_id` y `transaction_id`.
     - Pruebas personalizadas para asegurar que los balances no sean negativos.
     - Documentar las pruebas en el archivo `schema.yml`.
     - Incluya pruebas de `dbt_expectations` para chequear que la data de los modelos en mart tengan más de una fila.

Utilizando los test incoporados por dbt (test en el archivo \_sources.yml, data_tests en schema.yml), incoporamos test para verificar valores únicos y comprobar que no tengamos valores nulos sobre los identificadores de las tablas.
Generamos un test personalizado en la carpeta test/generic con el nombre `balance_negativo` configurado como `warning` Esta prueba se encarga de verificar si tenemos registros con balance < 0 (balances negativos).
Definimos y utilizamos el test personalizado en el archivo `schema.yml`. Para la descripción del test, lo generamos en la carpeta macros, bajo el archivo `macros.yml`.
Incluimos una prueba del paquete `dbt_expectations` llamada `expect_column_distinct_count_to_be_greater_than`. Esta prueba verifica si el count de registros es mayor a un valor configurable. En nuestro caso especificamos que sea mayor a 1.

También incorporamos en el archivo `dbt_project.yml` el siguiente fragmento de código:
data_tests:
+store_failures: true

Esto es para que al momento de aplicar los test si alguno falla, se almacene el resultado (la linea que falló) en una tabla para su posterior revisión.

## Parte 5: **Uso de Macros y Paquetes**
   - Crear una macro reutilizable para calcular balances acumulados y aplicar esta macro en los modelos. ##Listo
   - Usar un paquete externo de dbt para generar un hash en las tablas del data mart.

Generamos un macro de nombre `balance_diario`. El mismo recibe una columna y se aplica una suma sobre ella. Aplicamos este macro en intermediate/int_daily_balance
para calcular el balance diario por cuenta.
Utilizando el paquete externo `dbt_utils` generamos un hash en cada tabla del mart utilizando `dbt_utils.generate_surrogate_key`. La columna con hash se llama `hash_column`

## Parte 6: **Definición de Data Contracts**
   - Definir las condiciones de un data contract que asegure la calidad y el formato de los datos que se envían desde las fuentes hasta los modelos analíticos.
   - Esto incluye:
   - Los tipos de datos de los modelos del mart
   - Que los números de cuenta sean los mismos en `fact_transactions` que en `dim_accounts`.
   - Que los ids creados para `dim_accounts` y `fact_transactions` sea una clave primaria en sus respectivas tablas.

Utilizamos data contracts sobre los modelos del Mart teniendo en cuenta los siguientes puntos:
Tipos de Datos = Definimos para cada columna y tabla correspondiente del Mart, el tipo de datos correcto.
Clave Primaria = Definimos para `dim_accounts` y `fact_transactions` las claves primarias.

Para verificar que no tengamos cuentas en `fact_transactions` que no existan en la tabla `dim_accounts`, contemplamos las siguientes alternativas:

- Generar una foreign key sobre `account_id` en `fact_transactions` haciendo referencia al id de cuenta en `dim_accounts`
- Verificar con algún test para evaluar que esta condición se cumpla.

Al momento de crear una FK, nos encontramos con el problema de que no podemos parametrizar el esquema utilizando Jinja `{{ target.schema }}` ya que el mismo al ser ejecutado
no se reemplaza automaticamente con el schema definido para el target.
También hemos probado utilizando el siguiente fragmento de código y si bien no da error, el mismo no aplica ningún cambio a la tabla

        constraints:
          - type: foreign_key
              to: ref('my_other_model')
              to_column: other_my_column

Compartimos enlace a github donde se comenta este problema que detectamos:
`https://github.com/dbt-labs/dbt-core/issues/8062`

Para resolver este punto decidimos aplicar un `data_test` de tipo `relationships` configurado como `Warning`. Con este test verificamos si los `account_id` en
la tabla `fact_transactions` existen. Cuando encontramos un caso donde no exista, estos registros se cargan en esquema dedicado que almacena los resultados de los tests aplicados.

## Parte 7: **Perfiles y Targets**
   - Configurar correctamente los archivos `profiles.yml` y `dbt_project.yml` para definir targets y perfiles según el entorno (dev/prod).
   - Ejecutar los modelos en diferentes entornos y verificar los resultados.

En el archivo `profiles.yml` definimos 2 perfiles distintos para la ejecución. Estos son `dev` y `prod`.
Al ejecutar con perfil `dev`, los datos se encuentran limitados a 500 registros. En el caso de `prod` se carga la totalidad de los datos recibidos.
Modificamos en el archivo `dbt_project.yml` para la sección `profile` y le asignamos `dev` como perfil por defecto.
