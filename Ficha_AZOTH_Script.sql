--create database ficha;

create table origem(
	id_origem serial primary key,
	nome varchar(30) not null,
	descricao text not null,
	id_talento int not null

);

create table pericia(
	id_pericia serial primary key,
	nome varchar(30) not null,
	descricao text not null

);

create table arma(
	id_arma serial primary key,
	nome varchar(30) not null,
	dano varchar(30) not null,
	critico int not null,
	valor_critico int not null,
	descricao text not null,
	id_dano_tipo int not null,
	id_arma_tipo int not null,
	id_alcance int not null,
	peso int,
	id_talento int

);

create table devocao(
	id_devocao serial primary key,
	nome varchar(30) not null,
	descricao text not null,
	mod_pv int,
	mod_san int,
	mod_pe int

);


create table relva(
	id_relva serial primary key,
	nome varchar(30) not null,
	coagulo int not null,
	custo int not null,
	alvo varchar(20) not null,
	duracao varchar(20) not null,
	descricao text not null,
	id_alcance int not null,
	id_execucao int not null,
	id_pericia_resistencia int

);

create table dano_tipo(
	id_dano_tipo serial primary key,
	nome varchar(30) not null

);

create table arma_tipo(
	id_arma_tipo serial primary key,
	nome varchar(30) not null

);

create table alcance(
	id_alcance serial primary key,
	nome varchar(30) not null,
	metros int 

);

create table talento(
	id_talento serial primary key,
	nome varchar(30) not null,
	descricao text not null,
	exclusivo bool not null

);

create table item(
	id_item serial primary key,
	nome varchar(100) not null,
	descricao text not null,
	peso int,
	id_mod int

);

create table mod(
	id_mod serial primary key,
	nome varchar(30) not null,
	valor int not null
	
);

create table cacador(
	id_cacador serial primary key,
	nome_cacador varchar(50),
	nome_jogador varchar(50),
	pv_maximo int not null default 0,
	pv_atual int not null default 0,
	san_maximo int not null default 0,
	san_atual int not null default 0,
	pe_maximo int not null default 0,
	pe_atual int not null default 0,
	pec int not null default 0,
	id_origem int not null default 0,
	id_devocao int,
	id_cadastro int not null
	
);

create table cacador_pericias(
	id_cacador int not null,
	id_pericia int not null

);

create table cacador_arma(
	id_cacador int not null,
	id_arma int not null,
	equipado bool not null

);

create table cacador_talento(
	id_cacador int not null,
	id_talento int not null
);

create table cacador_relva(
	id_cacador int not null,
	id_relva int not null

);

create table cacador_item(
	id_cacador int not null,
	id_item int not null,
	quantia int not null,
	equipado bool

);

create table cacador_atributos(
	id_cacador int not null,
	forca int not null,
	agilidade int not null,
	intelecto int not null,
	presenca int not null,
	vigor int not null

);

create table cacador_proficiencias(
	id_cacador int not null,
	ageis int not null,
	balanceadas int not null,
	brutas int not null,
	ambicao int not null,
	fogo int not null,
	fome int not null,
	podre int not null

);

create table resistencia(
	id_dano_tipo int not null,
	id_cacador int not null,
	valor_resistencia int not null

);

create table identificacao(
	id_cacador int not null,
	nome_completo varchar(60),
	idade varchar(4),
	peso numeric(4,1),
	altura numeric (3,2),
	descricao_fisica text,
	aniversario numeric(4,2),
	gosta varchar(200),
	n_gosta varchar(200)
	
);

create table requisito_atributos(
	id_talento int not null,
	atributo varchar(30) not null,
	valor_minimo int not null

);

create table requisito_proficiencias(
	id_talento int not null,
	proficiencia varchar(30) not null,
	valor_minimo int not null

);

create table requisito_pericias(
	id_talento int not null,
	id_pericia int not null

);

create table requisito_talentos(
	id_talento int not null,
	id_talento_requerido int not null

);

create table requisito_arma(
	id_talento int not null,
	id_arma int not null

);

create table requisito_devocao(
	id_talento int not null,
	id_devocao int not null

);

create table requisito_arma_atributos(
	id_arma int not null,
	atributo varchar(30) not null,
	valor_minimo int not null

);

create table requisito_arma_proficiencias(
	id_arma int not null,
	proficiencia varchar(30) not null,
	valor_minimo int not null
	
);

create table devocao_atributo(
	id_devocao int not null,
	atributo varchar(30) not null,
	valor int not null

);

create table devocao_pericia(
	id_devocao int not null,
	id_pericia int not null,
	valor int not null

);

create table devocao_defesa(
	id_devocao int not null,
	valor int not null

);

