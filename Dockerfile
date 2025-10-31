# ---- Base image ----
FROM python:3.11-slim

# ---- Set working directory ----
WORKDIR /app

# ---- Install system dependencies ----
# Add Chromium and fonts if the solver uses browser automation (e.g., undetected_chromedriver)
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    fonts-liberation \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# ---- Copy project files ----
COPY . .

# ---- Install Python dependencies ----
# (requirements.txt must exist in repo root)
RUN pip install --no-cache-dir -r requirements.txt

# ---- Environment variables ----
# Adjust these as per repo (you can add keys, ports, etc.)
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# ---- Expose API port ----
EXPOSE 8080

# ---- Command to run app ----
# Modify "main.py" if the entrypoint differs
CMD ["python", "api_solver.py"]
