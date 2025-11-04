-- Questão 01 - Panorama temporal e ranking (Funções de Janela)

-- Usando uma CTE (Common Table Expression) para organizar a consulta
-- Preparando os dados base: vendas por categoria por mês)
WITH vendas_por_mes_categoria AS (
    SELECT
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS ano_mes,
        p.product_category_name AS categoria,
        SUM(pay.payment_value) AS receita_total_mes
    FROM
        olist_orders_dataset AS o
        JOIN olist_order_items_dataset AS oi ON o.order_id = oi.order_id
        JOIN olist_products_dataset AS p ON oi.product_id = p.product_id
        JOIN olist_order_payments_dataset AS pay ON o.order_id = pay.order_id
    WHERE
        o.order_status = 'delivered'
        AND p.product_category_name IS NOT NULL -- Ignora categorias nulas
    GROUP BY
        ano_mes, categoria
),

-- Aplicando as Funções de Janela sobre os dados anteriores
ranking_com_janela AS (
    SELECT
        ano_mes,
        categoria,
        receita_total_mes,

        -- FUNÇÃO DE JANELA 1 (Ranking):
        -- Ranking de receita "particionado" (reiniciado) para cada mês
        DENSE_RANK() OVER (
            PARTITION BY ano_mes 
            ORDER BY receita_total_mes DESC
        ) AS ranking_no_mes,
        
        -- FUNÇÃO DE JANELA 2 (Tendência/Acumulado):
        -- Soma a receita da categoria "particionada" por categoria,
        -- acumulando ao longo dos meses (ORDER BY ano_mes)
        SUM(receita_total_mes) OVER (
            PARTITION BY categoria 
            ORDER BY ano_mes
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS receita_acumulada_categoria

    FROM
        vendas_por_mes_categoria
)

-- Filtro para mostrar apenas o "Top 3" de cada mês
SELECT *
FROM
    ranking_com_janela
WHERE
    ranking_no_mes <= 3 -- Filtra pelo ranking
ORDER BY
    ano_mes DESC, -- Mostra os meses mais recentes primeiro
    ranking_no_mes ASC