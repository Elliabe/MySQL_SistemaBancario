-- resposta 1

create database sistema_bancario;
use sistema_bancario;

-- resposta 2 
create table banco (
codigo int not null, 
nome varchar (25),
primary key (codigo)
);


 
create table agencia (
numero_agencia int primary key not null,
endereco varchar(200), 
cod_banco int not null,
foreign key (cod_banco) references banco (codigo)
);

create table cliente(
cpf varchar(20) primary key, 
nome varchar (150),
sexo enum ('f', 'm'), 
endereco varchar (250)
);




create table conta(
numero_conta varchar(15) primary key,
saldo float,
tipo_conta smallint,
num_agencia int,
foreign key (num_agencia) references agencia(numero_agencia)
);

create table historico(
cpf_cliente varchar (20) not null primary key, 
num_conta varchar (7),
data_inicio date not null, 
foreign key (num_conta) references conta (numero_conta), 
foreign key (cpf_cliente) references cliente(cpf)
);

create table telefone_cliente(
cpf_cli varchar (20), 
telefone_cli varchar (20) primary key,
foreign key (cpf_cli) references cliente(cpf)
);

-- resposta 3

insert into banco values  
('1', 'Banco do Brasil'),
('4', 'CEF');

insert into agencia values 
('322','Av. Walfredo Macedo Brandao, 1139','4'),
('1253', 'R. Bancário Sérgio Guerra, 17', '1');


insert into cliente values 
('111.222.333-44', 'Bruna Andrade', 'F', 'Rua José Firmino Ferreira, 1050'),
('666.777.888-99', 'Radegondes Silva', 'M', 'Av. Epitácio Pessoa, 1008'),
('555.444.777-33', 'Miguel Xavier', 'M', 'Rua Bancário Sérgio Guerra, 640');

insert into conta values 
('11765-2', '22745.05', '2', '322'),
('21010-7','3100.96', '1', '1253');


insert into historico values
('111.222.333-44', '11765-2', '2015-12-22'),
('666.777.888-99', '11765-2', '2016-10-05'),
('555.444.777-33', '21010-7','2012-08-29');

insert into telefone_cliente values 
('111.222.333-44', '(83)3222-1234'),
('666.777.888-99','(83)99443-9999'), 
('555.444.777-33', '(83)3233-2267');

-- resposta 4 
alter table cliente 
add column pais char (3) default 'BRA';

-- resposta 5 
alter table cliente 
add column email varchar(40);

-- resposta 6 
DELETE FROM historico WHERE num_conta='11765-2';
DELETE FROM conta WHERE numero_conta='11765-2'; 

-- resposta 7 
UPDATE agencia 
SET 
    numero_agencia = 6342
WHERE
    numero_agencia = 322;


-- resposta 8 

alter table conta
modify column numero_conta char(7);

set foreign_key_checks = 0; 
set foreign_key_checks = 1; 
describe conta;

-- resposta 9 
set sql_safe_updates=0;

UPDATE cliente 
SET 
    email = 'radegondes.silva@gmail.com'
WHERE
    nome = 'Radegondes Silva';

set sql_safe_updates=1;

-- resposta 10

set sql_safe_updates = 0;

UPDATE conta 
SET 
    saldo = '3411.92'
WHERE
    tipo_conta = '1';

set sql_safe_updates = 1;

-- resposta 11 

UPDATE cliente 
SET 
    nome = 'Bruna Fernandes'
WHERE
    cpf = '111.222.333-44';

-- resposta 12

set sql_safe_updates = 0;

UPDATE conta 
SET 
    tipo_conta = '3'
WHERE
    saldo > 10000;

set sql_safe_updates = 1;

-- resposta 13 
SELECT 
    nome, sexo
FROM
    cliente
ORDER BY nome DESC;

-- resposta 14	

select sum(saldo) from conta;

-- resposta 15	

select  count(*) as total_cliente from cliente;

-- resposta 16
SELECT c.nome, c.endereco, h.num_conta FROM cliente c 
JOIN historico h WHERE c.cpf = h.cpf_cliente;

-- resposta 17
SELECT 
    sexo, COUNT(*) AS pessoas_cadastradas
FROM
    cliente
GROUP BY sexo;

-- resposta 18 
SELECT c.nome FROM cliente c JOIN historico h 
ON c.cpf = h.cpf_cliente JOIN conta cont ON h.num_conta = cont.numero_conta
ORDER BY cont.saldo DESC LIMIT 1; 

-- resposta 19
SELECT c.nome, h.num_conta, cont.saldo AS saldo_anterior, cont.saldo * 1.035
FROM cliente c JOIN historico h ON c.cpf= h.cpf_cliente JOIN conta cont ON h.num_conta = cont.numero_conta;

-- RESPOSTA 20

SELECT nome FROM cliente WHERE endereco LIKE 'Av%';












