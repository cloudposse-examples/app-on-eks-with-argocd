FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

EXPOSE 5000

STOPSIGNAL SIGTERM

ONBUILD COPY requirements.txt /app/
ONBUILD RUN pip install --no-cache-dir -r requirements.txt
ONBUILD COPY . /app

HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl --fail http://localhost:5000/ || exit 1

CMD ["python", "app.py"]