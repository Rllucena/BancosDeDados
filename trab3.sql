-- modelagem fisica -> script.sql (Sql (DDL))

DROP DATABASE IF EXISTS Garagem;

CREATE DATABASE Garagem;

\c Garagem;

CREATE TABLE Cliente (
    id serial primary key,
    cpf character(11) unique,
    nome character varying(100) not null,
    email character varying(100) unique,
    senha character varying(100) not null    
    data_nascimento date 
    endereco varchar(150) not null
);

CREATE TABLE Modelo (
    id serial primary key,
    --titulo character varying (150) not null,
    descricao text not null,
    ano_lancamento integer
);

CREATE TABLE Veiculo (
    id serial primary key,
    chassi character varying (100) not null,
    placa character varying (7) not null,
    cor character varying (30) not null,
    ano integer not null,
    Cliente_id integer references Cliente (id),
    Modelo_id integer references Modelo (id),
);

CREATE TABLE andar (
    id serial primary key,
  
);

CREATE TABLE vaga (
    id serial primary key,
    andar_id integer references andar (id)
);

CREATE TABLE vaga_veiculo (
    vaga_id integer references vaga (id),
    veiculo_id integer references Veiculo (id),
    data_hora_entrada timestamp default current_timestamp,
    data_hora_saida timestamp default current_timestamp,
    valor_pago money default 0,
    primary key (vaga_id, Veiculo_id)
);






--1)
Select * from Veiculo id =1

--2)
SELECT * FROM Veiculo where ano => 2000;

--3)
select * from veiculos where Cliente_id=1

--4)   
select * from vaga_veiculo where veiculo_id=1
    
