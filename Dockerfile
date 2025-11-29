FROM python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Setup workdir
WORKDIR /app

# Install system deps
RUN apt-get update && \
    apt-get install -y curl telnet make gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

ENV POETRY_VERSION=1.8.3
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"

RUN curl -sSL https://install.python-poetry.org | python3 -
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV POETRY_VIRTUALENVS_CREATE=true

COPY pyproject.toml poetry.lock* /app/

RUN poetry install --no-interaction --no-ansi

ENV PATH="/app/.venv/bin:$PATH"

COPY backend/app ./backend/app
COPY Makefile .

CMD ["make", "up-entrypoint"]


