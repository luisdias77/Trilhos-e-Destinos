-- ATENÇÃO: este ficheiro contém comandos DELETE ativos (por exemplo, remover a viagem 10
-- e a reserva do cliente 5). Não o executes de uma só vez: corre cada bloco individualmente.

-- ===========================
-- INTERROGAÇÕES E CONSULTAS
-- ===========================

USE TrilhosDestinos;

-- RM1 - O funcionário deve poder gerir (adicionar, editar, remover) as viagens disponíveis na plataforma.
-- Inserção de uma viagem
INSERT INTO Viagem (Data_inicio, Data_fim, Duracao, Descricao, País, Cidade, Continente, Funcionario_Id_funcionario) 
VALUES ('2026-02-10', '2026-02-20', 10, 'Carnaval do Rio', 'Brasil', 'Rio de Janeiro', 'América', 1);

-- Atualização da descrição e da duração da viagem com ID 10
UPDATE Viagem
SET Descricao = 'Kandersteg - Com amigos', Duracao = 6
WHERE Id_viagem = 10;

-- Remover a viagem com ID 10 do sistema
-- Como a viagem com Id=10 está presente em várias tabelas, como Conteudo, Comentario e Reserva, para remover a viagem com este Id,
-- tenho de a remover primeiro destas tabelas e só depois no fim, eliminar diretamente na tabela viagem.
--   DELETE FROM Viagem
--   WHERE Id_viagem = 10;

DELETE FROM Conteudo
WHERE Viagem_Id_viagem = 10;

DELETE FROM Comentario
WHERE Viagem_Id_viagem = 10;

DELETE FROM Reserva
WHERE Viagem_Id_viagem = 10;

DELETE FROM Viagem
WHERE Id_viagem = 10;

-- RM6 - O cliente deve poder pesquisar viagens por continente, país e/ou cidade
SELECT País, Cidade, Duracao, Descricao 
FROM Viagem
WHERE Continente = 'Europa';

-- RM4 - O funcionário deve poder ler e responder a comentários de clientes
SELECT Com.Id_comentario, Clt.Nome, Com.Texto
FROM Comentario Com
INNER JOIN Cliente Clt ON Com.Cliente_id_cliente = Clt.id_cliente
WHERE Com.Viagem_Id_viagem = 10;

-- RM11: os funcionários devem ser capazes de adicionar conteúdo, como fotos, vídeos e descrição dos locais turísticos.
-- Adicionar um vídeo à viagem com ID 20
INSERT INTO Conteudo 
(Data, Tipo, Duração, Viagem_Id_viagem) 
VALUES (CURRENT_DATE(), 'VIDEO', 120, 20);

DELETE FROM Conteudo
WHERE Id_conteudo = 9;
 
-- RM12 : o sistema deve permitir registar a compra de uma viagem por parte de um cliente, verificando a disponibilidade da mesma
-- Registar uma reserva para o Cliente 5 na Viagem 10
INSERT INTO Reserva 
(data_reserva, Preco_final, nr_pessoas, Cliente_id_cliente, Viagem_Id_viagem) 
VALUES (NOW(), 600.25 * 5, 5, 5, 10);

DELETE FROM Reserva
WHERE Cliente_id_cliente = 5;