--5)


    
/*/
Um edíficio de garagem coletiva onde:

Cada Cliente tem cpf, nome, data nascimento e endereço (rua, bairro, complemento, número)
Cada Cliente pode ter muitos Veículos. Cada Veículo tem: chassi, placa, cor, ano, um dono (cliente) e é de modelo.
Cada Modelo tem uma descrição e o ano de lançamento
Cada andar tem n vagas. Cada vaga está em um andar específico.
Um veículo pode ocupar diversas vagas ao longo do tempo. E uma mesma vaga poderá ter diversos veículos ao longo do tempo. Durante o período de ocupação de um veículo em uma vaga é preciso armazenar qual veículo que está em uma determinada vaga, data/hora de entrada, data hora de saída e valor pago durante a desocupação
Tarefas:

1-Faça a implementação física (CREATE DATABASE, CREATE TABLE e etc.)
2-Exiba a placa e o ano do veículo de um determinado veículo
3-Exiba a placa, o ano do veículo do veículo, se ele possuir ano a partir de 2000
4-Liste todos os carros do modelo 1
5-Liste todos os estacionamentos de um veículo
6-Quanto tempo um veículo ficou em uma determinada vaga?
7-Quantidade de veículos de um determinado modelo
8-Média de idade dos clientes
9-Se cada hora custa 2 reais, quanto cada veículo pagou? Obs: Somente horas inteiras valem para o cálculo
*\



/*

-- Consultas
-- Exiba a placa e o ano do veículo de um determinado veículo
SELECT placa, ano FROM Veiculo WHERE chassi = '1HGCM82633A123452';


-- Exiba a placa, o ano do veículo do veículo, se ele possuir ano a partir de 2000
SELECT placa, ano FROM Veiculo WHERE ano >= 2000;


-- Liste todos os carros do modelo 1
SELECT * FROM Veiculo WHERE modelo_id = 1;


-- Liste todos os estacionamentos de um veículo
SELECT * FROM Ocupacao WHERE veiculo_chassi = '1HGCM82633A123459';




-- Quanto tempo um veículo ficou em uma determinada vaga?
SELECT TIMESTAMPDIFF(HOUR, data_hora_entrada, data_hora_saida) AS horas_na_vaga FROM Ocupacao WHERE veiculo_chassi = '1HGCM82633A123456' AND vaga_id = id_da_vaga;


-- Quantidade de veículos de um determinado modelo
SELECT COUNT(*) FROM Veiculo WHERE modelo_id = id_do_modelo;


-- Média de idade dos clientes
SELECT AVG(YEAR(CURDATE()) - YEAR(data_nascimento)) AS media_idade FROM Cliente;


-- Se cada hora custa 2 reais, quanto cada veículo pagou? Obs: Somente horas inteiras valem para o cálculo
SELECT veiculo_chassi, SUM(TIMESTAMPDIFF(HOUR, data_hora_entrada, data_hora_saida) * 2) AS total_pago FROM Ocupacao GROUP BY veiculo_chassi;






--1)
Select * from Veiculo id =1

--2)
SELECT * FROM Veiculo where ano => 2000;

--3)
select * from veiculos where Cliente_id=1

--4)   
select * from vaga_veiculo where veiculo_id=1
    
--5)


    
/*
Um edíficio de garagem coletiva onde:

Cada Cliente tem cpf, nome, data nascimento e endereço (rua, bairro, complemento, número)
Cada Cliente pode ter muitos Veículos. Cada Veículo tem: chassi, placa, cor, ano, um dono (cliente) e é de modelo.
Cada Modelo tem uma descrição e o ano de lançamento
Cada andar tem n vagas. Cada vaga está em um andar específico.
Um veículo pode ocupar diversas vagas ao longo do tempo. E uma mesma vaga poderá ter diversos veículos ao longo do tempo. Durante o período de ocupação de um veículo em uma vaga é preciso armazenar qual veículo que está em uma determinada vaga, data/hora de entrada, data hora de saída e valor pago durante a desocupação
Tarefas:

1-Faça a implementação física (CREATE DATABASE, CREATE TABLE e etc.)
2-Exiba a placa e o ano do veículo de um determinado veículo
3-Exiba a placa, o ano do veículo do veículo, se ele possuir ano a partir de 2000
4-Liste todos os carros do modelo 1
5-Liste todos os estacionamentos de um veículo
6-Quanto tempo um veículo ficou em uma determinada vaga?
7-Quantidade de veículos de um determinado modelo
8-Média de idade dos clientes
9-Se cada hora custa 2 reais, quanto cada veículo pagou? Obs: Somente horas inteiras valem para o cálculo
*\


DROP DATABASE IF EXISTS garagem;
CREATE DATABASE garagem;


DROP TABLE IF EXISTS Ocupacao;
DROP TABLE IF EXISTS  Vaga;
DROP TABLE IF EXISTS  Andar;
DROP TABLE IF EXISTS  Modelo;
DROP TABLE IF EXISTS  Veiculo;
DROP TABLE IF EXISTS  Cliente;


CREATE TABLE Cliente (
   cpf VARCHAR(11) PRIMARY KEY,
   nome VARCHAR(100),
   data_nascimento DATE,
   rua VARCHAR(100),
   bairro VARCHAR(100),
   complemento VARCHAR(100),
   numero INT
);


CREATE TABLE Veiculo (
   chassi VARCHAR(17),
   placa VARCHAR(7),
   cor VARCHAR(20),
   ano INT,
   cpf_cliente VARCHAR(11),
   modelo_id INT,
   PRIMARY KEY(chassi, placa),
   FOREIGN KEY (cpf_cliente) REFERENCES Cliente(cpf),
   FOREIGN KEY (modelo_id) REFERENCES Modelo(id)
);


CREATE TABLE Modelo (
   id INT AUTO_INCREMENT PRIMARY KEY,
   descricao VARCHAR(100),
   ano_lancamento INT
);


CREATE TABLE Andar (
   id INT AUTO_INCREMENT PRIMARY KEY,
   num_vagas INT
);


CREATE TABLE Vaga (
   id INT AUTO_INCREMENT PRIMARY KEY,
   andar_id INT,
   FOREIGN KEY (andar_id) REFERENCES Andar(id)
);


CREATE TABLE Ocupacao (
   id INT AUTO_INCREMENT PRIMARY KEY,
   vaga_id INT,
   veiculo_chassi VARCHAR(17),
   data_hora_entrada DATETIME,
   data_hora_saida DATETIME,
   valor_pago DECIMAL(10, 2),
   FOREIGN KEY (vaga_id) REFERENCES Vaga(id),
   FOREIGN KEY (veiculo_chassi) REFERENCES Veiculo(chassi)
);




INSERT INTO Cliente (cpf, nome, data_nascimento, rua, bairro, complemento, numero) VALUES
('12345678901', 'Ana', '01/01/1980', 'Avenida Paulista', 'Bela Vista', 'Apartamento',101),
('23456789012', 'Beatriz', '02/02/1982', 'Rua Oscar Freire', 'Jardins', 'Casa',678),
('34567.90123', 'Carlos',  '03/03/1981', ' Alameda Santos', 'Cerqueira césar', 'Casa',1205),
('45678901234', 'Daniel', '04/04/1983', ' Augusta', 'Consolação', 'Apartamento',703),
('56789012345', 'Eduardo', '05/05/1985', 'Haddock Lobo', 'Jardim Paulista', 'Apartamento',303),
('67890123456', 'Fernanda', '20/06/1996', 'Rua da Consolação', 'Consolação', 'Casa',368),
('78901234567', 'Gabriela', '15/03/1997', 'Teodoro Sampaio', 'Pinheiros', 'Casa',885),
('89012345678', 'Henrique', '01/08/1999', 'Harmonia', 'Vila Madalena', 'Casa',120),
('90123456781', 'Isabela', '27/11/2000', 'Augusta', 'Pinheiros', 'Apartamento',604),
('01234567890', 'João', '17/10/2001', 'Consolação', 'Consolação', 'Casa',742);


INSERT INTO Modelo (descricao, ano_lancamento)
VALUES
('Alfa Romeo', 1998),
('BMW M Coupé and Roadster', 1998),
('Audi A4 Sedan', 2006),
('Toyota Camry', 2007),
('Chevrolet Corvette Convertible', 2007);


INSERT INTO Veiculo (chassi, placa, cor, ano, cpf_cliente, modelo_id)
VALUES
('1HGCM82633A123451', 'ABC1001', 'Preto', 1998, '12345678901', 1),
('1HGCM82633A123452', 'DEF1002', 'Branco', 2007, '23456789012', 5),
('1HGCM82633A123453', 'GHI1003', 'Vermelho', 2006, '34567890123', 3),
('1HGCM82633A123454', 'JKL1004', 'Azul', 2007, '45678901234', 4),
('1HGCM82633A123455', 'MNO1005', 'Verde', 2007, '56789012345', 5),
('1HGCM82633A123456', 'PQR1006', 'Amarelo', 1998, '67890123456', 1),
('1HGCM82633A123457', 'STU1007', 'Cinza', 1998, '78901234567', 2),
('1HGCM82633A123458', 'VWX1008', 'Marrom', 1998, '89012345678', 2),
('1HGCM82633A123459', 'YZA1009', 'Roxo', 2006, '90123456781', 3),
('1HGCM82633A123460', 'BCD1010', 'Rosa', 1998, '01234567890', 1);


INSERT INTO Ocupacao (vaga_id, veiculo_chassi, data_hora_entrada, data_hora_saida, valor_pago)
VALUES
(1, '1HGCM82633A123451', '2023-01-01 07:00:00', '2023-01-01 10:00:00', 20.00),
(2, '1HGCM82633A123452', '2023-01-02 09:00:00', '2023-01-02 11:00:00', 20.00),
(3, '1HGCM82633A123453', '2023-01-03 12:00:00', '2023-01-04 12:00:00', 20.00),
(4, '1HGCM82633A123454', '2023-01-04 07:00:00', '2023-01-04 13:00:00', 20.00),
(5, '1HGCM82633A123455', '2023-01-05 12:00:00', '2023-01-05 14:00:00', 20.00),
(6, '1HGCM82633A123456', '2023-01-06 13:00:00', '2023-01-06 15:00:00', 20.00),
(7, '1HGCM82633A123457', '2023-01-07 14:00:00', '2023-01-07 16:00:00', 20.00),
(8, '1HGCM82633A123458', '2023-01-08 15:00:00', '2023-01-08 17:00:00', 20.00),
(9, '1HGCM82633A123459', '2023-01-09 16:00:00', '2023-01-09 18:00:00', 20.00),
(10, '1HGCM82633A123460', '2023-01-10 17:00:00', '2023-01-10 19:00:00', 20.00);


INSERT INTO Andar (num_vagas)
VALUES
(20), (20), (20);


INSERT INTO Vaga (andar_id)
VALUES
(1), (1), (1), (1), (1),(1), (1), (1), (1), (1),
(1), (1), (1), (1), (1),(1), (1), (1), (1), (1),
(2), (2), (2), (2), (2),(2), (2), (2), (2), (2),
(2), (2), (2), (2), (2),(2), (2), (2), (2), (2),
(3), (3), (3), (3), (3),(3), (3), (3), (3), (3),
(3), (3), (3), (3), (3),(3), (3), (3), (3), (3);










-- Consultas
-- Exiba a placa e o ano do veículo de um determinado veículo
SELECT placa, ano FROM Veiculo WHERE chassi = '1HGCM82633A123452';


-- Exiba a placa, o ano do veículo do veículo, se ele possuir ano a partir de 2000
SELECT placa, ano FROM Veiculo WHERE ano >= 2000;


-- Liste todos os carros do modelo 1
SELECT * FROM Veiculo WHERE modelo_id = 1;


-- Liste todos os estacionamentos de um veículo
SELECT * FROM Ocupacao WHERE veiculo_chassi = '1HGCM82633A123459';




-- Quanto tempo um veículo ficou em uma determinada vaga?
SELECT TIMESTAMPDIFF(HOUR, data_hora_entrada, data_hora_saida) AS horas_na_vaga FROM Ocupacao WHERE veiculo_chassi = '1HGCM82633A123456' AND vaga_id = id_da_vaga;


-- Quantidade de veículos de um determinado modelo
SELECT COUNT(*) FROM Veiculo WHERE modelo_id = id_do_modelo;


-- Média de idade dos clientes
SELECT AVG(YEAR(CURDATE()) - YEAR(data_nascimento)) AS media_idade FROM Cliente;


-- Se cada hora custa 2 reais, quanto cada veículo pagou? Obs: Somente horas inteiras valem para o cálculo
SELECT veiculo_chassi, SUM(TIMESTAMPDIFF(HOUR, data_hora_entrada, data_hora_saida) * 2) AS total_pago FROM Ocupacao GROUP BY veiculo_chassi;
