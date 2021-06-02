FROM debian:buster-slim

LABEL maintainer "Chaojun Tan <https://github.com/tcjj3>"

ADD entrypoint.sh /opt/entrypoint.sh

RUN export DIR_TMP="$(mktemp -d)" \
  && cd $DIR_TMP \
  && chmod +x /opt/*.sh \
  && sed -i "s/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && sed -i "s/security.debian.org/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list \
  && apt-get update \
  || echo "continue..." \
  && apt-get install --no-install-recommends -y wget \
                                                ca-certificates \
                                                curl \
                                                unzip \
                                                procps \
                                                psmisc \
                                                net-tools \
                                                cron \
  && if [ "$(dpkg --print-architecture)" = "armhf" ]; then \
        ARCH="arm"; \
     else \
        ARCH=$(dpkg --print-architecture); \
     fi \
  && cd ${DIR_TMP} \
  && curl -L -o ${DIR_TMP}/frp_linux.tar.gz https://github.com/fatedier/frp/releases/download/v0.36.2/frp_0.36.2_linux_${ARCH}.tar.gz \
  && tar zxf ${DIR_TMP}/frp_linux.tar.gz -C ${DIR_TMP} \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frpc /usr/local/bin/frpc \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frps /usr/local/bin/frps \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frpc.ini /usr/local/bin/frpc.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frps.ini /usr/local/bin/frps.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frpc_full.ini /usr/local/bin/frpc_full.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frps_full.ini /usr/local/bin/frps_full.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frpc.ini /frpc.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frps.ini /frps.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frpc_full.ini /frpc_full.ini \
  && cp ${DIR_TMP}/frp_0.36.2_linux_amd64/frps_full.ini /frps_full.ini \
  && curl -L -o ${DIR_TMP}/frp.freefrp.net.zip https://freefrp.net/down/frp.freefrp.net.zip \
  && unzip -o ${DIR_TMP}/frp.freefrp.net.zip -d ${DIR_TMP} \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.cer /usr/local/bin/frp.freefrp.net.cer \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.key /usr/local/bin/frp.freefrp.net.key \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.cer /frp.freefrp.net.cer \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.key /frp.freefrp.net.key \
  && rm -rf ${DIR_TMP}











ENTRYPOINT ["bash", "-c", "/opt/entrypoint.sh"]











