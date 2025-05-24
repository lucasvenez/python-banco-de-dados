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
WITH 

