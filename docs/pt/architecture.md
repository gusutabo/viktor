# Arquitetura

O Viktor separa interface, controle de fluxo, lógica de domínio e persistência.
Cada classe faz uma coisa e recebe seus colaboradores de fora, que é o que torna
os testes em `spec/` fáceis de escrever.

## Fluxo

```
main.rb
  monta Cli, Storage, SentimentAnalyzer, Health
  └── Assistant#greet
        ├── Cli            pergunta e imprime
        ├── SentimentAnalyzer → Bayes    classifica o dia
        ├── Health                       IMC e categoria
        └── Storage                      lê e escreve JSON em logs/
```

`Assistant` é a única classe que conhece a sequência de passos. `Cli` não sabe
nada sobre saúde, `Health` não sabe nada sobre arquivos e `Storage` não sabe o que
está guardando.

## `src/main.rb`

Ponto de entrada, protegido por `if __FILE__ == $PROGRAM_NAME`. Monta os quatro
colaboradores, injeta em `Assistant` e chama `greet`. O caminho do arquivo de
treino (`data/day.json`) é definido aqui.

## `src/controllers/assistant.rb`

Dono do fluxo da aplicação.

- `greet` — cumprimenta você, ou faz as perguntas iniciais; pergunta o humor e entra no laço do menu
- `first_run` — coleta o perfil e salva `logs/config.json`
- `ask_mood` — classifica a resposta e responde de acordo
- `record_daily(mood)` — escreve `logs/daily/YYYY-MM-DD.json`
- `weekly_report` — agrega os últimos 7 arquivos diários
- `monthly_report` — agrega os últimos 4 arquivos semanais
- `avg`, `predominant` — pequenos auxiliares de agregação

A data vem de `Date.today`, capturada na construção do `Assistant`, e é usada em
todos os nomes de arquivo escritos naquela sessão. `CONFIG_PATH` é uma constante
de topo, então o perfil fica fixo em `logs/config.json`.

## `src/views/cli.rb`

A única classe que toca `stdin` e `stdout`.

- `ask(msg)` — imprime um prompt e devolve a resposta sem espaços nas pontas
- `say(msg)` — imprime uma linha `VIKTOR:`
- `yes?(msg)` — verdadeiro para `y` ou `yes`
- `menu(options, actions)` — numera as opções e chama a lambda correspondente

A cor só é emitida quando a saída é um TTY, `NO_COLOR` não está definida e `TERM`
não é `dumb`, então redirecionar a saída para um arquivo gera texto puro.

## `src/services/analyzer.rb`

Embrulha o `Bayes` numa interface enxuta.

- `new(training_file)` — lê o JSON, sanitiza cada exemplo e treina o modelo
- `classify(text)` — sanitiza e delega
- `sanitize(text)` — passa para minúsculas e remove caracteres não alfanuméricos

O treino acontece uma vez, no construtor, na inicialização.

## `src/models/bayes.rb`

O algoritmo, sem saber nada sobre humor ou arquivos.

- `train(category, text)` — conta documentos, palavras por categoria e vocabulário
- `classify(text)` — vence a maior pontuação posterior; levanta erro se nunca treinado
- As pontuações são somadas em espaço logarítmico e as verossimilhanças usam suavização de Laplace

Detalhes em [classificador](classifier.md).

## `src/models/health.rb`

- `bmi(weight, height)` — `peso / altura²`, com duas casas decimais
- `bmi_category(bmi)` — um símbolo de `:underweight` a `:obese3`

Funções puras: sem estado, sem I/O.

## `src/services/storage.rb`

- `save(path, data)` — cria o diretório pai e escreve JSON formatado
- `load(path)` — faz o parse do arquivo, ou devolve `{}` quando ele não existe

Como `load` devolve um hash vazio para arquivo inexistente, quem chama consegue
começar sem nada em disco sem precisar de um caso especial.

## Convenções

- O JSON é escrito com chaves símbolo e lido de volta com chaves texto, então os
  registros são acessados como `record['weight']`, nunca `record[:weight]`.
- Símbolos como `:healthy` e `:increased` viram strings no JSON.
- Os arquivos se chamam `YYYY-MM-DD.json`, o que ordena cronologicamente — os
  relatórios contam com isso ao usar `.sort.last(7)`.
