# Contributing

Thank you for wanting to contribute to Viktor!

## Getting set up

```bash
git clone https://github.com/gusutabo/viktor.git
cd viktor
bundle install
bundle exec rspec
```

A green suite means your environment is ready. See [installation](installation.md)
for requirements.

## Workflow

1. Fork the repository
2. Branch from `develop`: `git checkout -b feature/my-feature`
3. Make your changes, with tests
4. Run `bundle exec rspec`
5. Commit and push: `git push origin feature/my-feature`
6. Open a Pull Request against `develop`

## Commit messages

The history follows `type: short description in the imperative`, with these types
already in use:

```
feat:     a new capability
fix:      a bug fix
refactor: behaviour unchanged
test:     tests only
docs:     documentation only
chore:    dependencies, tooling, housekeeping
```

For example: `feat: add monthly BMI trend`.

## Tests

Specs live in `spec/`, mirroring `src/`:

```
spec/
├── spec_helper.rb        puts src/ on the load path
├── models/
│   ├── bayes_spec.rb
│   └── health_spec.rb
└── services/
    ├── analyzer_spec.rb
    └── storage_spec.rb
```

Because `spec_helper` adds `src/` to the load path, specs require files by their
path within `src` — `require 'models/health'`, not a long relative path.

Run everything with `bundle exec rspec`, or a single file with
`bundle exec rspec spec/models/health_spec.rb`.

New code should come with a spec. `Cli` and `Assistant` have none yet — they touch
the terminal and the filesystem directly, so covering them means injecting doubles
for the collaborators. That is a welcome contribution.

## Code style

- Keep code simple and readable; prefer a small method over a clever one
- Use clear names for variables and methods
- Separate responsibilities into small classes
- Pass collaborators in through the constructor instead of building them inside
- Keep `src/main.rb` as wiring only, with no logic
- Every file starts with `# frozen_string_literal: true`
- Keep the terminal-facing strings in `Cli` and `Assistant`; other classes should
  not print

## Where things go

| Directory | Contents |
| --- | --- |
| `src/controllers` | Application flow |
| `src/views` | Terminal interaction |
| `src/services` | Persistence and analysis |
| `src/models` | Calculation and classification |
| `data` | Training data |
| `docs` | Documentation, mirrored in `en/` and `pt/` |
| `assets` | Logo and brand files |

## Documentation

Documentation is bilingual. When you change a page in `docs/en/`, make the same
change in `docs/pt/` — the two are meant to stay in step. Keep JSON keys and
category names in English in both, since that is how they appear on disk.

Update the README when you add or change a user-facing feature.
