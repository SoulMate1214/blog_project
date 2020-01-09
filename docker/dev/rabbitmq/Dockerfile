# 基础镜像
FROM rabbitmq:latest
# 维护者信息
MAINTAINER Soul
# 复制本地主机的到容器中的 (为 Dockerfile 所在目录的相对路径)
COPY rabbitmq_delayed_message_exchange-3.8.0.ez /plugins
# 在镜像中要执行的命令
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange