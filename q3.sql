-- Questão Q3 - Garantia de regra de negócio (Trigger)

-- Criando o trigger
CREATE TRIGGER trg_garante_preco_valido
BEFORE UPDATE ON olist_order_items_dataset
FOR EACH ROW
BEGIN
    -- 'NEW' é o valor novo, 'OLD' é o valor antigo
    IF NEW.price <= 0 THEN -- Se o calor for menor que 0, então:
    
        -- Registro da tentativa de violação na tabela de log
        INSERT INTO tabela_log_auditoria 
            (usuario_db, operacao_tipo, tabela_afetada, identificacao_problema)
        VALUES 
            (USER(), 
             'UPDATE (Revertido)', 
             'olist_order_items_dataset',
             CONCAT('Tentativa de atualizar o preco para valor invalido (', NEW.price, ') no order_id: ', NEW.order_id, '. Acao foi revertida.')
            );
            
        -- Desfaz a mudança
        -- O update vai acontecer, mas o valor do preço não será alterado
        SET NEW.price = OLD.price; -- Faz com que o preço volte para o valor anterior, então cancela a mudança
        
    END IF;
END;

-- Teste de alteração de valor
UPDATE olist_order_items_dataset
SET price = -50.00
WHERE order_id = '00010242fe8c5a6d1ba2dd792cb16214' 
  AND product_id = '4244733e06e7ecb4970a6e2683c13e61';

-- Visualizando a tabela de logs
SELECT * FROM tabela_log_auditoria;

-- Visualizando que o valor realmente voltou para o anterior
SELECT price 
FROM olist_order_items_dataset 
WHERE 
    order_id = '00010242fe8c5a6d1ba2dd792cb16214' 
    AND product_id = '4244733e06e7ecb4970a6e2683c13e61';
