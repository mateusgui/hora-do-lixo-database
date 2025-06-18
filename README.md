# Banco de Dados do Projeto "Hora do Lixo"

Este repositório armazena o script SQL para a criação da estrutura (schema) e o povoamento com dados iniciais do banco de dados utilizado no projeto de extensão "Hora do Lixo".

O projeto principal visa solucionar a comunicação deficiente sobre os horários da coleta de lixo em Campo Grande, MS, através de uma aplicação web informativa. Este repositório foca exclusivamente na modelagem e nos dados do banco de dados relacional que suportará a aplicação.

## Estrutura e Evidências do Banco de Dados

O script `schema.sql` neste repositório é responsável por criar toda a estrutura de tabelas e inserir os dados iniciais de programação das coletas. Abaixo estão as evidências da criação e povoamento do banco de dados `HoraDoLixoDB`.

### Tabelas Criadas

A imagem abaixo mostra as 5 tabelas do projeto criadas com sucesso no SQL Server Management Studio

![Visualização das tabelas criadas no SSMS](./assets/todas-as-tabelas.png)

### Dados Inseridos (Exemplos via `SELECT *`)

As tabelas de zonas e programações foram populadas com dados baseados nas informações de coleta de lixo comum e seletivo de Campo Grande/MS, dados coletados no site oficial da SOLURB.

**1. Zonas de Coleta Comum**
![Dados da Tabela ZonaColetaComum](./assets/select-ZonaColetaComum.png)

**2. Programação da Coleta Comum**
![Dados da Tabela ProgramacaoColetaComum](./assets/select-ProgramacaoColetaComum.png)

**3. Zonas de Coleta Seletiva**
![Dados da Tabela ZonaColetaSeletiva](./assets/select-ZonaColetaSeletiva.png)

**4. Programação da Coleta Seletiva**
![Dados da Tabela ProgramacaoColetaSeletiva](./assets/select-ProgramacaoColetaSeletiva.png)

## Conteúdo do Script `schema.sql`

O arquivo `schema.sql` contido neste repositório é o único arquivo necessário para construir o banco de dados do zero. Ele inclui:

* **Comandos `CREATE TABLE`:** Para criar todas as tabelas (`Usuario`, `ZonaColetaComum`, `ZonaColetaSeletiva`, etc.) com suas colunas, tipos de dados, chaves primárias (PK) e chaves estrangeiras (FK).
* **Comandos `INSERT INTO`:** Para popular as tabelas de zonas e programações com dados iniciais das coletas comum e seletiva.

## Autor

**Mateus Guimarães Moraes Vilela**