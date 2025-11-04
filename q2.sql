-- Questão 02 - View que monitora os atrasos e aplica a priorização

-- Criação da View Gerencial
CREATE VIEW vw_monitor_pedidos_atrasados AS
SELECT
    o.order_id,
    c.customer_city,
    c.customer_state,
    o.order_purchase_timestamp AS data_compra,
    o.order_estimated_delivery_date AS data_estimada,
    o.order_delivered_customer_date AS data_entrega,
    
    -- Cálculo para saber quantos dias o pedido atrasou
    -- O DATEDIFF calcula a diferença em dias
    DATEDIFF(
        o.order_delivered_customer_date, 
        o.order_estimated_delivery_date
    ) AS dias_de_atraso,
    
    -- Criando o Score de Prioridade
    -- O CASE WHEN define a prioridade baseada nos dias de atraso
    CASE
        WHEN DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) >= 15
            THEN '1 - Urgente (15+ dias)' -- Prioridade 1 (Mais grave)
        WHEN DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) >= 7
            THEN '2 - Alta (7-14 dias)' -- Prioridade 2 (Média)
        ELSE
            '3 - Média (1-6 dias)' -- Prioridade 3 (Menos grave)
    END AS nivel_prioridade
    
FROM
    olist_orders_dataset AS o
    JOIN olist_customers_dataset AS c ON o.customer_id = c.customer_id
WHERE
    -- Aplicação da regra de negócio:
    -- 1. O pedido precisa estar "entregue"
    o.order_status = 'delivered'
    -- 2. A data de entrega verdadeira aconteceu depois da data estimada
    AND o.order_delivered_customer_date > o.order_estimated_delivery_date;

-- Teste
SELECT * FROM vw_monitor_pedidos_atrasados
ORDER BY dias_de_atraso DESC
LIMIT 100; -- Limita a 100 para ver os maiores atrasos