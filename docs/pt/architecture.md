# Arquitetura

O Viktor é organizado em camadas simples que separam interface, lógica de negócios e persistência.

## `src/main.rb`

- Inicializa os componentes principais
- Cria `Cli`, `Storage`, `SentimentAnalyzer` e `Health`
- Inicia o assistente com `Assistant.new(...).greet`

## `src/controllers/assistant.rb`

- Controla o fluxo da aplicação
- Gerencia execução do menu e relatórios
- Carrega e salva configurações
- Usa `Storage` para persistir JSON
- Usa `Health` para calcular IMC
- Usa `SentimentAnalyzer` para classificar o humor

## `src/views/cli.rb`

- Trata entrada e saída do usuário pelo terminal
- Exibe prompts e menus
- Interpreta respostas `Y/N`

## `src/services/analyzer.rb`

- Lê o arquivo `models/day.json`
- Treina o classificador Naive Bayes
- Sanitiza e classifica texto do usuário

## `src/models/bayes.rb`

- Implementa o classificador Naive Bayes
- Usa tokenização simples e suavização de Laplace
- Calcula probabilidades a partir de dados de treino

## `src/models/health.rb`

- Calcula IMC: peso / altura²
- Retorna categoria de IMC conforme faixas definidas

## `src/services/storage.rb`

- Salva dados em JSON formatado
- Carrega dados se o arquivo existir
- Cria diretórios necessários automaticamente
