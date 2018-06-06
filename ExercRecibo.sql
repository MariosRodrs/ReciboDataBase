#Exercícios de Banco de Dados SQL

# 1 - Faça insert na tabela UF com todas as siglas dos estados do Brasil.

insert into uf (sigla) values 
('AC'),('AL'),('AP'),('AM'),('BA'),('CE'),('DF'),
('ES'),('GO'),('MA'),('MT'),('MS'),('MG'),('PA'),
('PB'),('PR'),('PE'),('PI'),('RJ'),('RN'),('RS'),
('RO'),('RR'),('SC'),('SP'),('SE'),('TO');



# 2 - Insira as seguintes cidades:
/*Para o SC
* Chapecó
* Blumenau
* Joinville

Para o PR
* Curitiba
* Maringá
* Lunardeli
* Apucarana
* Santa fé
* São Miguel do Iguaçu
* Arapongas
* Ponta Grossa
* Jandaia do Sul

Para o SP
*Ribeirão Preto*/

insert into cidade(nome, uf_id) select 'Chapecó', idUf from uf where sigla = 'SC';
insert into cidade(nome, uf_id) select 'Blumenau', idUf from uf where sigla = 'SC';
insert into cidade(nome, uf_id) select 'Joinville', idUf from uf where sigla = 'SC';
insert into cidade(nome, uf_id) select 'Curitiba', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Maringá', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Lunardeli', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Apucarana', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Santa Fé', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'São Miguel do Iguaçu', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Arapongas', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Ponta Grossa', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Jandaia do Sul', idUf from uf where sigla = 'PR';
insert into cidade(nome, uf_id) select 'Ribeirão preto', idUf from uf where sigla = 'SP';



# 3 - Realize a remoção dos estados que não tem cidades.
SET SQL_SAFE_UPDATES = 0;
delete from uf
WHERE idUf IN
  (
    SELECT u.idUf
    from (select * from uf) as u
    left join cidade c
    on c.uf_id = u.idUf
    where c.Uf_id is null
  );


# 4 - Insira novas cidades no estado de SP.

insert into cidade (nome, uf_id) select 'São Paulo', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Guarulhos',idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Campinas', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'São Bernardo do Campo', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'São Jose dos Campos', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Santo André',idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Osasco', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Sorocaba', idUf from uf where sigla = 'SP';
insert into cidade (nome, uf_id) select 'Santos', idUf from uf where sigla = 'SP';



# 5 - Realize a atualização do nome das cidades:
/*	- Lunardeli para Lunardelli
	- Jandaia do Sul para Jandaia
	- Maringá para Cidade Canção*/
    
set sql_safe_updates = 0;
update cidade set nome = 'Lunardelli' where nome like 'Lunardeli';
update cidade set nome = 'Jandaia' where nome like 'Jandaia do Sul';
update cidade set nome = 'Cidade Canção' where nome like 'Maringá';



# 6 - Faça um select que retorne o nome das cidades e seus respectivos estados. Ordene por estados e posteriormente pelo nome das cidades. 

select cidade.nome, uf.sigla
from cidade 
inner join uf 
on (cidade.uf_id = uf.idUf)
order by uf.sigla , cidade.nome;



# 7 - Retorne quantas cidades cada estado possui :) (não expliquei ainda):  dica: veja group by e count().

select uf.sigla, 
count(cidade.idCidade) 
from cidade
inner join uf 
on uf.idUf = cidade.uf_id
group by uf.sigla;



# 8 - Insira três pessoas na base de dados. Cada uma destas pessoas deve ter dois endereços (um comercial e outro residencial). As cidades que devem ser usadas são do estado do PR (você escolhe).

#inserção das pessoas
insert into pessoa (nome, documento)
values('Carlos', '123456789'), ('Mario', '987654321'),('Nina', '147258369');

#inserção dos endereços 1 = residencial; 2 = comercial.
insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Carlos'),
    cidade.idCidade, 'Tv', 'Colibri',112,'87000000',1
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Carlos'),
    cidade.idCidade, 'Av', 'Maringá',4580,'89000091',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Curitiba';


insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Mario'),
    cidade.idCidade, 'Tv', 'Colibri',112,'87000000',1
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Mario'),
    cidade.idCidade, 'Av', 'Avenida Centro',980,'87000000',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';


insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Nina'),
    cidade.idCidade, 'Av', 'Mario Urbinati',380,'87000000',1
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
	(select idPessoa from pessoa where nome = 'Nina'),
    cidade.idCidade, 'Av', 'Rua São Paulo',45,'89123456',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Lunardelli';



# 9 -Insira duas pessoas na base de dados. Cada uma destas pessoas deve ter dois endereços (um comercial e outro residencial). As cidades que devem ser usadas são do estado de SP (você escolhe).

#inserção das pessoas
insert into pessoa (nome, documento) values ('Wagner','123654789'),('Fusca','123987654');

#inserção dos endereços 1 = residencial; 2 = comercial.
insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Wagner'),
cidade.idCidade, 'rua','Curitiba','34','87000000','1'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SP' and cidade.nome = 'São Paulo';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Wagner'),
cidade.idCidade, 'Av','Campinas','34','87000000','2'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SP' and cidade.nome = 'São Paulo';


insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Fusca'),
cidade.idCidade, 'Praça','São Vicente','15','87000012','1'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SP' and cidade.nome = 'Osasco';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Fusca'),
cidade.idCidade, 'rua','Marabá','357','88456000','2'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SP' and cidade.nome = 'Osasco';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Wagner'),
cidade.idCidade, 'Rua','Ribeirão Preto','895','9856000','2'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SP' and cidade.nome = 'Ribeirão preto';



# 10 - Insira duas pessoas na base de dados. Cada uma destas pessoas deve ter um endereço do tipo comercial. As cidades que devem ser usadas são do estado de SC (você escolhe).

#inserção das pessoas
insert into pessoa (nome, documento) values ('Bianca','568932145'),('Amaral','978643156');

#inserção dos endereços 1 = residencial; 2 = comercial.
insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Bianca'),
cidade.idCidade, 'Rua','Praia bela','789','87000012','2'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SC' and cidade.nome = 'Blumenau';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select
(select idPessoa from pessoa where nome = 'Amaral'),
cidade.idCidade, 'Av','Blumenau','1457','87023658','2'
from cidade
inner join uf on uf.idUf = cidade.Uf_id
where uf.sigla = 'SC' and cidade.nome = 'Joinville';



# 11 - Faça um select que retorne o nome das pessoas e seus respectivos endereços (com cidade e estado). Ordene por nome de pessoa, nome do estado e nome da cidade.

select pessoa.nome, endereco.logradouro, cidade.nome, uf.sigla
from pessoa 
inner join endereco on pessoa.idPessoa = endereco.pessoa_id
inner join cidade on endereco.cidade_id = cidade.idCidade
inner join uf on cidade.uf_id = uf.idUf
order by pessoa.nome, uf.sigla, cidade.nome;



# 12 - Remova todos os endereços que são da cidade de Ribeirão Preto.

delete from endereco
WHERE idEndereco IN
  (
    SELECT e.idEndereco
    from (select * from endereco) as e
    left join cidade c
    on c.idCidade = e.cidade_id
    where c.nome = 'Ribeirão preto'
  );



#13 - Mude todos os endereços residenciais do sistema. Eles devem ter cep 00000000
update endereco set cep = '00000000' 
where tipo = 1;


#14 - Altere o nome da coluna prestador_fk para cliente_fk.
alter table recibo
change prestador cliente_fk integer(11);



/*15 - Insira dois recibos sendo que eles devem ter clientes residentes no PR e o prestador de serviço deve ser o mesmo (não importando o estado).
Exemplo: 
* cliente fusca, da cidade Curitiba, no PR. Prestador: DB1, estado PR.
* cliente Tamara, da cidade Maringá, no PR. Prestador: DB1, estado PR.*/

#Inseri as pessoas Tamara Fusca e DB1
insert into pessoa (nome, documento)
values('Tamara', '65485236'),('Fusca2','456963247'),('DB1','12345678987654');

#inseri os endereços do Fusca, Tamara e DB1
insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select 
	(select idPessoa from pessoa where nome = 'Fusca2'),
	cidade.idCidade, 'Rua','Exercícios',15,'00000000',1
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Curitiba';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select 
	(select idPessoa from pessoa where nome = 'Tamara'),
	cidade.idCidade, 'Rua','Exercícios',15,'00000000',1
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select 
	(select idPessoa from pessoa where nome = 'DB1'),
	cidade.idCidade, 'Av','Horácio Raccanello',5410,'87020035',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