create table execucao(
	id_execucao serial primary key,
	nome varchar(30) not null

);

create table cargo(
	id_cargo serial primary key,
	nome varchar(30) not null

);

create table cadastro(
	id_cadastro serial primary key,
	nome varchar (50) not null,
	senha varchar (20) not null,
	id_cargo int not null default 1 references cargo(id_cargo)

);

create table updlog(
	id_updlog serial primary key,
	nome varchar (50),
	data_inicio date,
	data_final date default now(),
	mudanca text,
	nota_final text

);


--ORGANIZAR O NOME DOS FKS

alter table arma add constraint fk_dano_tipo
foreign key (id_dano_tipo) references dano_tipo(id_dano_tipo);

alter table arma add constraint fk_arma_tipo
foreign key (id_arma_tipo) references arma_tipo(id_arma_tipo);

alter table arma add constraint fk_alcance
foreign key (id_alcance) references alcance(id_alcance);

alter table arma add constraint fk_talento
foreign key (id_talento) references talento(id_talento);

alter table requisito_arma_atributos add constraint fk_req_arma_atributos
foreign key (id_arma) references arma(id_arma);

alter table requisito_arma_proficiencias add constraint fk_req_arma_proficiencias
foreign key (id_arma) references arma(id_arma);




alter table relva add constraint fk_alcance
foreign key (id_alcance) references alcance(id_alcance);

alter table relva add constraint fk_execucao
foreign key (id_execucao) references execucao(id_execucao);

alter table relva add constraint fk_pericia
foreign key (id_pericia_resistencia) references pericia(id_pericia);



alter table item add constraint fk_mod
foreign key (id_mod) references mod(id_mod);



alter table cacador add constraint fk_origem
foreign key (id_origem) references origem(id_origem);

alter table cacador add constraint fk_devocao
foreign key (id_devocao) references devocao(id_devocao);

alter table cacador_pericias add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_pericias add constraint fk_pericias
foreign key (id_pericia) references pericia(id_pericia);

alter table cacador_arma add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_arma add constraint fk_arma
foreign key (id_arma) references arma(id_arma);

alter table cacador_talento add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_talento add constraint fk_talento
foreign key (id_talento) references talento(id_talento);

alter table cacador_relva add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_relva add constraint fk_relva
foreign key (id_relva) references relva(id_relva);

alter table cacador_item add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_item add constraint fk_item
foreign key (id_item) references item(id_item);

alter table cacador_atributos add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table cacador_proficiencias add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table resistencia add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);

alter table resistencia add constraint fk_dano_tipo
foreign key (id_dano_tipo) references dano_tipo(id_dano_tipo);

alter table identificacao add constraint fk_cacador
foreign key (id_cacador) references cacador(id_cacador);


alter table requisito_atributos add constraint fk_req_atributos
foreign key (id_talento) references talento(id_talento);

alter table requisito_proficiencias add constraint fk_req_proficiencias
foreign key (id_talento) references talento(id_talento);

alter table requisito_pericias add constraint fk_req_pericias_talento
foreign key (id_talento) references talento(id_talento);

alter table requisito_pericias add constraint fk_req_pericia_pericia
foreign key (id_pericia) references pericia(id_pericia);

alter table requisito_talentos add constraint fk_req_talento
foreign key (id_talento) references talento(id_talento);

alter table requisito_talentos add constraint fk_req_talento_requerido
foreign key (id_talento_requerido) references talento(id_talento);

alter table requisito_arma add constraint fk_req_arma_talento
foreign key (id_talento) references talento(id_talento);

alter table requisito_arma add constraint fk_req_arma_arma
foreign key (id_arma) references arma(id_arma);

alter table requisito_devocao add constraint fk_req_devocao_talento
foreign key (id_talento) references talento(id_talento);

alter table requisito_devocao add constraint fk_req_devocao_devocao
foreign key (id_devocao) references devocao(id_devocao);



alter table devocao_atributo add constraint fk_devocao
foreign key (id_devocao) references devocao(id_devocao);

alter table devocao_pericia add constraint fk_devocao
foreign key (id_devocao) references devocao(id_devocao);

alter table devocao_pericia add constraint fk_pericia
foreign key (id_pericia) references pericia(id_pericia);

alter table devocao_defesa add constraint fk_devocao
foreign key (id_devocao) references devocao(id_devocao);


insert into dano_tipo(nome)
values 
('Corte'),
('Impacto'),
('Perfuração'),
('Balistico'),
('Fisico'),
('Térmico'),
('Ambição'),
('Fome'),
('Fogo'),
('Podre'),
('Marcado'),
('Real'),
('Mental');

insert into cargo(nome)
values
('Jogador'),
('Colaborador'),
('Mivomi/Main dev');




