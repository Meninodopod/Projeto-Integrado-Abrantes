
CREATE TABLE cargo (
                id_cargo INTEGER NOT NULL,
                cargo VARCHAR NOT NULL,
                salario_minimo NUMERIC(8,2) NOT NULL,
                salario_maximo NUMERIC(8,2) NOT NULL,
                CONSTRAINT cargo_pk PRIMARY KEY (id_cargo)
);
COMMENT ON TABLE cargo IS 'Tabela Cargos';


CREATE TABLE departamento (
                id_departamento INTEGER NOT NULL,
                nome VARCHAR NOT NULL,
                CONSTRAINT departamento_pk PRIMARY KEY (id_departamento)
);
COMMENT ON TABLE departamento IS 'Tabela de Departamentos';


CREATE TABLE funcionario (
                id_funcionario INTEGER NOT NULL,
                id_departamento INTEGER NOT NULL,
                id_cargo INTEGER NOT NULL,
                cpf NUMERIC(11) NOT NULL,
                nome VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                senha VARCHAR NOT NULL,
                telefone INTEGER NOT NULL,
                data_contratacao DATE NOT NULL,
                data_de_inicio DATE NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (id_funcionario)
);
COMMENT ON TABLE funcionario IS 'Tabela de Funcionário';


CREATE TABLE historico_cargo (
                id_departamento INTEGER NOT NULL,
                id_cargo INTEGER NOT NULL,
                id_funcionario INTEGER NOT NULL,
                salario NUMERIC(8,2) NOT NULL,
                data_de_inicio DATE NOT NULL,
                data_de_fim DATE,
                CONSTRAINT historico_cargo_pk PRIMARY KEY (id_departamento, id_cargo, id_funcionario)
);
COMMENT ON TABLE historico_cargo IS 'Tabela de Históricos de cargos';


CREATE TABLE tipo_lixo (
                id_tipo_lixo INTEGER NOT NULL,
                tipo VARCHAR NOT NULL,
                CONSTRAINT tipo_lixo_pk PRIMARY KEY (id_tipo_lixo)
);
COMMENT ON TABLE tipo_lixo IS 'Tabela de Tipos de Lixo';


CREATE TABLE veiculo (
                id_veiculo INTEGER NOT NULL,
                placa VARCHAR NOT NULL,
                descricao VARCHAR,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT veiculo_pk PRIMARY KEY (id_veiculo)
);
COMMENT ON TABLE veiculo IS 'Tabela de Veículos';


CREATE TABLE cliente (
                id_cliente INTEGER NOT NULL,
                cpf NUMERIC(11) NOT NULL,
                nome VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                senha VARCHAR NOT NULL,
                telefone VARCHAR NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT cliente_pk PRIMARY KEY (id_cliente)
);
COMMENT ON TABLE cliente IS 'Tabela de Clientes';
COMMENT ON COLUMN cliente.id_cliente IS 'ID do Cliente';
COMMENT ON COLUMN cliente.cpf IS 'Cpf do Cliente';
COMMENT ON COLUMN cliente.nome IS 'Nome do Cliente';
COMMENT ON COLUMN cliente.email IS 'e-mail do cliente';
COMMENT ON COLUMN cliente.senha IS 'Senha do cliente';
COMMENT ON COLUMN cliente.telefone IS 'Telefone do cliente';
COMMENT ON COLUMN cliente.ativo IS 'Status do cliente';


CREATE TABLE endereco (
                id_endereco INTEGER NOT NULL,
                id_cliente INTEGER NOT NULL,
                rua VARCHAR NOT NULL,
                bairro VARCHAR NOT NULL,
                cep NUMERIC(6) NOT NULL,
                numero INTEGER NOT NULL,
                complemento VARCHAR,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT endereco_pk PRIMARY KEY (id_endereco)
);
COMMENT ON TABLE endereco IS 'Tabela de Endereço';


CREATE TABLE pedidos (
                id_pedido INTEGER NOT NULL,
                id_endereco INTEGER NOT NULL,
                data_solicitacao DATE NOT NULL,
                data_pedido DATE NOT NULL,
                hora_inicial TIME NOT NULL,
                hora_final TIME,
                atendido BOOLEAN NOT NULL,
                ativo BOOLEAN NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (id_pedido)
);
COMMENT ON TABLE pedidos IS 'Tabela de Pedidos';


CREATE TABLE atendimento (
                id_pedido INTEGER NOT NULL,
                id_funcionario INTEGER NOT NULL,
                id_veiculo INTEGER NOT NULL,
                id_tipo_lixo INTEGER NOT NULL,
                data_atendimento DATE NOT NULL,
                ativo BOOLEAN NOT NULL,
                coleta_finalizada BOOLEAN NOT NULL,
                visita_feita BOOLEAN NOT NULL,
                obs VARCHAR NOT NULL,
                CONSTRAINT atendimento_pk PRIMARY KEY (id_pedido, id_funcionario, id_veiculo, id_tipo_lixo)
);
COMMENT ON TABLE atendimento IS 'Tabela de Atendimentos';


ALTER TABLE funcionario ADD CONSTRAINT cargo_funcionario_fk
FOREIGN KEY (id_cargo)
REFERENCES cargo (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargo ADD CONSTRAINT cargo_historico_cargo_fk
FOREIGN KEY (id_cargo)
REFERENCES cargo (id_cargo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargo ADD CONSTRAINT departamento_historico_cargo_fk
FOREIGN KEY (id_departamento)
REFERENCES departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (id_departamento)
REFERENCES departamento (id_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atendimento ADD CONSTRAINT funcionario_atendimento_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE historico_cargo ADD CONSTRAINT funcionario_historico_cargo_fk
FOREIGN KEY (id_funcionario)
REFERENCES funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atendimento ADD CONSTRAINT tipo_lixo_atendimento_fk
FOREIGN KEY (id_tipo_lixo)
REFERENCES tipo_lixo (id_tipo_lixo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atendimento ADD CONSTRAINT veiculo_atendimento_fk
FOREIGN KEY (id_veiculo)
REFERENCES veiculo (id_veiculo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE endereco ADD CONSTRAINT cliente_endereco_fk
FOREIGN KEY (id_cliente)
REFERENCES cliente (id_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT endereco_pedidos_fk
FOREIGN KEY (id_endereco)
REFERENCES endereco (id_endereco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE atendimento ADD CONSTRAINT pedidos_atendimento_fk
FOREIGN KEY (id_pedido)
REFERENCES pedidos (id_pedido)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
