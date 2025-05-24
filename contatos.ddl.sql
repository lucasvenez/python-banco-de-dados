DROP DATABASE IF EXISTS CONTATOS;

CREATE DATABASE CONTATOS;

USE CONTATOS;

CREATE TABLE Pessoa (
    idPessoa CHAR(3) NOT NULL,
    nome VARCHAR(150) NOT NULL,

    CONSTRAINT `pk_pessoa` PRIMARY KEY (idPessoa)
);

CREATE TABLE Contato (
    idContato CHAR(3) NOT NULL,
    idPessoa CHAR(3) NOT NULL,
    contato VARCHAR(100),
    tipoContato ENUM('T', 'E'),

    CONSTRAINT `pk_contato` PRIMARY KEY (idContato),
    
    CONSTRAINT `fk_contato_pessoa` 
        FOREIGN KEY (idPessoa)
        REFERENCES Pessoa(idPessoa)
);

INSERT Pessoa VALUES
    ('P01', 'Lucas Venezian Povoa'),
    ('P02', 'Jorge Gabriel'),
    ('P03', 'João Veríssimo');

INSERT INTO Contato VALUES
    ('C01', 'P01', '+5511997745544', 'T'),
    ('C02', 'P01', 'lucasvenez@gmail.com', 'E');