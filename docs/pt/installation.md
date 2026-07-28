# Instalação

Siga estes passos para preparar o projeto Viktor.

## Clonar o repositório

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
```

## Instalar dependências

```bash
bundle install
```

## Executar

```bash
bundle exec ruby src/main.rb
```

> Observação: o arquivo de entrada principal está em `src/main.rb`.

## Estrutura de arquivos de dados

- `logs/config.json` - perfil do usuário
- `logs/daily/YYYY-MM-DD.json` - registros diários
- `logs/weekly/YYYY-MM-DD.json` - relatórios semanais
- `logs/monthly/YYYY-MM-DD.json` - relatórios mensais
- `models/day.json` - dados de treino do classificador de humor
