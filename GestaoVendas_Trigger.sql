use gestao_vendas;

-- 1. Seu gerente solicitou que toda vez que um produto tiver sua quantidade atualizada , essa alteração sejaregistrada na tabela log_estoque , para manter um histórico.
CREATE TABLE log_estoque (
log_id INT PRIMARY KEY auto_increment,
produto_id INT,
quantidade_antiga INT,
quantidade_nova INT,
data_alteracao datetime,
FOREIGN KEY ( produto_id ) REFERENCES Produto(produto_id)
);

-- 1.1. .Crie uma trigger AFTER UPDATE na tabela produtos que:
	-- Identifique quando a coluna quantidade for alterada.
	-- Grave um registro na tabela log_estoque com:
	-- id_produto : o ID do produto
	-- quantidade_antiga : valor da quantidade antes da alteração
	-- quantidade_nova : valor após a alteração 
	-- data_alteracao : data e hora da alteração 
DELIMITER $$
CREATE TRIGGER trg_log_estoque
AFTER UPDATE ON Produto
FOR EACH ROW
BEGIN
    IF OLD.estoque <> NEW.estoque THEN
        INSERT INTO log_estoque (produto_id,quantidade_antiga,quantidade_nova,data_alteracao)
        VALUES (NEW.produto_id,OLD.estoque,NEW.estoque,NOW());
    END IF;
END$$
DELIMITER ;

-- 2. Crie uma Function que receba como parâmetro o id de um produto e retorne a quantidade atual em estoque
DELIMITER $$
CREATE FUNCTION get_quantidade_produto(p_id INT)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE valor_quantidade INT;

    SELECT estoque INTO valor_quantidade FROM Produto WHERE produto_id = p_id;

    RETURN valor_quantidade;
END$$
DELIMITER ;

SELECT get_quantidade_produto(2) AS estoque_atual;

-- 3 Crie uma Procedure chamada atualiza_quantidade que:
	-- Receba como parâmetros: o id do produto e o novo valor da quantidade.
	-- Atualize o campo quantidade na tabela produtos.
	-- Requisitos:
		-- Nome da procedure: atualiza_quantidade
		-- Parâmetros: p_id INT, p_nova_quantidade INT.
		-- Deve fazer um UPDATE na tabela produtos.
		-- Após o UPDATE, retorne uma mensagem com SELECT 'Produto atualizado com sucesso';
DELIMITER $$
CREATE PROCEDURE atualiza_quantidade(IN p_id INT,IN p_nova_quantidade INT)
BEGIN
    UPDATE Produto SET estoque = p_nova_quantidade WHERE produto_id = p_id;

    SELECT 'Produto atualizado com sucesso' AS mensagem;
END$$
DELIMITER ;

CALL atualiza_quantidade(5, 19);

select*from log_estoque;
