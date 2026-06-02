FROM registry.cn-hangzhou.aliyuncs.com/dosnshcu-fastapi/python:3.13-slim AS builder
# 国内环境下 uv 通过 pip 安装更稳定
RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ uv

WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN UV_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/ uv sync --frozen --no-dev

FROM registry.cn-hangzhou.aliyuncs.com/dosnshcu-fastapi/python:3.13-slim

WORKDIR /app
COPY --from=builder /app/.venv /app/.venv
COPY app.py .

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
