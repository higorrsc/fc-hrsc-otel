# ==============================================================================
# VARIÁVEIS DE CONFIGURAÇÃO
# ==============================================================================
CONTAINER_NAME := zipkin
IMAGE_NAME     := openzipkin/zipkin
PORT           := 9411

# ==============================================================================
# CONFIGURAÇÕES GERAIS
# ==============================================================================
.DEFAULT_GOAL := help
.PHONY: help create start stop logs destroy

# Garante que o Makefile pare imediatamente se um comando falhar.
SHELL := /bin/bash
.SHELLFLAGS := -o errexit -o pipefail -c

# ==============================================================================
# ALVOS DE CICLO DE VIDA DO CONTÊINER
# ==============================================================================

create: ## 🏗️  Cria o contêiner do Zipkin se ele não existir
	@echo "=> Verificando se o contêiner $(CONTAINER_NAME) existe..."
	@if [ -z "$$(docker ps -a --filter name=^/$(CONTAINER_NAME)$$ --format {{.Names}})" ]; then \
		echo "=> Criando o contêiner $(CONTAINER_NAME)..."; \
		docker run -d --name $(CONTAINER_NAME) -p $(PORT):$(PORT) $(IMAGE_NAME); \
	else \
		echo "=> Contêiner $(CONTAINER_NAME) já existe."; \
	fi

start: ## ▶️  Inicia o contêiner do Zipkin (deve ser criado primeiro)
	@echo "=> Iniciando o contêiner $(CONTAINER_NAME)..."
	@docker start $(CONTAINER_NAME)
	@echo "=> Contêiner $(CONTAINER_NAME) iniciado. Acesse em http://localhost:$(PORT)"

stop: ## ⏹️  Para o contêiner do Zipkin (não remove)
	@echo "=> Parando o contêiner $(CONTAINER_NAME)..."
	@docker stop $(CONTAINER_NAME)
	@echo "=> Contêiner parado."

logs: ## 📜 Exibe os logs do contêiner em tempo real
	@echo "=> Exibindo logs para $(CONTAINER_NAME)... (Pressione Ctrl+C para sair)"
	@docker logs -f $(CONTAINER_NAME)

destroy: ## 💣 Para e REMOVE completamente o contêiner
	@echo "=> Parando e removendo o contêiner $(CONTAINER_NAME)..."
	@docker stop $(CONTAINER_NAME) > /dev/null 2>&1 || true
	@docker rm $(CONTAINER_NAME) > /dev/null 2>&1 || true
	@echo "=> Contêiner $(CONTAINER_NAME) removido."

# ==============================================================================
# COMANDO DE AJUDA (HELP)
# ==============================================================================

help: ## ✨ Exibe esta mensagem de ajuda
	@echo "Uso: make [alvo]"
	@echo ""
	@echo "Alvos disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
