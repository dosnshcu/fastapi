#!/bin/bash
# 部署脚本 — 云效流水线通过 SSH 在 ECS 上执行此脚本
# 用法: bash deploy.sh <镜像地址>
# 例如: bash deploy.sh registry.cn-hangzhou.aliyuncs.com/myns/myapp:v1.0.0

set -e

IMAGE_URL=$1

if [ -z "$IMAGE_URL" ]; then
  echo "用法: bash deploy.sh <镜像地址>"
  exit 1
fi

# 拉取最新镜像
echo ">>> 拉取镜像: $IMAGE_URL"
docker pull "$IMAGE_URL"

# 停止并删除旧容器（如果存在）
echo ">>> 停止旧容器"
docker stop fastapi-app 2>/dev/null || true
docker rm fastapi-app 2>/dev/null || true

# 启动新容器
echo ">>> 启动新容器"
docker run -d \
  --name fastapi-app \
  --restart unless-stopped \
  -p 8000:8000 \
  "$IMAGE_URL"

echo ">>> 部署完成"
docker ps | grep fastapi-app
