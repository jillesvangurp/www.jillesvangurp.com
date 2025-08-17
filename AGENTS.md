# AGENTS

## Development workflow
- Build the tool container with `make docker` if it doesn't exist yet.
- Run `make all` after changes to rebuild the site and ensure there are no errors.
- `public/`, `style.css`, and `highlighting.css` are generated; never commit these.
- Use `make clean` to remove generated files if needed.

## Content
- Blog posts live in `articles/` and must be named `YYYY-MM-DD-title.md` for proper sorting.
- Markdown pages live in `pages/`.
- Use two spaces for indentation and end files with a newline.

## Pull requests
- Run the build (`make all`) before committing.
- Verify a clean working tree with `git status`.
