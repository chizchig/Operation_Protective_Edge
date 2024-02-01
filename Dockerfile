# Stage 1: Build
FROM python:3.8 AS builder 
WORKDIR /app
COPY applications/requirements.txt .
RUN python -m pip install --upgrade pip && python -m pip install virtualenv

RUN python -m virtualenv /venv 
ENV PATH="/venv/bin:$PATH"

FROM python:3.8-slim 
WORKDIR /app 

COPY --from=builder /venv /venv /app/COPY applications/
COPY applications/ .

ENV PATH="/venv/bin:$PATH"

CMD ["/venv/bin/python", "app.py"]