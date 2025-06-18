-- SCRIPT DE CRIAÇÃO DAS TABELAS DO PROJETO HORA DO LIXO

-- Criação da Tabela de Zonas de Coleta Comum
CREATE TABLE dbo.ZonaColetaComum (
    id_zona_coleta_comum INT PRIMARY KEY IDENTITY(1,1),
    nome_zona NVARCHAR(150) NOT NULL UNIQUE
);
GO

-- Criação da Tabela de Zonas de Coleta Seletiva
CREATE TABLE dbo.ZonaColetaSeletiva (
    id_zona_coleta_seletiva INT PRIMARY KEY IDENTITY(1,1),
    nome_zona NVARCHAR(150) NOT NULL UNIQUE
);
GO

-- Criação da Tabela de Programação da Coleta Comum
CREATE TABLE dbo.ProgramacaoColetaComum (
    id_coleta_comum INT PRIMARY KEY IDENTITY(1,1),
    id_zona_coleta_comum INT NOT NULL,
    dia_semana INT NOT NULL,
    horario_inicio_previsto TIME NOT NULL,
    observacoes NVARCHAR(255) NULL,
    CONSTRAINT FK_Programacao_Zona_Comum FOREIGN KEY (id_zona_coleta_comum) REFERENCES dbo.ZonaColetaComum(id_zona_coleta_comum)
);
GO

-- Criação da Tabela de Programação da Coleta Seletiva
CREATE TABLE dbo.ProgramacaoColetaSeletiva (
    id_coleta_seletiva INT PRIMARY KEY IDENTITY(1,1),
    id_zona_coleta_seletiva INT NOT NULL,
    dia_semana INT NOT NULL,
    horario_inicio_previsto TIME NOT NULL,
    observacoes NVARCHAR(255) NULL,
    CONSTRAINT FK_Programacao_Zona_Seletiva FOREIGN KEY (id_zona_coleta_seletiva) REFERENCES dbo.ZonaColetaSeletiva(id_zona_coleta_seletiva)
);
GO

-- =====================================================================
-- SCRIPT PARA INSERIR AS ZONAS DE COLETA COMUM
-- Dados extraídos de regioes_coleta_pap.json
-- =====================================================================

-- Inserindo as 5 regiões na tabela de Zonas Comuns
-- Os IDs serão gerados automaticamente (1 para REGIÃO 01, 2 para REGIÃO 02, etc.)
INSERT INTO dbo.ZonaColetaComum (nome_zona) VALUES
('REGIÃO 01'),
('REGIÃO 02'),
('REGIÃO 03'),
('REGIÃO 04'),
('REGIÃO 05');
GO

-- =====================================================================
-- SCRIPT PARA INSERIR A PROGRAMAÇÃO DAS ZONAS COMUNS
-- dia_semana: 1=Seg, 2=Ter, 3=Qua, 4=Qui, 5=Sex, 6=Sáb, 7=Dom
-- =====================================================================

-- Programação para 'REGIÃO 01' (ID=1): Diariamente, noturno, a partir das 19h
INSERT INTO dbo.ProgramacaoColetaComum (id_zona_coleta_comum, dia_semana, horario_inicio_previsto, observacoes) VALUES
(1, 1, '19:00:00', 'Coleta noturna diária'), -- Segunda
(1, 2, '19:00:00', 'Coleta noturna diária'), -- Terça
(1, 3, '19:00:00', 'Coleta noturna diária'), -- Quarta
(1, 4, '19:00:00', 'Coleta noturna diária'), -- Quinta
(1, 5, '19:00:00', 'Coleta noturna diária'), -- Sexta
(1, 6, '19:00:00', 'Coleta noturna diária'), -- Sábado
(1, 7, '19:00:00', 'Coleta noturna diária'); -- Domingo
GO

-- Programação para 'REGIÃO 02' (ID=2): Seg, Qua, Sex, noturno, a partir das 19h
INSERT INTO dbo.ProgramacaoColetaComum (id_zona_coleta_comum, dia_semana, horario_inicio_previsto, observacoes) VALUES
(2, 1, '19:00:00', 'Coleta noturna às segundas, quartas e sextas'),
(2, 3, '19:00:00', 'Coleta noturna às segundas, quartas e sextas'),
(2, 5, '19:00:00', 'Coleta noturna às segundas, quartas e sextas');
GO

-- Programação para 'REGIÃO 03' (ID=3): Ter, Qui, Sab, noturno, a partir das 19h
INSERT INTO dbo.ProgramacaoColetaComum (id_zona_coleta_comum, dia_semana, horario_inicio_previsto, observacoes) VALUES
(3, 2, '19:00:00', 'Coleta noturna às terças, quintas e sábados'),
(3, 4, '19:00:00', 'Coleta noturna às terças, quintas e sábados'),
(3, 6, '19:00:00', 'Coleta noturna às terças, quintas e sábados');
GO

-- Programação para 'REGIÃO 04' (ID=4): Seg, Qua, Sex, diurno, a partir das 7h
INSERT INTO dbo.ProgramacaoColetaComum (id_zona_coleta_comum, dia_semana, horario_inicio_previsto, observacoes) VALUES
(4, 1, '07:00:00', 'Coleta diurna às segundas, quartas e sextas'),
(4, 3, '07:00:00', 'Coleta diurna às segundas, quartas e sextas'),
(4, 5, '07:00:00', 'Coleta diurna às segundas, quartas e sextas');
GO

-- Programação para 'REGIÃO 05' (ID=5): Ter, Qui, Sab, diurno, a partir das 7h
INSERT INTO dbo.ProgramacaoColetaComum (id_zona_coleta_comum, dia_semana, horario_inicio_previsto, observacoes) VALUES
(5, 2, '07:00:00', 'Coleta diurna às terças, quintas e sábados'),
(5, 4, '07:00:00', 'Coleta diurna às terças, quintas e sábados'),
(5, 6, '07:00:00', 'Coleta diurna às terças, quintas e sábados');
GO


