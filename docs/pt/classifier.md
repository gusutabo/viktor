# Classificador de humor

O Viktor usa um classificador Naive Bayes para categorizar a resposta do usuário sobre o dia em `positive`, `negative` ou `neutral`.

## Arquivos relevantes

- `src/services/analyzer.rb` - carrega o arquivo de treinamento e expõe `classify(text)`
- `src/models/bayes.rb` - implementa o classificador Naive Bayes
- `models/day.json` - dados de treinamento para o classificador

## Como o classificador funciona

1. O texto é sanitizado para minúsculas e remoção de caracteres não alfanuméricos.
2. Cada palavra é tokenizada pelo regex `\p{Alnum}+`.
3. O modelo calcula a probabilidade posterior de cada categoria com suavização de Laplace.
4. A categoria com maior pontuação é retornada.

## Formato de treinamento

O arquivo `models/day.json` deve conter uma lista de objetos JSON com campos:

- `text` - frase de exemplo
- `category` - `positive`, `negative` ou `neutral`

Exemplo:

```json
[
  { "text": "today was amazing", "category": "positive" },
  { "text": "foi um dia horrível", "category": "negative" },
  { "text": "just a normal day", "category": "neutral" }
]
```

## Extensões

Adicionar mais exemplos de texto em `models/day.json` melhora a precisão do classificador, especialmente para o estilo de linguagem do usuário.
