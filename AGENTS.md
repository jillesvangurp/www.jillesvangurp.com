# AGENTS

## Development workflow

- tooling is docker base, which may not work in agent CI containers
- Run `make all` after changes to rebuild the site and ensure there are no errors.
- `public/`, `style.css`, and `highlighting.css` are generated; never commit these.
- Use `make clean` to remove generated files if needed.

## Content

- Blog posts live in `articles/` and must be named `YYYY-MM-DD-title.md` for proper sorting.
- Markdown pages live in `pages/`.
- Use two spaces for indentation and end files with a newline.
- Markdown flavor is the github one and pandoc is used to transform it

## Styling

- Styling uses tailwind version 4.x and postcss.
- Don't re-introduce things for legacy tailwind 3.x

## Pull requests

- Verify a clean working tree with `git status`.
