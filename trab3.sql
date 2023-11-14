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
);

CREATE TABLE jornalista (
    id serial primary key,
    nome character varying(100) not null,
    cpf character(11) unique,
    senha character varying(100) not null,
    data_nascimento date    
);

CREATE TABLE categoria (
    id serial primary key,
    descricao text not null
);


CREATE TABLE noticia (
    id serial primary key,
    titulo character varying (150) not null,
    texto text not null,
    data_hora timestamp default current_timestamp,
    categoria_id integer references categoria (id),
    jornalista_id integer references jornalista (id),
    flag integer default 1
);


CREATE TABLE foto (
    id serial primary key,
    nome text not null,
    legenda text,
    noticia_id integer references noticia (id)    
);



CREATE TABLE assinante_noticia (
    assinante_id integer references assinante (id),
    noticia_id integer references noticia (id),
    data_hora_leitura timestamp default current_timestamp,
    primary key (assinante_id, noticia_id, data_hora_leitura)
);

-- mensal, trimestral
CREATE TABLE modalidade (
    id serial primary key,
    nome text not null,
    valor money default 0    
);

CREATE TABLE plano (
    id serial primary key,
    modalidade_id integer references modalidade (id),
    assinante_id integer references assinante (id),
    data_hora_inicio timestamp default current_timestamp,
    data_hora_fim timestamp 
);

CREATE TABLE pagamento (
    id serial primary key,
    valor money,
    data_hora timestamp default current_timestamp,
    plano_id integer references plano (id)
);
