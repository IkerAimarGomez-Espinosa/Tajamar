# Implement programmability objects with SQL

## Connect to AdventureWorksLT

Conexión a la base de datos AdventureWorksLT y verificación de las tablas clave: se consultan los 5 primeros registros de Customer, SalesOrderHeader y Product para comprobar el acceso a los datos de clientes, pedidos y productos.

![Verificación de tablas clave en AdventureWorksLT](./img/Connect_to_AdventureWorksLT.png)

## Create a view to simplify queries

Creación de la vista SalesLT.vCustomerOrders, que combina las tablas Customer y SalesOrderHeader mediante un INNER JOIN para mostrar el nombre completo del cliente (CONCAT de FirstName y LastName) junto con el identificador y la fecha de cada pedido. La vista se creó correctamente.

![Creación de la vista vCustomerOrders](./img/Create_a_view_to_simplify_queries.png)

Consulta de los 5 pedidos más recientes a través de la vista vCustomerOrders, ordenados por fecha descendente. El resultado muestra el CustomerID, el nombre del cliente, el SalesOrderID y la fecha del pedido.

![Consulta de los pedidos más recientes mediante vCustomerOrders](./img/Validar_Create_a_view_to_simplify_queries.png)

## Create a stored procedure to process an order

Creación del procedimiento almacenado dbo.AddOrderLineItem, que recibe un SalesOrderID, un ProductID y una cantidad, obtiene el precio del producto, valida que el ProductID y el SalesOrderID existan (con ROLLBACK y THROW en caso de error), inserta la línea de pedido en SalesOrderDetail y actualiza el subtotal de la cabecera del pedido dentro de una transacción. Se creó correctamente.

![Creación del procedimiento almacenado AddOrderLineItem](./img/Create_a_stored_procedure_to_process_an_order.png)

Ejecución del procedimiento AddOrderLineItem sobre un pedido existente, añadiendo una unidad del producto 680. La consulta posterior muestra la nueva línea insertada en SalesOrderDetail y el subtotal, impuestos, envío y total actualizados en SalesOrderHeader.

![Ejecución de AddOrderLineItem y verificación del pedido actualizado](./img/Validar_Create_a_stored_procedure_to_process_an_order.png)

## Create a scalar function for reusable calculations

Creación de la función escalar dbo.fnOrderTotal, que recibe un OrderID y devuelve la suma de LineTotal de sus líneas de detalle (con ISNULL para devolver 0 si no hay líneas). Se creó correctamente.

![Creación de la función escalar fnOrderTotal](./img/Create_a_scalar_function_for_reusable_calculations.png)

Consulta que calcula el total de cada pedido mediante fnOrderTotal, agrupando por SalesOrderID y ordenando de mayor a menor. El resultado muestra el importe total (OrderTotal) de cada uno de los pedidos.

![Cálculo del total de cada pedido con fnOrderTotal](./img/Validar_Create_a_scalar_function_for_reusable_calculations.png)

## Create an inline table-valued function (TVF)

Creación de la función de tabla en línea dbo.GetCustomerOrders, que recibe un CustomerID y devuelve el SalesOrderID y la fecha de todos los pedidos de ese cliente. Se creó correctamente.

![Creación de la función de tabla en línea GetCustomerOrders](./img/Create_an_inline_table-valued_function_(TVF).png)

Consulta de los pedidos del cliente 29929 mediante la función GetCustomerOrders, ordenados por fecha descendente. El resultado muestra un pedido (71902) con su fecha correspondiente.

![Consulta de pedidos del cliente 29929 con GetCustomerOrders](./img/Validar_Create_an_inline_table-valued_function_(TVF).png)

Consulta con CROSS APPLY que combina la tabla Customer con la función GetCustomerOrders para mostrar, en una sola fila, el nombre completo del cliente 29929 (Jeffrey Kurtz) junto con su pedido y fecha.

![Consulta con CROSS APPLY combinando Customer y GetCustomerOrders](./img/Concat_Create_an_inline_table-valued_function_(TVF).png)

## Create a trigger to log changes

Creación de la tabla dbo.OrderAudit (si no existe) para registrar el historial de cambios en los totales de los pedidos, y del trigger SalesLT.trg_LogOrderTotalChange sobre SalesOrderDetail, que se dispara tras INSERT o UPDATE. El trigger calcula el total anterior y el nuevo total de cada pedido afectado (combinando las filas inserted y deleted) y registra ambos valores en OrderAudit. Se creó correctamente.

![Creación de la tabla OrderAudit y el trigger trg_LogOrderTotalChange](./img/Create_a_trigger_to_log_changes.png)

Actualización de una línea de detalle (incremento de OrderQty) del pedido más reciente, lo que dispara el trigger. La consulta a OrderAudit muestra el registro generado, con el OrderID, el total anterior (OldTotal), el nuevo total (NewTotal) y la fecha del cambio.

![Verificación del trigger mediante consulta a OrderAudit](./img/Validar_Create_a_trigger_to_log_changes.png)
