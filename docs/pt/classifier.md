# Classificador de humor

O Viktor classifica sua resposta a *"How was your day?"* como `positive`,
`negative` ou `neutral`, usando um modelo Naive Bayes treinado na inicialização a
partir de um arquivo JSON.

## Arquivos relevantes

| Arquivo | Papel |
| --- | --- |
| `src/services/analyzer.rb` | Carrega o arquivo de treino, expõe `classify(text)` |
| `src/models/bayes.rb` | A implementação do Naive Bayes |
| `data/day.json` | Exemplos de treino |
| `spec/services/analyzer_spec.rb`, `spec/models/bayes_spec.rb` | Testes |

## Como funciona

1. **Sanitização** — o texto vai para minúsculas e todo caractere não alfanumérico
   (exceto espaço) é removido. Os acentos sobrevivem, porque `\p{Alnum}` entende
   Unicode: `incrível` continua sendo um token só.
2. **Tokenização** — o texto é quebrado por `\p{Alnum}+`, virando um saco de
   palavras. A ordem é ignorada, e palavras não vistas no treino também.
3. **Pontuação** — cada categoria recebe `log(prior) + Σ log(verossimilhança)`,
   somado em espaço logarítmico para evitar underflow em frases longas.
4. **Escolha** — vence a categoria de maior pontuação.

Onde:

- `prior(categoria)` = documentos da categoria ÷ total de documentos
- `verossimilhança(palavra, categoria)` = `(ocorrências + 1) / (palavras da categoria + tamanho do vocabulário)`

O `+1` é a suavização de Laplace: impede que uma palavra desconhecida zere uma
categoria inteira. Uma frase totalmente desconhecida cai nos priors, então a
categoria com mais exemplos de treino ganha por padrão.

## Dados de treino

`data/day.json` é uma lista de objetos com dois campos:

- `text` — uma frase de exemplo
- `category` — `positive`, `negative` ou `neutral`

```json
[
  { "text": "hoje foi um dia incrível, me sinto muito bem", "category": "positive" },
  { "text": "estou exausto e desanimado", "category": "negative" },
  { "text": "just a normal day", "category": "neutral" }
]
```

Ele vem com 92 exemplos distribuídos nas três categorias, em português e inglês,
que é por que o Viktor entende os dois idiomas.

## Melhorando a precisão

Adicione exemplos com as suas palavras. Frases que você realmente digita valem
muito mais do que frases genéricas.

1. Acrescente entradas em `data/day.json`, mantendo as categorias equilibradas —
   uma categoria inflada vence os empates pelo prior.
2. Prefira frases curtas e naturais às longas; cada palavra pesa igual.
3. Reinicie o Viktor. O treino acontece uma vez, no construtor, então uma sessão
   já aberta não enxerga suas edições.

Para testar outro conjunto sem mexer no padrão, aponte o `main.rb` para outro
arquivo — `SentimentAnalyzer.new('data/day.json')` aceita qualquer caminho.

## Limitações conhecidas

- Saco de palavras: *"não foi um bom dia"* e *"foi um bom dia"* ficam quase
  idênticos, já que a negação é só mais um token.
- Sem radicalização: `cansado` e `cansada` são tokens diferentes, e cada um
  precisa dos próprios exemplos.
- Misturar idiomas na mesma frase funciona, mas só para palavras vistas no treino.
- `classify` levanta `No training data available` se o modelo nunca foi treinado,
  o que na prática significa arquivo de treino vazio ou ilegível.
