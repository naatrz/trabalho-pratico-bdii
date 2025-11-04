CREATE TABLE olist.olist_orders_dataset (
	order_id VARCHAR(50) NULL,
	customer_id VARCHAR(50) NULL,
	order_status VARCHAR(50) NULL,
	order_purchase_timestamp VARCHAR(50) NULL,
	order_approved_at VARCHAR(50) NULL,
	order_delivered_carrier_date VARCHAR(50) NULL,
	order_delivered_customer_date VARCHAR(50) NULL,
	order_estimated_delivery_date VARCHAR(50) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;

CREATE TABLE olist.olist_order_items_dataset (
	order_id VARCHAR(50) NULL,
	order_item_id INTEGER NULL,
	product_id VARCHAR(50) NULL,
	seller_id VARCHAR(50) NULL,
	shipping_limit_date VARCHAR(50) NULL,
	price REAL NULL,
	freight_value REAL NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;

CREATE TABLE olist.olist_products_dataset (
	product_id VARCHAR(50) NULL,
	product_category_name VARCHAR(50) NULL,
	product_name_lenght INTEGER NULL,
	product_description_lenght INTEGER NULL,
	product_photos_qty INTEGER NULL,
	product_weight_g INTEGER NULL,
	product_length_cm INTEGER NULL,
	product_height_cm INTEGER NULL,
	product_width_cm INTEGER NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;

CREATE TABLE olist.olist_customers_dataset (
	customer_id VARCHAR(50) NULL,
	customer_unique_id VARCHAR(50) NULL,
	customer_zip_code_prefix INTEGER NULL,
	customer_city VARCHAR(50) NULL,
	customer_state VARCHAR(50) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;

CREATE TABLE olist.olist_order_payments_dataset (
	order_id VARCHAR(50) NULL,
	payment_sequential INTEGER NULL,
	payment_type VARCHAR(50) NULL,
	payment_installments INTEGER NULL,
	payment_value REAL NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_general_ci;
