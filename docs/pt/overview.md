# Visão geral

Viktor é um assistente diário silencioso para acompanhar sua saúde. Ele pergunta
como foi o seu dia, registra peso, sono, exercício e refeições, e transforma esses
registros em relatórios semanais e mensais.

Roda inteiramente no terminal. Não tem conta, não acessa a rede e não usa banco de
dados — cada registro é um arquivo JSON dentro de `logs/`, que fica fora do git.

## Como é uma sessão

1. O Viktor te cumprimenta (na primeira vez, pergunta nome, idade, altura e local).
2. Pergunta *"How was your day?"* e classifica sua resposta como `positive`,
   `negative` ou `neutral`.
3. Mostra o menu: registrar os números do dia, gerar relatório semanal, gerar
   relatório mensal ou sair.
4. O menu se repete até você escolher **Quit**.

Passo a passo completo em [uso](usage.md).

## Recursos

- Registro diário de humor, peso, horas de sono, exercício e número de refeições
- Classificação de humor com Naive Bayes treinado em `data/day.json`
- Relatório semanal: médias dos últimos 7 registros diários, mais IMC e categoria
- Relatório mensal: médias dos últimos 4 relatórios semanais, mais tendência de IMC
- Armazenamento em JSON legível, que você pode ler, editar, copiar ou apagar à mão
- Dados de treino com exemplos em português e inglês

## Requisitos

- Ruby 3.0 ou superior
- Bundler

## Arquivos principais

| Arquivo | Responsabilidade |
| --- | --- |
| `src/main.rb` | Ponto de entrada; monta os objetos e inicia o assistente |
| `src/controllers/assistant.rb` | Fluxo de execução, menu e relatórios |
| `src/views/cli.rb` | Entrada e saída no terminal |
| `src/services/analyzer.rb` | Carrega os dados de treino, expõe `classify(text)` |
| `src/models/bayes.rb` | O algoritmo Naive Bayes em si |
| `src/models/health.rb` | Cálculo de IMC e categoria |
| `src/services/storage.rb` | Leitura e escrita de JSON |
| `data/day.json` | Exemplos de treino do classificador de humor |

Como tudo se encaixa: [arquitetura](architecture.md).

## O que o Viktor não é

- Não é orientação médica. As faixas de IMC seguem os intervalos usuais da OMS e
  não dizem nada sobre um indivíduo específico.
- Não é multiusuário. Um perfil por cópia do projeto, em `logs/config.json`.
- Não sincroniza com lugar nenhum. Apagou `logs/`, perdeu o histórico.
