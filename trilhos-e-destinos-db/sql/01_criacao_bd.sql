/*
Universidade do Minho
Unidade Curricular de Base de Dados
Caso de estudo: Trilhos e Destinos

Script para a criação do esquema físico para a empresa de viagens "Trilhos e Destinos"
*/

-- Apagar a Base de Dados 
-- DROP DATABASE IF EXISTS TrilhosDestinos;

-- Criação da Base de Dados
CREATE DATABASE IF NOT EXISTS TrilhosDestinos;

-- Indicação da base de dados de trabalho que vai ser usada 
USE TrilhosDestinos; 

-- Criação das tabelas da base de dados TrilhosDestinos 

-- Criação da tabela Cliente 

CREATE TABLE Cliente(
	id_cliente INT NOT NULL AUTO_INCREMENT,
    NIF INT NOT NULL UNIQUE,
    Nome VARCHAR(35) NOT NULL,
    Email VARCHAR(40) NOT NULL UNIQUE,
    Username VARCHAR(12) NOT NULL UNIQUE,
    Password VARCHAR(10) NOT NULL UNIQUE,
    Nºtelemóvel INT NOT NULL,
    Data_nascimento VARCHAR(45) NULL,
    Rua VARCHAR(45) NOT NULL,
    Localidade VARCHAR(45) NOT NULL,
    CP VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_cliente)
);

-- Criação da tabela Função
CREATE TABLE Funcao (
	Id_função INT NOT NULL AUTO_INCREMENT,
	Encargo VARCHAR(25) NOT NULL,
	PRIMARY KEY (Id_função)
);

-- CRIAÇÃO DAS TABELAS COM DEPENDÊNCIA

-- Criação da tabela Funcionario, que depende de Função 
CREATE TABLE Funcionario (
    Id_funcionario INT NOT NULL AUTO_INCREMENT,
    Nome_completo VARCHAR(50) NOT NULL,
    Email VARCHAR(40) NOT NULL UNIQUE,
    Rua VARCHAR(45) NOT NULL,
    Localidade VARCHAR(45) NOT NULL,
    CP VARCHAR(10) NOT NULL,
    Função_Id_função INT NOT NULL,
    PRIMARY KEY (Id_funcionario),
    FOREIGN KEY (Função_Id_função) REFERENCES Funcao(Id_função)
);

-- Criação da tabela Telemovel_Funcionário, para representar o atributo Nº Telemóvel associado a um funcionário, atributo este que é multivalorado
-- Depende de Funcionário
CREATE TABLE Telemovel_Funcionario (
    Numero INT NOT NULL,
    Funcionário_Id_funcionário INT NOT NULL,
    PRIMARY KEY (Numero, Funcionário_Id_funcionário),
    FOREIGN KEY (Funcionário_Id_funcionário) REFERENCES Funcionario(Id_funcionario)
);

-- Criação da tabela Viagem, que depende de Funcionario 
CREATE TABLE Viagem (
    Id_viagem INT NOT NULL AUTO_INCREMENT,
    Funcionario_Id_funcionario INT NOT NULL, 
    Data_inicio DATE NOT NULL,
    Data_fim DATE NOT NULL,
    Duracao INT NOT NULL,
    Descricao VARCHAR(100) NOT NULL,
    País VARCHAR(50) NOT NULL,
    Cidade VARCHAR(50) NOT NULL,
    Continente VARCHAR(50) NOT NULL,
    PRIMARY KEY (Id_viagem),
    FOREIGN KEY (Funcionario_Id_funcionario) REFERENCES Funcionario(Id_funcionario)
);

-- Criação da tabela Comentario que depende de Cliente e Viagem
CREATE TABLE Comentario (
    Id_comentario INT NOT NULL AUTO_INCREMENT,
    Cliente_Id_cliente INT NOT NULL, 
    Viagem_Id_viagem INT NOT NULL, 
    Avaliacao INT NOT NULL,
    Texto VARCHAR(150) NOT NULL,
    Data_publicacao DATE NOT NULL,
    PRIMARY KEY (Id_comentario),
    FOREIGN KEY (Cliente_Id_cliente) REFERENCES Cliente(Id_cliente),
    FOREIGN KEY (Viagem_Id_viagem) REFERENCES Viagem(Id_viagem)
);

