FROM python:3.11-slim

# Install tesseract + dependencies for pdfplumber
RUN apt-get update && apt-get install -y --no-install-recommends \
    tesseract-ocr \
    libtesseract-dev \
    poppler-utils \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY pyproject.toml README.md /app/
COPY src /app/src

RUN pip install -U pip && pip install -e .

EXPOSE 8000
CMD ["uvicorn", "typo_verifier.api:app", "--host", "0.0.0.0", "--port", "8000"]
