-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS trab_bi;
USE trab_bi;
CREATE TABLE dim_usuario (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    pais_usuario VARCHAR(100),
    genero_usuario ENUM('Masculino', 'Feminino', 'Outro'),
    faixa_etaria_usuario VARCHAR(20)
);

CREATE TABLE dim_musica (
    musica_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200),
    artista VARCHAR(100),
    album VARCHAR(100),
    categoria VARCHAR(50)
);

CREATE TABLE dim_data (
    data_id INT AUTO_INCREMENT PRIMARY KEY,
    dt DATE,
    dia_semana VARCHAR(10),
    mes INT,
    ano INT
);

CREATE TABLE dim_gravadora (
    gravadora_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    pais VARCHAR(100)
);

CREATE TABLE dim_tipo_assinatura (
    tipo_assinatura_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) -- Ex.: Básica, Premium, Família
);

CREATE TABLE dim_tipo_royalty (
    tipo_royalty_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) -- Ex.: Execução, Licença Fixa
);

CREATE TABLE fato_execucao_musica (
    execucao_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    musica_id INT,
    data_id INT,
    localizacao VARCHAR(100),
    dispositivo VARCHAR(50),
    duracao_segundos INT,
    FOREIGN KEY (usuario_id) REFERENCES dim_usuario(usuario_id),
    FOREIGN KEY (musica_id) REFERENCES dim_musica(musica_id),
    FOREIGN KEY (data_id) REFERENCES dim_data(data_id)
);

CREATE TABLE fato_pagamento_royalties (
    pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    musica_id INT,
    gravadora_id INT,
    tipo_royalty_id INT,
    data_id INT,
    valor_pago DECIMAL(10, 2),
    quantidade_execucoes INT,
    FOREIGN KEY (musica_id) REFERENCES dim_musica(musica_id),
    FOREIGN KEY (gravadora_id) REFERENCES dim_gravadora(gravadora_id),
    FOREIGN KEY (tipo_royalty_id) REFERENCES dim_tipo_royalty(tipo_royalty_id),
    FOREIGN KEY (data_id) REFERENCES dim_data(data_id)
);

CREATE TABLE fato_pagamento_assinatura (
    pagamento_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    tipo_assinatura_id INT,
    data_id INT,
    metodo_pagamento VARCHAR(50),
    valor_pago DECIMAL(10, 2),
    FOREIGN KEY (usuario_id) REFERENCES dim_usuario(usuario_id),
    FOREIGN KEY (tipo_assinatura_id) REFERENCES dim_tipo_assinatura(tipo_assinatura_id),
    FOREIGN KEY (data_id) REFERENCES dim_data(data_id)
);
