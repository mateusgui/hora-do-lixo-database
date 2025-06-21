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

CREATE TABLE Usuario (
    id_usuario UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    nome_completo NVARCHAR(255) NOT NULL,
    email NVARCHAR(255) NOT NULL UNIQUE,
    senha_hash NVARCHAR(MAX) NOT NULL,
    endereco_rua NVARCHAR(255) NULL,
    endereco_numero NVARCHAR(8) NULL,
    endereco_complemento NVARCHAR(100) NULL,
    endereco_bairro NVARCHAR(100) NULL,
    cep CHAR(8) NULL,
    id_zona_coleta_comum INT NULL,
    id_zona_coleta_seletiva INT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT GETDATE(),
    status BIT NOT NULL DEFAULT 1,
    horario_alerta_comum TIME NULL,
    alerta_comum_ativo BIT NOT NULL DEFAULT 0,
    horario_alerta_seletiva TIME NULL,
    alerta_seletiva_ativo BIT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Usuario_Zona_Comum FOREIGN KEY (id_zona_coleta_comum) 
    REFERENCES dbo.ZonaColetaComum(id_zona_coleta_comum),
    CONSTRAINT FK_Usuario_Zona_Seletiva FOREIGN KEY (id_zona_coleta_seletiva) 
    REFERENCES dbo.ZonaColetaSeletiva(id_zona_coleta_seletiva)
);
GO

-- =====================================================================
-- SCRIPT PARA INSERIR AS ZONAS DE COLETA COMUM
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

-- =====================================================================
-- SCRIPT PARA INSERIR AS ZONAS DE COLETA SELETIVA
-- =====================================================================

INSERT INTO dbo.ZonaColetaSeletiva (nome_zona) VALUES
('coleta_seletiva_1'), ('coleta_seletiva_2'), ('coleta_seletiva_3'), ('coleta_seletiva_4'), ('coleta_seletiva_5'),
('coleta_seletiva_6'), ('coleta_seletiva_7'), ('coleta_seletiva_8'), ('coleta_seletiva_9'), ('coleta_seletiva_10'),
('coleta_seletiva_11'), ('coleta_seletiva_12'), ('coleta_seletiva_13'), ('coleta_seletiva_14'), ('coleta_seletiva_15'),
('coleta_seletiva_16'), ('coleta_seletiva_17'), ('coleta_seletiva_18'), ('coleta_seletiva_19'), ('coleta_seletiva_20'),
('coleta_seletiva_21'), ('coleta_seletiva_22'), ('coleta_seletiva_23'), ('coleta_seletiva_24'), ('coleta_seletiva_25'),
('coleta_seletiva_26'), ('coleta_seletiva_27'), ('coleta_seletiva_28'), ('coleta_seletiva_29'), ('coleta_seletiva_30'),
('coleta_seletiva_31'), ('coleta_seletiva_32'), ('coleta_seletiva_33'), ('coleta_seletiva_34'), ('coleta_seletiva_35'),
('coleta_seletiva_36'), ('coleta_seletiva_37'), ('coleta_seletiva_38'), ('coleta_seletiva_39'), ('coleta_seletiva_40'),
('coleta_seletiva_41'), ('coleta_seletiva_42'), ('coleta_seletiva_43'), ('coleta_seletiva_44'), ('coleta_seletiva_45');
GO

-- =====================================================================
-- SCRIPT PARA INSERIR A PROGRAMAÇÃO DAS ZONAS SELETIVAS
-- dia_semana: 1=Seg, 2=Ter, 3=Qua, 4=Qui, 5=Sex, 6=Sáb
-- =====================================================================

