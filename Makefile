.PHONY: lint

# Tooling
LINT_IMAGE = ghcr.io/igorshubovych/markdownlint-cli:v0.44.0

# Markdown Linting
lint:
	docker run --rm -v "$(PWD):/data" -w /data $(LINT_IMAGE) --fix "**/*.md"