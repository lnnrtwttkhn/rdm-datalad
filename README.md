# Research Data Management with DataLad

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY_SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

A comprehensive tutorial on Research Data Management using [DataLad](https://www.datalad.org/).

## 🎯 Overview

This tutorial covers the complete lifecycle of data management with DataLad, from basic dataset creation to advanced workflow reproducibility. It's designed for researchers, data scientists, and anyone working with research data.

## 📚 Tutorial Contents

- **Introduction and Setup** - Getting started with DataLad
- **Creating DataLad Datasets** - Basic dataset creation and management
- **Version Control Workflows** - Managing data and code changes over time
- **Dataset Consumption and Nesting** - Working with existing datasets and subdatasets
- **Advanced Dataset Structures** - Complex nested dataset architectures
- **Reproducible Workflows** - Complete workflow tracking and replication

## 🚀 Quick Start

### Online Tutorial

Visit the interactive tutorial: **[https://lennartwittkuhn.com/rdm-datalad/](https://lennartwittkuhn.com/rdm-datalad/)**

### Local Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/lnnrtwttkhn/rdm-datalad.git
   cd rdm-datalad
   ```

2. **Install dependencies:**
   ```bash
   make install
   ```

3. **Open the tutorial notebook:**
   - For Jupyter: `tutorial.ipynb`
   - For Google Colab: `tutorial_colab.ipynb`

## 🛠 Development

### Prerequisites

- Python ≥ 3.13
- [uv](https://docs.astral.sh/uv/) package manager
- [Quarto](https://quarto.org/) for document rendering

### Build Commands

```bash
# Install all dependencies
make install

# Generate installation files
make generate-install

# Convert to Jupyter notebooks
make ipynb

# Serve development website
quarto preview

# Build production site
quarto render
```

### Available Formats

- **HTML Website** - Interactive web tutorial
- **Jupyter Notebook** - For local Jupyter environments
- **Google Colab** - Cloud-based notebook with pre-installed dependencies

## 🐳 Docker Support

A Docker environment is available for consistent cross-platform execution:

```bash
docker build -t rdm-datalad .
docker run -p 8888:8888 rdm-datalad
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run pre-commit hooks: `uv run pre-commit run --all`
5. Submit a pull request

## 📄 License

This work is licensed under a [Creative Commons Attribution Share Alike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).

## 📞 Contact

**Dr. Lennart Wittkuhn**
- 🌐 Website: [lennartwittkuhn.com](https://lennartwittkuhn.com/)
- 📧 Email: lennart.wittkuhn@tutanota.com
- 🔗 ORCID: [0000-0003-2966-6888](https://orcid.org/0000-0003-2966-6888)

## 🙏 Acknowledgments

This tutorial was initially created by Adina Wagner for the 2020 OHBM Brainhack Traintrack session on DataLad. This version has been adapted and extended for broader educational use.

---

*Part of the Research Data Management educational series*