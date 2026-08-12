# Instalação

## Requisitos

- Ruby 3.0 ou superior
- Bundler

Confira o que você tem:

```bash
ruby -v
bundle -v
```

Se faltar o Bundler: `gem install bundler`.

## Clonar o repositório

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
```

## Instalar dependências

```bash
bundle install
```

A única dependência é o RSpec, usado pelos testes. O Viktor em si roda apenas com
a biblioteca padrão do Ruby.

## Executar

```bash
bundle exec ruby src/main.rb
```

Execute a partir da raiz do repositório. Caminhos como `data/day.json` e `logs/`
são resolvidos em relação ao diretório atual, então iniciar de outro lugar faz o
programa não encontrar os dados de treino.

## Rodar os testes

```bash
bundle exec rspec
```

## Estrutura do repositório

```
viktor/
├── src/            código da aplicação
│   ├── main.rb
│   ├── controllers/
│   ├── models/
│   ├── services/
│   └── views/
├── spec/           testes RSpec, espelhando src/
├── data/
│   └── day.json    dados de treino do classificador de humor
├── docs/           esta documentação (en/ e pt/)
├── assets/         logo e arquivos de marca
└── logs/           seus registros, criados no primeiro uso (fora do git)
```

## Arquivos que o Viktor escreve

Tudo que o Viktor produz fica em `logs/`, e nada disso é versionado:

| Caminho | Conteúdo |
| --- | --- |
| `logs/config.json` | Seu perfil: nome, idade, altura, local |
| `logs/daily/YYYY-MM-DD.json` | Um registro por dia |
| `logs/weekly/YYYY-MM-DD.json` | Relatório semanal, datado na geração |
| `logs/monthly/YYYY-MM-DD.json` | Relatório mensal, datado na geração |

Os diretórios são criados automaticamente na primeira escrita.

## Começar do zero

Apague o perfil para responder as perguntas iniciais de novo:

```bash
rm logs/config.json
```

Apagar `logs/` inteiro elimina todo o histórico. Não há como desfazer.
