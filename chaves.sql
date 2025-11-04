-- 1. ADICIONANDO AS CHAVES PRIMÁRIAS (PKs)
-- (Define o identificador único de cada tabela)

ALTER TABLE olist_customers_dataset 
ADD PRIMARY KEY (customer_id);

ALTER TABLE olist_orders_dataset 
ADD PRIMARY KEY (order_id);

ALTER TABLE olist_products_dataset 
ADD PRIMARY KEY (product_id);

-- Chave primária composta, pois um item só é único dentro de um pedido
ALTER TABLE olist_order_items_dataset 
ADD PRIMARY KEY (order_id, order_item_id);

-- Chave primária composta, pois um pagamento só é único dentro de um pedido
ALTER TABLE olist_order_payments_dataset 
ADD PRIMARY KEY (order_id, payment_sequential);


-- 2. ADICIONANDO AS CHAVES ESTRANGEIRAS (FKs)
-- (Cria as "ligações" ou "relações" entre as tabelas)

-- Liga a tabela de Pedidos (orders) com a de Clientes (customers)
ALTER TABLE olist_orders_dataset 
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id);

-- Liga a tabela de Pagamentos (payments) com a de Pedidos (orders)
ALTER TABLE olist_order_payments_dataset 
ADD CONSTRAINT fk_payments_orders 
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);

-- Liga a tabela de Itens do Pedido (items) com a de Pedidos (orders)
ALTER TABLE olist_order_items_dataset 
ADD CONSTRAINT fk_items_orders 
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);

-- Liga a tabela de Itens do Pedido (items) com a de Produtos (products)
ALTER TABLE olist_order_items_dataset 
ADD CONSTRAINT fk_items_products 
FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id);