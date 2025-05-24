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

SELECT SD.*
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
