# Variables
IMAGE_NAME = lnnrtwttkhn/rdm-datalad
CONTAINER_NAME = rdm-datalad-container
DATALAD_IMAGE_NAME = lnnrtwttkhn/rdm-datalad-datalad

.PHONY: install
install:
	curl -LsSf https://astral.sh/uv/install.sh | sh
	uv sync --frozen
	uv run python -m bash_kernel.install
	uv run python generate_install.py
	uv run quarto convert tutorial.qmd

.PHONY: generate-install
generate-install:
	uv run python3 generate_install.py

.PHONY: ipynb
ipynb:
	mkdir -p _site
	uv run quarto convert tutorial.qmd
	uv run python3 convert_colab.py
	uv run quarto convert tutorial_colab.qmd
	mv tutorial_colab.ipynb _site/

.PHONY: build-datalad
build-datalad:
	docker build -f Dockerfile.datalad -t $(DATALAD_IMAGE_NAME) .

.PHONY: run-datalad
run-datalad:
	docker run --rm -it $(DATALAD_IMAGE_NAME)

.PHONY: build
build:
	docker build --platform=linux/amd64 -f Dockerfile -t $(IMAGE_NAME):latest .

.PHONY: preview
preview:
	@echo "Clearing stale Quarto session cache..."
	@rm -rf .quarto
	@echo "Removing old preview container if it exists..."
	@docker container rm -f $(CONTAINER_NAME)-preview 2>/dev/null || true
	@echo "Starting Quarto preview on http://localhost:4240"
	docker run --rm \
		--platform=linux/amd64 \
		--name $(CONTAINER_NAME)-preview \
		-p 9999:4240 \
		-e UV_PROJECT_ENVIRONMENT=/app/.venv \
		-v $(CURDIR):/workspace \
		-w /workspace \
		$(IMAGE_NAME):latest \
		sh -c "quarto add --no-prompt mcanouil/quarto-collapse-output && uv run quarto preview --host 0.0.0.0 --port 4240 --no-browser"
