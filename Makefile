POST_NAME=$(shell date +"%Y-%m-%d")

# Aliases
PHONY: new.post
new.post:
	hugo new --kind post-bundle posts/$(POST_NAME)

# Production
PHONY: server.prod
server.prod: export HUGO_ENVIRONMENT=production
server.prod:
	hugo server -w

PHONY: build.prod
build.prod: export HUGO_ENVIRONMENT=production
build.prod:
	hugo --gc

# Development
PHONY: server.dev
server.dev: export HUGO_ENVIRONMENT=development
server.dev:
	hugo server -w

PHONY: build.dev
build.dev: export HUGO_ENVIRONMENT=development
build.dev:
	hugo --gc