# Atividade_aula_11_Data-Base

-- 1. Seu gerente solicitou que toda vez que um produto tiver sua quantidade atualizada , essa alteração sejaregistrada na tabela log_estoque , para manter um histórico.

  -- 1.1. .Crie uma trigger AFTER UPDATE na tabela produtos que:
  
  	-- Identifique quando a coluna quantidade for alterada.
  	-- Grave um registro na tabela log_estoque com:
  	-- id_produto : o ID do produto
  	-- quantidade_antiga : valor da quantidade antes da alteração
  	-- quantidade_nova : valor após a alteração 
  	-- data_alteracao : data e hora da alteração 

   -- 2. Crie uma Function que receba como parâmetro o id de um produto e retorne a quantidade atual em estoque
   

   -- 3 Crie uma Procedure chamada atualiza_quantidade que:
   
	-- Receba como parâmetros: o id do produto e o novo valor da quantidade.
	-- Atualize o campo quantidade na tabela produtos.
	-- Requisitos:
		-- Nome da procedure: atualiza_quantidade
		-- Parâmetros: p_id INT, p_nova_quantidade INT.
		-- Deve fazer um UPDATE na tabela produtos.
		-- Após o UPDATE, retorne uma mensagem com SELECT 'Produto atualizado com sucesso'
