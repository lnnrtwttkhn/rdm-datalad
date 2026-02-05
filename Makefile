# Variables
IMAGE_NAME = lnnrtwttkhn/rdm-datalad
CONTAINER_NAME = rdm-datalad-container

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