-- Questão 04 - Automação de relatório (Stored Procedure)

-- Criando o Storage Procedure
CREATE PROCEDURE sp_relatorio_vendas_por_categoria(
    IN data_inicio DATE,         -- Parâmetro 1: data de início
    IN categoria_produto VARCHAR(100) -- Parâmetro 2: nome da categoria
)
BEGIN
    -- SELECT para gerar o relatório
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-%d') AS dia,
        p.product_category_name AS categoria,
        COUNT(DISTINCT o.order_id) AS total_pedidos,
        SUM(pay.payment_value) AS receita_total
    FROM 
        olist_orders_dataset AS o
        JOIN olist_order_items_dataset AS oi ON o.order_id = oi.order_id
        JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
        JOIN olist_order_payments_dataset AS pay ON o.order_id = pay.order_id
    WHERE
        -- Filtros:
        -- Filtro 1: A data da compra deve ser MAIOR ou IGUAL à data de início
        o.order_purchase_timestamp >= data_inicio
        
        -- Filtro 2: A categoria do produto deve ser IGUAL à categoria passada
        AND p.product_category_name = categoria_produto
        
        -- Apenas pedidos entregues
        AND o.order_status = 'delivered'
    GROUP BY
        dia, categoria
    ORDER BY
        dia ASC;

END;

-- Teste 1
CALL sp_relatorio_vendas_por_categoria('2018-01-01', 'cama_mesa_banho');

--  Teste 2
CALL sp_relatorio_vendas_por_categoria('2017-06-01', 'beleza_saude');