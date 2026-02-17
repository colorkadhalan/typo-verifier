# Typo Verifier (OCR + Language Verification)

A Python toolkit to:
- Extract text from **images** and **PDFs**
- Detect **spelling**, **grammar**, and **punctuation** issues
- Classify issues by severity (**MAJOR / MINOR**)
- Compute **accuracy score** and confidence labels
- Generate an **audit-style report** (Markdown and PDF)

## Features
- **CLI**: `typo-verifier audit <file-or-folder>`
- **API** (FastAPI): `POST /audit` (upload a file)
- Reports:
  - `report.md` (audit-ready Markdown)
  - `report.pdf` (audit-ready PDF)

## Install

### Option A: Local
```bash
python -m venv .venv
source .venv/bin/activate
pip install -U pip
pip install -e ".[dev]"
```

> Note: For image OCR, install **Tesseract**:
- macOS: `brew install tesseract`
- Ubuntu/Debian: `sudo apt-get install tesseract-ocr`

### Option B: Docker
```bash
docker build -t typo-verifier .
docker run --rm -p 8000:8000 typo-verifier
```

## CLI usage
Audit a single file:
```bash
typo-verifier audit path/to/file.png --out out/
```

Audit a folder (recursively):
```bash
typo-verifier audit path/to/folder --out out/ --recursive
```

## API usage
Run the server:
```bash
uvicorn typo_verifier.api:app --host 0.0.0.0 --port 8000
```

Request:
```bash
curl -F "file=@your.pdf" http://localhost:8000/audit > result.json
```

## Output format
The report follows the audit template:
- Executive dashboard
- Visual bars (20 chars)
- Extracted text (verbatim)
- Uncertain segments
- Issue summaries and tables
- Corrected text (minimal corrections only)

## Development
```bash
pytest
ruff check .
ruff format .
```

## License
MIT
