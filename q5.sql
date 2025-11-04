-- Questão 05 - Views para diferentes perfis

-- View Gerencial
CREATE VIEW vw_painel_vendas_gerencial AS
SELECT
    -- Extrai o ano e mês da data da compra para agrupar
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS ano_mes,
    
    -- Soma o valor dos pagamentos para ter a receita total
    SUM(p.payment_value) AS receita_total,
    
    -- Conta quantos pedidos únicos existem
    COUNT(DISTINCT o.order_id) AS total_pedidos,
    
    -- Calcula o "Ticket Médio" (Receita/Pedidos)
    SUM(p.payment_value) / COUNT(DISTINCT o.order_id) AS ticket_medio
    
FROM
    olist_orders_dataset AS o
    -- Junta com pagamentos para pegar os valores
    JOIN olist_order_payments_dataset AS p ON o.order_id = p.order_id
WHERE
    -- Considera apenas pedidos que foram realmente entregues
    o.order_status = 'delivered'
GROUP BY
    -- Agrupa os resultados por mês
    ano_mes
ORDER BY
    -- Ordena do mais recente para o mais antigo
    ano_mes DESC;

-- Teste
SELECT * FROM vw_painel_vendas_gerencial LIMIT 10;


-- View Analítica
CREATE VIEW vw_painel_vendas_detalhadas AS
SELECT
    o.order_id,
    o.order_purchase_timestamp AS data_venda,
    c.customer_city AS cliente_cidade,
    c.customer_state AS cliente_estado,
    p.product_category_name AS categoria_produto,
    oi.order_item_id AS item_numero, -- Se é o 1º, 2º, etc. item do pedido
    oi.price AS valor_item,
    oi.freight_value AS valor_frete
FROM
    olist_orders_dataset AS o
    -- Realiza o JOIN com clientes para pegar dados de localização
    JOIN olist_customers_dataset AS c ON o.customer_id = c.customer_id
    -- Realiza o JOIN com itens do pedido para saber o que foi vendido
    JOIN olist_order_items_dataset AS oi ON o.order_id = oi.order_id
    -- Realiza o JOIN com produtos para pegar a categoria
    JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
WHERE
    o.order_status = 'delivered'; -- Condição de que foi entregue

-- Teste
SELECT * FROM vw_painel_vendas_detalhadas LIMIT 10;