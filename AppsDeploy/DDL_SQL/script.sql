-- Verifique se a tabela existe antes de criá-la
IF OBJECT_ID('t_pl_produto', 'U') IS NOT NULL
    DROP TABLE t_pl_produto;

CREATE TABLE t_pl_produto (
    id_produto   INT NOT NULL,
    nm_produto   NVARCHAR(150) NOT NULL,
    ds_categoria NVARCHAR(150) NOT NULL,
    nr_preco     DECIMAL(25, 2) NOT NULL,
    st_produto   CHAR(1) NOT NULL CHECK (st_produto IN ('D', 'I')),
    ds_produto   NVARCHAR(250) NOT NULL,
    nr_tamanho   NVARCHAR(50) NOT NULL,
    CONSTRAINT t_pl_produto_pk PRIMARY KEY (id_produto)
);

IF OBJECT_ID('t_pl_cliente', 'U') IS NOT NULL
    DROP TABLE t_pl_cliente;

CREATE TABLE t_pl_cliente (
    id_cliente    INT NOT NULL,
    nm_cliente    NVARCHAR(50) NOT NULL,
    nr_cpf        BIGINT NOT NULL,
    nr_rg         BIGINT NOT NULL,
    dt_nascimento DATE NOT NULL,
    cd_senha      NVARCHAR(150) NOT NULL,
    CONSTRAINT t_pl_cliente_pk PRIMARY KEY (id_cliente)
);

IF OBJECT_ID('t_pl_cliente_produto', 'U') IS NOT NULL
    DROP TABLE t_pl_cliente_produto;

CREATE TABLE t_pl_cliente_produto (
    id_cliente_produto INT NOT NULL,
    id_cliente         INT NOT NULL,
    id_produto         INT NOT NULL,
    dt_inicio          DATE NOT NULL,
    dt_fim             DATE,
    CONSTRAINT t_pl_cliente_produto_pk PRIMARY KEY (id_cliente_produto),
    CONSTRAINT fk_cliente_produto FOREIGN KEY (id_cliente) REFERENCES t_pl_cliente(id_cliente),
    CONSTRAINT fk_produto_cliente FOREIGN KEY (id_produto) REFERENCES t_pl_produto(id_produto)
);

IF OBJECT_ID('t_pl_email', 'U') IS NOT NULL
    DROP TABLE t_pl_email;

CREATE TABLE t_pl_email (
    id_email   INT NOT NULL,
    id_cliente INT NOT NULL,
    nm_email   NVARCHAR(150) NOT NULL,
    ds_email   NVARCHAR(30) NOT NULL,
    st_email   NVARCHAR(20) NOT NULL,
    CONSTRAINT t_pl_email_pk PRIMARY KEY (id_email),
    CONSTRAINT fk_email_cliente FOREIGN KEY (id_cliente) REFERENCES t_pl_cliente(id_cliente)
);

IF OBJECT_ID('t_pl_endereco_cliente', 'U') IS NOT NULL
    DROP TABLE t_pl_endereco_cliente;

CREATE TABLE t_pl_endereco_cliente (
    id_endereco_cliente INT NOT NULL,
    id_cliente          INT NOT NULL,
    nm_rua              NVARCHAR(50) NOT NULL,
    nr_residencia       NVARCHAR(50) NOT NULL,
    nm_bairro           NVARCHAR(30) NOT NULL,
    CONSTRAINT t_endereco_cliente_pk PRIMARY KEY (id_endereco_cliente),
    CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES t_pl_cliente(id_cliente)
);

IF OBJECT_ID('t_pl_pagamento', 'U') IS NOT NULL
    DROP TABLE t_pl_pagamento;

CREATE TABLE t_pl_pagamento (
    id_pagamento   INT NOT NULL,
    id_produto     INT NOT NULL,
    nm_cartao      NVARCHAR(100) NOT NULL,
    nr_cartao      BIGINT NOT NULL,
    ds_desc_cartao NVARCHAR(100) NOT NULL,
    dt_inicio      DATE NOT NULL,
    CONSTRAINT t_pl_pagamento_pk PRIMARY KEY (id_pagamento),
    CONSTRAINT fk_produto_pagamento FOREIGN KEY (id_produto) REFERENCES t_pl_produto(id_produto)
);

IF OBJECT_ID('t_pl_telefone', 'U') IS NOT NULL
    DROP TABLE t_pl_telefone;

CREATE TABLE t_pl_telefone (
    id_telefone INT NOT NULL,
    id_cliente  INT NOT NULL,
    nr_telefone BIGINT NOT NULL,
    nr_ddd      INT NOT NULL,
    ds_telefone NVARCHAR(50) NOT NULL,
    CONSTRAINT t_pl_telefone_pk PRIMARY KEY (id_telefone),
    CONSTRAINT fk_telefone_cliente FOREIGN KEY (id_cliente) REFERENCES t_pl_cliente(id_cliente)
);
