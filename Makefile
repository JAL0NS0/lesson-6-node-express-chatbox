# Golden Path Makefile for node-express-chatbox
# Usage: make <target>
# Windows users: run this via Git Bash, WSL, or install Make with: choco install make

.DEFAULT_GOAL := help

## help        List all available make targets
help:
	@grep -E '^## ' Makefile | sed 's/## /  /'

## setup       Install dependencies and prepare .env from .env.example
setup:
	@echo "--- Checking Node version ---"
	@node --version
	@echo "--- Installing npm dependencies (exact lockfile versions) ---"
	npm ci
	@echo "--- Creating .env from .env.example (skips if .env already exists) ---"
	@[ -f .env ] && echo ".env already exists, skipping copy." || cp .env.example .env
	@echo ""
	@echo "Setup complete. Run 'make dev' to start the server."
	@echo "Then open http://localhost:3001 in your browser."

## dev         Start development server with auto-reload (nodemon)
dev:
	@PORT=$$(grep -s '^PORT=' .env | cut -d= -f2 || echo 3001); \
	if lsof -i :$$PORT > /dev/null 2>&1 || netstat -ano 2>/dev/null | grep -q ":$$PORT "; then \
		echo "ERROR: Port $$PORT is already in use. Stop the existing process and retry."; \
		exit 1; \
	fi
	@echo "Starting development server..."
	@echo "Open http://localhost:$$(grep -s '^PORT=' .env | cut -d= -f2 || echo 3001) in your browser."
	npm run dev

## start       Start production server (no auto-reload)
start:
	npm start

## test        Run smoke test to verify server module loads correctly
test:
	npm test

## audit       Print npm vulnerability report with remediation guidance
audit:
	@echo "--- Security audit report ---"
	npm audit || true
	@echo ""
	@echo "Run 'npm audit fix' to attempt automatic fixes."
	@echo "See GOLDEN_PATH.md for context on known vulnerabilities."

## clean       Remove node_modules and .env (reset to fresh state)
clean:
	@echo "Removing node_modules and .env..."
	rm -rf node_modules .env
	@echo "Run 'make setup' to reinstall."

.PHONY: help setup dev start test audit clean
