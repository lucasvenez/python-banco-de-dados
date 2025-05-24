DROP DATABASE IF EXISTS VENDAS;

CREATE DATABASE VENDAS;

USE VENDAS;

CREATE TABLE Venda (
    idVenda CHAR(3) NOT NULL,
    dataHora DATETIME NOT NULL DEFAULT NOW(),
    taxaDesconto FLOAT NOT NULL DEFAULT 0.0,

    CONSTRAINT `pk_venda`
        PRIMARY KEY (idVenda),

    CONSTRAINT `ck_venda_taxa_desconto`
        CHECK (taxaDesconto BETWEEN 0 AND 1)
);

CREATE TABLE Produto (
    idProduto CHAR(3) NOT NULL,
    descricao VARCHAR(200) NOT NULL,
    preco     FLOAT NOT NULL,

    CONSTRAINT `pk_produto` PRIMARY KEY (idProduto),

    CONSTRAINT `fk_produto_preco`
        CHECK (preco > 0)
);

CREATE TABLE ItemVenda (
    idItemVenda CHAR(3) NOT NULL,
    idVenda CHAR(3) NOT NULL,
    idProduto CHAR(3) NOT NULL,
    quantidade INT NOT NULL,
    precoUnitario FLOAT NOT NULL,

    CONSTRAINT `pk_item_venda` PRIMARY KEY (idItemVenda),
    
    CONSTRAINT `fk_item_venda_venda` 
        FOREIGN KEY (idVenda) 
        REFERENCES Venda(idVenda),
    
    CONSTRAINT `fk_item_venda_produto`
        FOREIGN KEY (idProduto)
        REFERENCES Produto(idProduto),

    CONSTRAINT `ck_item_venda_quantidade`
        CHECK (quantidade > 0),

    CONSTRAINT `ck_item_venda_valor_unitario`
        CHECK (precoUnitario >= 0)
);