-- Prog. para 'coleta_seletiva_1' (ID=1): Seg e Qui, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(1, 1, '18:00:00', 'Região atendida às segundas e quintas-feiras, período noturno.'),
(1, 4, '18:00:00', 'Região atendida às segundas e quintas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_2' (ID=2): Ter e Sex, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(2, 2, '18:00:00', 'Região atendida às terças e sextas-feiras, período noturno.'),
(2, 5, '18:00:00', 'Região atendida às terças e sextas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_3' (ID=3): Qua e Sáb, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(3, 3, '18:00:00', 'Região atendida às quartas-feiras e aos sábados, período noturno.'),
(3, 6, '18:00:00', 'Região atendida às quartas-feiras e aos sábados, período noturno.');
GO
-- Prog. para 'coleta_seletiva_4' (ID=4): Qui, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(4, 4, '18:00:00', 'Região atendida às quintas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_5' (ID=5): Qui, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(5, 4, '07:00:00', 'Região atendida às quintas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_6' (ID=6): Qui, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(6, 4, '07:00:00', 'Região atendida às quintas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_7' (ID=7): Sáb, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(7, 6, '18:00:00', 'Região atendida aos sábados, período noturno.');
GO
-- Prog. para 'coleta_seletiva_8' (ID=8): Qui, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(8, 4, '18:00:00', 'Região atendida às quintas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_9' (ID=9): Sáb, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(9, 6, '07:00:00', 'Região atendida aos sábados, período diurno.');
GO
-- Prog. para 'coleta_seletiva_10' (ID=10): Sáb, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(10, 6, '18:00:00', 'Região atendida aos sábados, período noturno.');
GO
-- Prog. para 'coleta_seletiva_11' (ID=11): Qua, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(11, 3, '07:00:00', 'Região atendida às quartas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_12' (ID=12): Sex, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(12, 5, '18:00:00', 'Região atendida às sextas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_13' (ID=13): Qua, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(13, 3, '18:00:00', 'Região atendida às quartas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_14' (ID=14): Seg, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(14, 1, '18:00:00', 'Região atendida às segundas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_15' (ID=15): Qua, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(15, 3, '07:00:00', 'Região atendida às quartas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_16' (ID=16): Sex, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(16, 5, '07:00:00', 'Região atendida às sextas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_17' (ID=17): Sex, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(17, 5, '18:00:00', 'Região atendida às sextas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_18' (ID=18): Qua, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(18, 3, '18:00:00', 'Região atendida às quartas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_19' (ID=19): Qua, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(19, 3, '18:00:00', 'Região atendida às quartas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_20' (ID=20): Seg, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(20, 1, '18:00:00', 'Região atendida às segundas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_21' (ID=21): Seg, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(21, 1, '18:00:00', 'Região atendida às segundas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_22' (ID=22): Ter, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(22, 2, '07:00:00', 'Região atendida às terças-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_23' (ID=23): Ter, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(23, 2, '07:00:00', 'Região atendida às terças-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_24' (ID=24): Seg, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(24, 1, '07:00:00', 'Região atendida às segundas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_25' (ID=25): Seg, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(25, 1, '07:00:00', 'Região atendida às segundas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_26' (ID=26): Ter, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(26, 2, '18:00:00', 'Região atendida às terças-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_27' (ID=27): Qui, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(27, 4, '18:00:00', 'Região atendida às quintas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_28' (ID=28): Ter, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(28, 2, '18:00:00', 'Região atendida às terças-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_29' (ID=29): Ter, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(29, 2, '18:00:00', 'Região atendida às terças-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_30' (ID=30): Seg, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(30, 1, '07:00:00', 'Região atendida às segundas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_31' (ID=31): Ter, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(31, 2, '07:00:00', 'Região atendida às terças-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_32' (ID=32): Qua, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(32, 3, '07:00:00', 'Região atendida às quartas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_33' (ID=33): Sex, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(33, 5, '07:00:00', 'Região atendida às sextas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_34' (ID=34): Sex, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(34, 5, '07:00:00', 'Região atendida às sextas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_35' (ID=35): Seg, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(35, 1, '07:00:00', 'Região atendida às segundas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_36' (ID=36): Ter, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(36, 2, '07:00:00', 'Região atendida às terças-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_37' (ID=37): Sáb, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(37, 6, '07:00:00', 'Região atendida aos sábados, período diurno.');
GO
-- Prog. para 'coleta_seletiva_38' (ID=38): Sáb, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(38, 6, '07:00:00', 'Região atendida aos sábados, período diurno.');
GO
-- Prog. para 'coleta_seletiva_39' (ID=39): Qui, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(39, 4, '07:00:00', 'Região atendida às quintas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_40' (ID=40): Sex, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(40, 5, '07:00:00', 'Região atendida às sextas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_41' (ID=41): Sex, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(41, 5, '18:00:00', 'Região atendida às sextas-feiras, período noturno.');
GO
-- Prog. para 'coleta_seletiva_42' (ID=42): Qua, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(42, 3, '07:00:00', 'Região atendida às quartas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_43' (ID=43): Qui, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(43, 4, '07:00:00', 'Região atendida às quintas-feiras, período diurno.');
GO
-- Prog. para 'coleta_seletiva_44' (ID=44): Sáb, diurno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(44, 6, '07:00:00', 'Região atendida aos sábados, período diurno.');
GO
-- Prog. para 'coleta_seletiva_45' (ID=45): Sáb, noturno
INSERT INTO dbo.ProgramacaoColetaSeletiva (id_zona_coleta_seletiva, dia_semana, horario_inicio_previsto, observacoes) VALUES
(45, 6, '18:00:00', 'Região atendida aos sábados, período noturno.');
GO

