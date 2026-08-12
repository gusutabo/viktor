# Contribuição

Obrigado por querer contribuir com o Viktor!

## Preparando o ambiente

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
bundle install
bundle exec rspec
```

Suíte verde significa ambiente pronto. Veja [instalação](installation.md) para os
requisitos.

## Fluxo de trabalho

1. Faça um fork do repositório
2. Crie a branch a partir de `develop`: `git checkout -b feature/minha-feature`
3. Faça suas alterações, com testes
4. Rode `bundle exec rspec`
5. Faça o commit e envie: `git push origin feature/minha-feature`
6. Abra um Pull Request para `develop`

## Mensagens de commit

O histórico segue `tipo: descrição curta no imperativo`, com estes tipos já em
uso:

```
feat:     nova funcionalidade
fix:      correção de bug
refactor: sem mudança de comportamento
test:     apenas testes
docs:     apenas documentação
chore:    dependências, ferramentas, manutenção
```

Por exemplo: `feat: add monthly BMI trend`.

## Testes

Os specs ficam em `spec/`, espelhando `src/`:

```
spec/
├── spec_helper.rb        coloca src/ no load path
├── models/
│   ├── bayes_spec.rb
│   └── health_spec.rb
└── services/
    ├── analyzer_spec.rb
    └── storage_spec.rb
```

Como o `spec_helper` adiciona `src/` ao load path, os specs carregam arquivos pelo
caminho dentro de `src` — `require 'models/health'`, e não um caminho relativo
longo.

Rode tudo com `bundle exec rspec`, ou um arquivo só com
`bundle exec rspec spec/models/health_spec.rb`.

Código novo deve vir com spec. `Cli` e `Assistant` ainda não têm — eles mexem
direto no terminal e no sistema de arquivos, então cobri-los exige injetar dublês
no lugar dos colaboradores. É uma contribuição bem-vinda.

## Estilo de código

- Mantenha o código simples e legível; prefira um método pequeno a um esperto
- Use nomes claros para variáveis e métodos
- Separe responsabilidades em classes pequenas
- Passe colaboradores pelo construtor em vez de instanciá-los por dentro
- Mantenha `src/main.rb` só como montagem, sem lógica
- Todo arquivo começa com `# frozen_string_literal: true`
- Deixe os textos de terminal em `Cli` e `Assistant`; as outras classes não imprimem

## Onde fica cada coisa

| Diretório | Conteúdo |
| --- | --- |
| `src/controllers` | Fluxo da aplicação |
| `src/views` | Interação no terminal |
| `src/services` | Persistência e análise |
| `src/models` | Cálculo e classificação |
| `data` | Dados de treino |
| `docs` | Documentação, espelhada em `en/` e `pt/` |
| `assets` | Logo e arquivos de marca |

## Documentação

A documentação é bilíngue. Ao mudar uma página em `docs/pt/`, faça a mesma mudança
em `docs/en/` — as duas devem andar juntas. Mantenha as chaves de JSON e os nomes
das categorias em inglês nas duas, porque é assim que aparecem em disco.

Atualize o README ao adicionar ou alterar uma funcionalidade visível ao usuário.
