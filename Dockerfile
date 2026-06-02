FROM alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/python:3.11.1 AS builder
# 国内环境下 uv 通过 pip 安装更稳定
RUN pip install --no-cache-dir -i https://mirrors.aliyun.com/pypi/simple/ uv

WORKDIR /app
COPY pyproject.toml uv.lock ./
RUN UV_INDEX_URL=https://mirrors.aliyun.com/pypi/simple/ uv sync --frozen --no-dev

FROM alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/python:3.11.1

WORKDIR /app
COPY --from=builder /app/.venv /app/.venv
COPY app.py .

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
