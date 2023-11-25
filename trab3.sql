-- modelagem fisica -> script.sql (Sql (DDL))

DROP DATABASE IF EXISTS Garagem;

CREATE DATABASE Garagem;

--\c Garagem;

CREATE TABLE Cliente (
    id serial primary key,
    cpf character(11) unique,
    nome character varying(100) not null,
    email character varying(100) unique,
    senha character varying(100) not null,    
    data_nascimento date NOT NULL, 
    rua VARCHAR(100),
    bairro VARCHAR(100),
    complemento VARCHAR(100),
    numero INT
);

CREATE TABLE Modelo (
    id serial primary key,
    --titulo character varying (150) not null,
    descricao text not null,
    ano_lancamento integer NOT NULL
);

CREATE TABLE Veiculo (
    id serial primary key,
    chassi character varying (100) not null,
    placa character varying (10) not null,
    cor character varying (30) not null,
    ano integer not null,
    Cliente_id integer references Cliente (id),
    Modelo_id integer references Modelo (id)
);

CREATE TABLE andar (
    id serial primary key,
    numero_vagas INT NOT NULL
  
);

CREATE TABLE vaga (
    id serial primary key,
    andar_id integer references andar (id)
);

CREATE TABLE vaga_veiculo (
    vaga_id integer references vaga (id),
    veiculo_id integer references Veiculo (id),
    data_hora_entrada timestamp default current_timestamp NOT NULL,
    data_hora_saida timestamp default current_timestamp,
    valor_pago money default 0,
    primary key (vaga_id, Veiculo_id)
);




INSERT INTO Cliente (id,cpf, nome, email, senha, data_nascimento, rua, bairro, complemento, numero)
VALUES
  (1,'22345678901', 'João a Silva', 'joaoo@email.com', 'senha1231', '1981-05-15', 'Rua A', 'Centro', 'Apto 10', 1),
  (2,'18765432101', 'Maria b Oliveira', 'mariao@email.com', 'senha4561', '1993-08-20', 'Rua B', 'Bairro X', 'Casa 2', 4),
  (3,'15555555555', 'Pedro s Santos', 'pedroo@email.com', 'senha7891', '1984-02-10', 'Rua C', 'Bairro Y', 'Sala 3', 7);

-- Inserindo dados na tabela Modelo
INSERT INTO Modelo (id,descricao, ano_lancamento)
VALUES
  (1,'Sedan', 2020),
  (2,'SUV', 2019),
  (3,'Hatchback', 2022);

-- Inserindo dados na tabela Veiculo
INSERT INTO Veiculo (id,chassi, placa, cor, ano, Cliente_id, Modelo_id)
VALUES
  (1,'ABC19345678901234', 'XYZ-1234', 'Azul', 2021, 1, 1),
  (2,'DEFg6789012345678', 'ABC-5678', 'Vermelho', 2019, 2, 2),
  (3,'HId90123456789012', 'JKL-9012', 'Verde', 2022, 3, 3);
  
INSERT INTO andar (id,numero_vagas)
VALUES
  (1,10),
  (2,15),
  (3,20);

-- Inserindo dados na tabela Vaga
INSERT INTO vaga (id,andar_id)
VALUES
  (1,1),
  (2,1),
  (3,2),
  (4,2),
  (5,2),
  (6,3),
  (7,3),
  (8,3),
  (9,3);

-- Inserindo dados na tabela vaga_veiculo
INSERT INTO vaga_veiculo (vaga_id, veiculo_id, data_hora_entrada, data_hora_saida, valor_pago)
VALUES
  (1, 1, '2023-11-24 08:00:00', '2023-11-24 18:00:00', 15.00),
  (3, 2, '2023-11-25 10:30:00', NULL, NULL),
  (7, 3, '2023-11-26 14:45:00', '2023-11-26 17:30:00', 10.50);  





--2)
SELECT placa, ano FROM Veiculo WHERE id = 1;

--3)
-- se for para mostrar o veiculo da questao anterior apenas se o ano for a partir de 2000
SELECT placa, ano FROM Veiculo WHERE id = 1 AND ano >= 2000;
-- se for para mostrar todos os veiculos a partir do ano 2000
SELECT placa, ano FROM Veiculo WHERE ano >= 2000;

--4)
SELECT * FROM Veiculo WHERE Modelo_id = 1;

--5)   
SELECT vaga_veiculo.*, vaga.*, andar.* FROM vaga_veiculo JOIN vaga ON vaga.id = vaga_veiculo.vaga_id JOIN andar ON andar.id = vaga.andar_id WHERE vaga_veiculo.veiculo_id = 1;
    
--6)


--7)
SELECT Modelo.descricao AS modelo, COUNT(Veiculo.id) AS quantidade FROM Modelo JOIN Veiculo ON Veiculo.Modelo_id = Modelo.id WHERE Modelo.id = 1 GROUP BY Modelo.descricao;

--8)
SELECT AVG(EXTRACT(YEAR FROM AGE(CURRENT_DATE, data_nascimento))) AS media_idade FROM Cliente;

--9)
SELECT
    veiculo.placa,
    vaga_veiculo.data_hora_entrada,
    vaga_veiculo.data_hora_saida,
    CASE
        WHEN vaga_veiculo.data_hora_saida IS NOT NULL THEN
            CEIL(EXTRACT(EPOCH FROM (vaga_veiculo.data_hora_saida - vaga_veiculo.data_hora_entrada)) / 3600) * 2
        ELSE
            0
    END AS valor_pago
FROM
    vaga_veiculo
JOIN
    veiculo ON veiculo.id = vaga_veiculo.veiculo_id;


/*/
Um edíficio de garagem coletiva onde:

Cada Cliente tem cpf, nome, data nascimento e endereço (rua, bairro, complemento, número)
Cada Cliente pode ter muitos Veículos. Cada Veículo tem: chassi, placa, cor, ano, um dono (cliente) e é de modelo.
Cada Modelo tem uma descrição e o ano de lançamento
Cada andar tem n vagas. Cada vaga está em um andar específico.
Um veículo pode ocupar diversas vagas ao longo do tempo. E uma mesma vaga poderá ter diversos veículos ao longo do tempo. 
Durante o período de ocupação de um veículo em uma vaga é preciso armazenar qual veículo que está em uma determinada vaga, data/hora de entrada, data hora de saída e valor pago durante a desocupação
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

