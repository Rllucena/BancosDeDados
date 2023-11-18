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


    
*/
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
