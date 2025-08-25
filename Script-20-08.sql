--create database maria_bolsa;

create table login(
	id_login serial primary key,
	email varchar (50) not null,
	senha varchar (12) not null,
	CPF char (11) not null,
	nome varchar (45) not null,
	sobrenome varchar (75) not null,
	celular char (15) not null,
	data_nascimento date not null,
	genero varchar (20)
);

create table endereco(
	id_endereco serial primary key,
	CEP char (8) not null,
	estado varchar (35) not null, 
	cidade varchar (38) not null,
	bairro varchar (30) not null,
	numero char (3) not null,
	complemento varchar (90),
	rua varchar (36) not null,
	destinatario varchar (45) not null,
	compra bool
);

create table produto(
	id_produto serial primary key,
	titulo varchar(30) not null,
	preco numeric(5,2) not null,
	estoque int not null check (estoque >= 0),
	parcelamento int,
	altura int not null,
	peso int not null,
	largura int not null,
	profundidade int not null,
	descricao text not null,
	id_categoria int not null references categoria(id_categoria)
	
);

create table imagem_produto(
	id_produto int not null references produto(id_produto),
	img_produto bytea not null
	
);

create table categoria(
	id_categoria serial primary key,
	nome varchar(30)
);


create table cor(
	id_cor serial primary key,
	nome varchar(30) not null	
	
);

create table cor_produto(
	id_produto int not null references produto(id_produto),
	id_cor int not null references cor(id_cor)

);


create table pagamento(
	id_pagamento serial primary key,
	nome varchar(30) not null

);

create table pedido(
	id_pedido serial primary key,
	data date not null,
	id_pagamento int not null references pagamento(id_pagamento),
	id_endereco int not null references endereco(id_endereco)

);

create table pedido_produto(
	id_pedido int not null references pedido(id_pedido),
	id_produto int not null references produto(id_produto)

);


INSERT INTO login (email, senha, CPF, nome, sobrenome, celular, data_nascimento, genero) VALUES
('maria.silva@email.com', 'senha123', '12345678901', 'Maria', 'Silva', '(11)99999-9999', '1990-05-15', 'Feminino'),
('joao.santos@email.com', 'abc456', '23456789012', 'João', 'Santos', '(11)98888-8888', '1985-12-03', 'Masculino'),
('ana.oliveira@email.com', 'teste789', '34567890123', 'Ana', 'Oliveira', '(11)97777-7777', '1995-08-22', 'Feminino'),
('carlos.lima@email.com', 'minhasenha', '45678901234', 'Carlos', 'Lima', '(11)96666-6666', '1988-03-10', 'Masculino'),
('juliana.pereira@email.com', 'juli1234', '56789012345', 'Juliana', 'Pereira', '(11)95555-5555', '1992-11-28', 'Feminino');


INSERT INTO categoria (nome) VALUES
('Bolsas de Mão'),
('Bolsas de Ombro'),
('Mochilas');

INSERT INTO cor (nome) VALUES
('Preto'),
('Marrom'),
('Vermelho'),
('Azul Marinho'),
('Bege');

INSERT INTO pagamento (nome) VALUES
('Cartão de Crédito'),
('Boleto Bancário'),
('PIX');

INSERT INTO endereco (CEP, estado, cidade, bairro, numero, complemento, rua, destinatario, compra) VALUES
('01234567', 'São Paulo', 'São Paulo', 'Centro', '123', 'Apto 101', 'Rua das Flores', 'Maria Silva', true),
('04567890', 'São Paulo', 'São Paulo', 'Vila Olímpia', '456', 'Sala 5', 'Avenida Paulista', 'João Santos', false),
('07890123', 'Rio de Janeiro', 'Rio de Janeiro', 'Copacabana', '789', 'Bloco B', 'Avenida Atlântica', 'Ana Oliveira', true),
('03456789', 'Minas Gerais', 'Belo Horizonte', 'Savassi', '321', NULL, 'Rua da Bahia', 'Carlos Lima', true),
('05678901', 'São Paulo', 'Campinas', 'Cambuí', '654', 'Casa 2', 'Rua José Paulino', 'Juliana Pereira', false);

INSERT INTO produto (titulo, preco, estoque, parcelamento, altura, peso, largura, profundidade, descricao, id_categoria) VALUES
('Bolsa de Couro Premium', 299.90, 15, 6, 25, 800, 35, 15, 'Bolsa de couro legítimo com acabamento impecável', 1),
('Bolsa Tote Minimalista', 159.90, 30, 4, 30, 600, 40, 12, 'Bolsa espaçosa ideal para o dia a dia', 2),
('Mochila Executiva', 229.50, 20, 5, 40, 900, 30, 18, 'Mochila elegante com compartimento para notebook', 3),
('Clutch Elegance', 89.90, 25, 2, 20, 300, 28, 5, 'Clutch perfeito para eventos e ocasiões especiais', 1),
('Bolsa Transversal Classic', 199.90, 18, 4, 28, 700, 32, 10, 'Bolsa transversal em couro sintético de alta qualidade', 2);

INSERT INTO cor_produto (id_produto, id_cor) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);

INSERT INTO pedido (data, id_pagamento, id_endereco) VALUES
('2023-10-15', 1, 1),
('2023-10-16', 3, 3),
('2023-10-17', 2, 4),
('2023-10-18', 1, 1),
('2023-10-19', 3, 3);

INSERT INTO pedido_produto (id_pedido, id_produto) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 4),
(4, 5);

SELECT 
    p.id_produto,
    p.titulo,
    p.preco,
    p.estoque,
    c.nome as categoria
FROM produto p
INNER JOIN categoria c ON p.id_categoria = c.id_categoria
ORDER BY p.titulo;

SELECT 
    p.titulo,
    cor.nome as cor
FROM produto p
INNER JOIN cor_produto cp ON p.id_produto = cp.id_produto
INNER JOIN cor ON cp.id_cor = cor.id_cor
ORDER BY p.titulo, cor.nome;

SELECT 
    ped.id_pedido,
    ped.data,
    pag.nome as forma_pagamento,
    e.cidade,
    e.estado
FROM pedido ped
INNER JOIN pagamento pag ON ped.id_pagamento = pag.id_pagamento
INNER JOIN endereco e ON ped.id_endereco = e.id_endereco
ORDER BY ped.data DESC;

SELECT 
    e.destinatario as cliente,
    COUNT(ped.id_pedido) as total_pedidos
FROM pedido ped
INNER JOIN endereco e ON ped.id_endereco = e.id_endereco
WHERE e.compra = true
GROUP BY e.destinatario
ORDER BY total_pedidos DESC;

SELECT 
    titulo,
    estoque,
    preco
FROM produto
WHERE estoque < 20
ORDER BY estoque ASC;


