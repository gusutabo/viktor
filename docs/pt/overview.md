# Visão geral

Viktor é um assistente diário silencioso para acompanhar sua saúde. Ele registra como você se sentiu, seu peso, sono, exercícios e refeições e gera relatórios semanais e mensais.

## Recursos

- Registro diário de saúde
- Classificação de humor em `positive`, `negative` ou `neutral`
- Relatório semanal com médias e categoria de IMC
- Relatório mensal com tendência de IMC
- Armazenamento em arquivos JSON
- Reconhecimento de entradas em inglês e português

## Requisitos

- Ruby 3.0 ou superior
- Bundler

## Arquivos principais

- `src/main.rb` - ponto de entrada
- `src/controllers/assistant.rb` - fluxo de execução e lógica de menu
- `src/views/cli.rb` - entrada e saída do usuário
- `src/services/analyzer.rb` - interface do classificador de humor
- `src/models/bayes.rb` - algoritmo Naive Bayes
- `src/models/health.rb` - cálculo de IMC e categoria
- `src/services/storage.rb` - leitura e escrita de JSON
