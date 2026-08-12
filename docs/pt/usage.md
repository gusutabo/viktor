# Uso

```bash
bundle exec ruby src/main.rb
```

## Primeiro uso

Sem `logs/config.json`, o Viktor faz quatro perguntas:

| Pergunta | Salvo como | Tipo |
| --- | --- | --- |
| What is your name? | `name` | texto |
| How old are you? | `age` | número inteiro |
| What is your height? (e.g. 1.75) | `height` | metros, decimal |
| Where are you from? | `local` | texto |

As respostas vão para `logs/config.json` e são reaproveitadas nas execuções
seguintes. A altura é guardada em metros porque o IMC é `peso / altura²` —
digitar `175` em vez de `1.75` produz valores sem sentido.

```json
{
  "name": "Ana",
  "age": 31,
  "height": 1.68,
  "local": "Recife"
}
```

Nas próximas execuções o Viktor pula essas perguntas e cumprimenta você pelo nome.

## A pergunta sobre o dia

Logo após o cumprimento, o Viktor pergunta **"How was your day?"**, classifica a
resposta e responde de acordo:

| Classificação | Resposta |
| --- | --- |
| `positive` | Glad to hear that. |
| `negative` | Hope things get better. |
| `neutral` | Got it. |

Responda em português ou inglês — os dados de treino cobrem os dois. A pergunta é
feita **uma vez por sessão**, e esse único resultado é o humor anexado a qualquer
registro diário salvo depois. Veja [classificador](classifier.md).

## Menu principal

```
[0] Daily status
[1] Weekly report
[2] Monthly report
[3] Quit
```

Digite o número e pressione Enter. Qualquer outra coisa imprime `Invalid option.`
e o menu se repete. O menu continua em laço até você escolher **Quit**.

### Daily status

Registra os números de hoje:

| Pergunta | Chave | Tipo |
| --- | --- | --- |
| What is your weight? (kg) | `weight` | número inteiro |
| How many hours did you sleep? | `sleep_h` | número inteiro |
| Did you work out today? [Y/N] | `exercise` | `true` / `false` |
| How many meals did you have today? | `meal_c` | número inteiro |

Salvo em `logs/daily/YYYY-MM-DD.json`, junto com o humor da sessão:

```json
{
  "mood": "positive",
  "weight": 72,
  "sleep_h": 7,
  "exercise": true,
  "meal_c": 3
}
```

Sobre a leitura das respostas:

- Peso e sono são lidos como inteiros — `72.4` vira `72`.
- Só `y` e `yes` (em qualquer caixa) contam como sim; o resto vira `false`.
- Rodar duas vezes no mesmo dia sobrescreve o arquivo daquele dia.

### Weekly report

Montado com os **7 arquivos mais recentes** de `logs/daily/`, escolhidos pela
ordem do nome. Ele não verifica se os dias são consecutivos — havendo lacunas, "a
última semana" é simplesmente os últimos sete registros existentes. Sem nenhum
registro diário, imprime `No daily records found.`

| Chave | Significado |
| --- | --- |
| `average_weight` | Peso médio dos registros |
| `average_sleep` | Média de horas de sono |
| `meal_avg` | Média de refeições |
| `exercise_days` | Quantos registros tinham `exercise: true` |
| `predominant_mood` | Humor mais frequente |
| `bmi` | IMC a partir do peso **mais recente** e da altura do perfil |
| `bmi_category` | Veja a tabela abaixo |

```json
{
  "average_weight": 72.14,
  "average_sleep": 7.29,
  "meal_avg": 3.0,
  "exercise_days": 4,
  "predominant_mood": "positive",
  "bmi": 25.55,
  "bmi_category": "overweight"
}
```

É impresso na tela e salvo em `logs/weekly/YYYY-MM-DD.json`. As médias são
arredondadas para duas casas.

### Monthly report

Montado com os **4 arquivos mais recentes** de `logs/weekly/` — então gere os
relatórios semanais antes, senão ele imprime `No weekly reports found.`

| Chave | Significado |
| --- | --- |
| `average_weight` | Média dos pesos médios semanais |
| `average_sleep` | Média do sono médio semanal |
| `average_meals` | Média das médias semanais de refeições |
| `total_exercise_days` | Soma dos dias com exercício nas semanas |
| `predominant_mood` | Humor predominante mais frequente entre as semanas |
| `current_bmi` | IMC do relatório semanal mais recente |
| `bmi_evolution` | IMC mais novo menos o mais antigo, com duas casas |
| `bmi_trend` | `increased`, `decreased` ou `stable` |

```json
{
  "average_weight": 72.4,
  "average_sleep": 7.1,
  "average_meals": 3.02,
  "total_exercise_days": 15,
  "predominant_mood": "positive",
  "current_bmi": 25.55,
  "bmi_evolution": -0.31,
  "bmi_trend": "decreased"
}
```

Salvo em `logs/monthly/YYYY-MM-DD.json`.

## Categorias de IMC

O IMC é `peso / altura²`, com peso em quilos e altura em metros.

| IMC | Categoria |
| --- | --- |
| abaixo de 18,5 | `underweight` |
| 18,5 – 24,9 | `healthy` |
| 25 – 29,9 | `overweight` |
| 30 – 34,9 | `obese1` |
| 35 – 39,9 | `obese2` |
| 40 ou mais | `obese3` |

São faixas populacionais, não um diagnóstico.

## Editando seus dados

Todo arquivo é JSON legível. Corrija um peso digitado errado, ajuste sua altura em
`logs/config.json` ou apague um dia ruim — o Viktor considera a mudança no próximo
relatório. Mantenha os nomes dos campos e o padrão `YYYY-MM-DD.json`.
