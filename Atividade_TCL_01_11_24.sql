CREATE DATABASE bd_exports_1e;
use bd_exports_1e;

CREATE TABLE departamento(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nome VARCHAR(50) NOT NULL,
localizacao VARCHAR(50) NOT NULL,
orcamento DECIMAL(10, 2) NOT NULL
);

INSERT INTO departamento (nome, localizacao, orcamento)
VALUES ('Recursos Humanos', 'Ribeirão Preto', 200000),
	   ('Administrativo', 'São Paulo', 500000),
       ('Financeiro', 'Rio de Janeiro', 300000),
       ('Setor Comercial', 'São Bernardo', 100000),
       ('Setor Operacional', 'São José dos Campos', 250000);
       
#Exporta o arquivo
SELECT * FROM departamento
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

#Importa o arquivo
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\depto.csv'
INTO TABLE departamento
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

#Início da transação
START TRANSACTION;

# Aumentar o orçamento do departamento adminsitrativo em 1000
UPDATE departamento SET orcamento = orcamento + 1000.00 WHERE nome = 'Administrativo'; 

# Aumentar o orçamento do departamento financeiro em 1000
UPDATE departamento SET orcamento = orcamento + 1000.00 WHERE nome = 'Financeiro';

# Confirmar a transação
COMMIT;

ROLLBACK;

START TRANSACTION;

UPDATE departamento SET orcamento = orcamento + 7000.00 WHERE nome = 'Recursos Humanos'; 

SAVEPOINT ajuste_parcial;

UPDATE departamento SET orcamento = orcamento + 2000.00 WHERE nome = 'Setor Comercial';

ROLLBACK TO ajuste_parcial;


DELETE FROM departamento;