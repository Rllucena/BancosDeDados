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