#Inseri os recibos do Fusca e Tamara emitentes DB1
insert into recibo (cliente_fk, emitente, numero, valor, referencia, dataEmissao)
select
	(select idPessoa from pessoa where nome = 'Fusca2'),
    (select idPessoa from pessoa where nome = 'DB1'),
    '123','1380','17', str_to_date("06/06/2018", "%m/%d/%Y");

insert into recibo (cliente_fk, emitente, numero, valor, referencia, dataEmissao)
select
	(select idPessoa from pessoa where nome = 'Tamara'),
    (select idPessoa from pessoa where nome = 'DB1'),
    '589','22500','18', str_to_date("06/06/2018", "%m/%d/%Y");



/* 16 - Insira dois recibos sendo que eles devem ter clientes residentes no PR e prestadores de serviços diferentes.
Exemplo: 
* cliente fusca, da cidade Curitiba, no PR. Prestador: FCV, estado PR.
* cliente Tamara, da cidade Maringá, no PR. Prestador: USP, estado SP.*/

#inseri prestadores diferentes
insert into pessoa (nome, documento)
values('FCV', '56889740001'),('USP','23258960001'),('UEM','00125470001');


#inseri os endereços
insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select 
	(select idPessoa from pessoa where nome = 'FCV'),
	cidade.idCidade, 'Av','Horácio Raccanello',458,'87020035',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';


insert into endereco (pessoa_id, cidade_id, tipologradouro, logradouro, numero, cep, tipo)
select 
	(select idPessoa from pessoa where nome = 'USP'),
	cidade.idCidade, 'Rua','São Paulo',5896,'87020035',2
from cidade
inner join uf on uf.idUf = cidade.uf_id
where uf.sigla = 'SP' and cidade.nome = 'São Paulo';


#inserindo os recibos forma 1
insert into recibo (cliente_fk, emitente, numero, valor, referencia, dataEmissao)
select
	(select idPessoa from pessoa where nome = 'Fusca2'),
    pessoa.idPessoa,'567','125000','16', str_to_date("06/06/2018", "%m/%d/%Y")
from pessoa 
inner join endereco on pessoa.idPessoa = endereco.pessoa_id
inner join cidade on endereco.cidade_id = cidade.idCidade
inner join uf on cidade.uf_id = uf.idUf
where pessoa.nome = 'FCV' and uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';

#forma 2
insert into recibo (cliente_fk, emitente, numero, valor, referencia, dataEmissao)
select
	pessoa.idPessoa,
    (select idPessoa from pessoa where nome = 'USP'),
    '5689','1258','16', str_to_date("06/06/2018", "%m/%d/%Y")
from pessoa 
inner join endereco on pessoa.idPessoa = endereco.pessoa_id
inner join cidade on endereco.cidade_id = cidade.idCidade
inner join uf on cidade.uf_id = uf.idUf
where pessoa.nome = 'Tamara' and uf.sigla = 'PR' and cidade.nome = 'Cidade Canção';



/* 17 - Realize uma consulta na base de dados e exiba os seguintes dados:
	* número do recibo
	* data emissão do recibo
	* valor do recibo
	* nome do cliente 
	* estado do cliente
	* nome do emitente
	* estado do emitente
	ordene por data de recibo, nome do cliente e nome do emitente*/
    
#NÃO CONSEGUI POR INTEIRO
select idRecibo, cli.numero, dataEmissao, valor, pessoa.nome, uf.sigla, pessoa.nome, uf.sigla
from (select * from recibo) as cli
inner join pessoa on cli.cliente_fk = pessoa.idPessoa
inner join endereco on pessoa.idPessoa = endereco.pessoa_id
inner join cidade on endereco.cidade_id = cidade.idCidade
inner join uf on cidade.uf_id = uf.idUf;



/* 18 - Faça uma consulta que mostre:
	* quantidade de recibos emitidos no PR
	* valor total de recibos emitidos no PR
*/
select 
count(recibo.idRecibo) as Qtd_Recibos,
sum(recibo.valor) as Total_em_Reais
from recibo;
