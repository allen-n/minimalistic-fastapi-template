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

# # Copy uv lock file and install uv
# COPY uv.lock .
# RUN pip install uv

# # Install dependencies
# RUN uv pip install --upgrade pip && uv pip install -r uv.lock --system

# # Copy the application code
# COPY api /app/api
# COPY alembic /app/alembic
# COPY alembic.ini /app/alembic.ini

# # Run migrations
# COPY api/utils/migrations.py /app/api/utils/migrations.py
# RUN python /app/api/utils/migrations.py

# Expose the port the app runs on
EXPOSE 8000

# Set environment variables
ENV PYTHONPATH=/app

# Command to run the application
CMD ["uv", "run", "uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]