-- Criação da tabela Conteudo, que depende de Viagem
CREATE TABLE Conteudo (
    Id_Conteudo INT NOT NULL AUTO_INCREMENT,
    Data DATE NOT NULL,
    Tipo ENUM('Foto', 'Video', '3D') NULL,
    Duração INT NULL,
    Viagem_Id_viagem INT NOT NULL, 
    PRIMARY KEY (Id_Conteudo),
    FOREIGN KEY (Viagem_Id_viagem) REFERENCES Viagem(Id_viagem) 
);


-- Criação da tabela Reserva, uma entidade associativa
CREATE TABLE Reserva (
    Cliente_Id_cliente INT NOT NULL,
    Viagem_Id_viagem INT NOT NULL,
    Data_reserva DATETIME NOT NULL,
    Preco_final DECIMAL(10, 2) NOT NULL,
    Nr_pessoas INT NOT NULL, 
    PRIMARY KEY (Cliente_Id_cliente, Viagem_Id_viagem), 
    FOREIGN KEY (Cliente_Id_cliente) REFERENCES Cliente(Id_cliente),
    FOREIGN KEY (Viagem_Id_viagem) REFERENCES Viagem(Id_viagem)
);


-- ==========================================
-- 5.2 CRIAÇÃO DE UTILIZADORES E PERMISSÕES
-- ==========================================

-- 1. Criação dos papéis (roles)

-- DROP ROLE IF EXISTS 'cliente'
-- DROP ROLE IF EXISTS 'funcionario'
-- DROP ROLE IF EXISTS 'gerente'

CREATE ROLE IF NOT EXISTS 'cliente';
CREATE ROLE IF NOT EXISTS 'funcionario';
CREATE ROLE IF NOT EXISTS 'gerente';

-- 2. Atribuição de Permissões aos Papéis

-- Perfil Cliente (RC1): Pode ver viagens e criar reservas/comentários
GRANT SELECT ON TrilhosDestinos.Viagem TO 'cliente';
GRANT SELECT ON TrilhosDestinos.Conteudo TO 'cliente';
GRANT INSERT, SELECT, UPDATE ON TrilhosDestinos.Comentario TO 'cliente';
GRANT INSERT, SELECT ON TrilhosDestinos.Reserva TO 'cliente';

-- Perfil Funcionário (RC3): Gere conteúdos e viagens
GRANT SELECT, INSERT, UPDATE, DELETE ON TrilhosDestinos.Conteudo TO 'funcionario';
GRANT SELECT, INSERT, UPDATE, DELETE ON TrilhosDestinos.Viagem TO 'funcionario';
GRANT SELECT, INSERT ON TrilhosDestinos.Comentario TO 'funcionario';
GRANT SELECT ON TrilhosDestinos.Cliente TO 'funcionario'; 

-- Perfil Gerente (RC4): Acesso administrativo total
GRANT ALL PRIVILEGES ON TrilhosDestinos.* TO 'gerente';

-- 3. Criação de Utilizadores (Exemplos)
-- NOTA: os utilizadores e passwords abaixo são apenas de demonstração (projeto académico).

DROP USER IF EXISTS 'rui_silva'@'localhost';
DROP USER IF EXISTS 'pedro_staff'@'localhost';
DROP USER IF EXISTS 'manuel_admin'@'localhost';

-- Cliente
CREATE USER 'rui_silva'@'localhost' IDENTIFIED BY 'Rui_ss324';
-- Funcionário (Pedro Fernandes)
CREATE USER 'pedro_staff'@'localhost' IDENTIFIED BY 'pedro321';
-- Gerente (Manuel Gonçalves - Fundador)
CREATE USER 'manuel_admin'@'localhost' IDENTIFIED BY 'nel456';

-- 4. Associação dos Utilizadores aos Papéis

GRANT 'cliente' TO 'rui_silva'@'localhost';
GRANT 'funcionario' TO 'pedro_staff'@'localhost';
GRANT 'gerente' TO 'manuel_admin'@'localhost';

-- Atualizar privilégios
FLUSH PRIVILEGES;




