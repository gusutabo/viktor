# Uso

## Primeiro uso

Ao iniciar o Viktor pela primeira vez, ele solicitará informações do usuário:

- nome
- idade
- altura
- localidade

Esses dados são salvos em `logs/config.json` e reutilizados nas próximas execuções.

## Fluxo diário

Ao iniciar após a primeira configuração, o Viktor pergunta:

- "How was your day?"

A resposta é classificada como `positive`, `negative` ou `neutral`.

## Menu principal

O assistente oferece as seguintes opções:

1. Daily status
2. Weekly report
3. Monthly report
4. Quit

### Daily status

Registra os dados do dia:

- peso em kg
- horas de sono
- se praticou exercício (`Y` / `N`)
- número de refeições

Os dados são salvos em `logs/daily/YYYY-MM-DD.json`.

### Weekly report

Gera um relatório com os últimos 7 registros diários. O relatório inclui:

- média de peso
- média de sono
- média de refeições
- dias com exercício
- humor predominante
- IMC atual
- categoria de IMC

O relatório é salvo em `logs/weekly/YYYY-MM-DD.json`.

### Monthly report

Gera um relatório com os últimos 4 relatórios semanais. O relatório inclui:

- média de peso semanal
- média de sono semanal
- média de refeições semanal
- total de dias de exercício
- humor predominante
- IMC atual
- evolução do IMC
- tendência de IMC (`increased`, `decreased`, `stable`)

O relatório é salvo em `logs/monthly/YYYY-MM-DD.json`.
