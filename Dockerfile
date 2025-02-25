# syntax = docker/dockerfile:1
# Dockerfile
FROM python:3.12-slim-bookworm
# Install the uv package manager
COPY --from=ghcr.io/astral-sh/uv:0.6.3 /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Copy the application code
COPY api /app/api
COPY alembic /app/alembic
COPY alembic.ini /app/alembic.ini
COPY pyproject.toml /app/pyproject.toml
COPY uv.lock /app/uv.lock

RUN uv sync

# Expose the port the app runs on
EXPOSE 8000

# Set environment variables
ENV PYTHONPATH=/app

# Command to run the application is set in the docker-compose.yml file and railway.toml
