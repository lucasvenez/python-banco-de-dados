USE VENDAS;

-- Quantas vendas com e sem desconto?

-- Solução com UNION
SELECT 'SEM DESCONTO' AS 'Tipo', 
       COUNT(*) AS 'Quantidade'
FROM Venda
WHERE taxaDesconto = 0.00

UNION

SELECT 'COM DESCONTO', COUNT(*)
FROM Venda
WHERE taxaDesconto > 0.00;

-- Representação JSON da resposta
-- [
--        {
--               'SEM': 40
--        },
--        {
--               'COM': 60
--        }
-- ]

-- SOLUÇÃO COM SUB CONSULTAS
-- --------------------------------------

SELECT *
FROM
    (SELECT COUNT(*) AS 'SEM' FROM Venda WHERE taxaDesconto = 0) AS SD,
    (SELECT COUNT(*) AS 'COM' FROM Venda WHERE taxaDesconto > 0) AS CD;

-- Representação JSON da resposta

-- {
--        'SEM': 40,
--        'COM': 60
-- }

-- SOLUÇÃO COM WITH
WITH SEM_DESCONTO AS (
    SELECT COUNT(*) AS 'SEM' 
    FROM Venda 
    WHERE taxaDesconto = 0
),
COM_DESCONTO AS (
    SELECT COUNT(*) AS 'COM' 
    FROM Venda 
    WHERE taxaDesconto > 0
)
SELECT *
FROM SEM_DESCONTO, COM_DESCONTO;

-- Quais as vendas com valor total superior a R$ 100,00?
SELECT 
    V.idVenda, 
    V.dataHora, 
    ROUND(SUM(I.quantidade * I.precoUnitario), 2) AS valorTotal
FROM 
    Venda AS V INNER JOIN 
    ItemVenda AS I ON (V.idVenda = I.idVenda)
GROUP BY 
    idVenda, 
    dataHora
-- HAVING valorTotal > 100
ORDER BY idVenda;

SELECT 
    V.idVenda, 
    V.dataHora, 
    quantidade, precoUnitario,
    ROUND(I.quantidade * I.precoUnitario, 2) AS valorTotalItem
FROM 
    Venda AS V INNER JOIN 
    ItemVenda AS I ON (V.idVenda = I.idVenda)


-- SELECT idVenda
--FROM venda
--WHERE DAY(dataHora) = 22;

SELECT idVenda
FROM Venda
WHERE idVenda IN (SELECT idVenda FROM Venda WHERE DAY(dataHora) > 21 )
INTERSECT
SELECT idVenda
FROM Venda
WHERE idVenda IN (SELECT idVenda FROM Venda WHERE DAY(dataHora ) < 23 );

-- Sub-consulta avançada
SELECT *
FROM Venda as V
WHERE (SELECT COUNT(*) FROM ItemVenda AS IT WHERE V.idVenda = IT.idVenda) > 3

SELECT V.idVenda, COUNT(IT.idItemVenda) AS quantidadeItens
FROM Venda AS V INNER JOIN ItemVenda AS IT USING(idVenda)
GROUP BY V.idVenda
HAVING quantidadeItens > 3;