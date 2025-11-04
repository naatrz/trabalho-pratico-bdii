-- Automatizando chaves primárias

ALTER TABLE olist_customers_dataset 
ADD PRIMARY KEY (customer_id);

ALTER TABLE olist_orders_dataset 
ADD PRIMARY KEY (order_id);

ALTER TABLE olist_products_dataset 
ADD PRIMARY KEY (product_id);

-- Chave primária composta*
ALTER TABLE olist_order_items_dataset 
ADD PRIMARY KEY (order_id, order_item_id);

-- Chave primária composta*
ALTER TABLE olist_order_payments_dataset 
ADD PRIMARY KEY (order_id, payment_sequential);


-- Automatizando chaves estrangeira

ALTER TABLE olist_orders_dataset 
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id) REFERENCES olist_customers_dataset(customer_id);

-- Pagamentos -> Pedidos
ALTER TABLE olist_order_payments_dataset 
ADD CONSTRAINT fk_payments_orders 
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);

-- Itens do Pedido -> Pedidos
ALTER TABLE olist_order_items_dataset 
ADD CONSTRAINT fk_items_orders 
FOREIGN KEY (order_id) REFERENCES olist_orders_dataset(order_id);

-- Itens do Pedido -> Produtos
ALTER TABLE olist_order_items_dataset 
ADD CONSTRAINT fk_items_products 
FOREIGN KEY (product_id) REFERENCES olist_products_dataset(product_id);