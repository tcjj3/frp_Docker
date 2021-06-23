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
                                                jq \
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
  && FRP_URL=`curl -s https://api.github.com/repos/fatedier/frp/releases/latest | jq -r ".assets[] | select(.name | test(\"linux_${ARCH}\")) | .browser_download_url"` \
  && curl -L -o ${DIR_TMP}/linux_frp.tar.gz "${FRP_URL}" \
  && tar zxf ${DIR_TMP}/linux_frp.tar.gz -C ${DIR_TMP} \
  && cd ${DIR_TMP}/frp_* \
  && cp frpc /usr/local/bin/frpc \
  && cp frps /usr/local/bin/frps \
  && cp frpc.ini /usr/local/bin/frpc.ini \
  && cp frps.ini /usr/local/bin/frps.ini \
  && cp frpc_full.ini /usr/local/bin/frpc_full.ini \
  && cp frps_full.ini /usr/local/bin/frps_full.ini \
  && cp frpc.ini /frpc.ini \
  && cp frps.ini /frps.ini \
  && cp frpc_full.ini /frpc_full.ini \
  && cp frps_full.ini /frps_full.ini \
  && cd .. \
  && cd ${DIR_TMP} \
  && curl -L -o ${DIR_TMP}/frp.freefrp.net.zip https://freefrp.net/down/frp.freefrp.net.zip \
  && unzip -o ${DIR_TMP}/frp.freefrp.net.zip -d ${DIR_TMP} \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.cer /usr/local/bin/frp.freefrp.net.cer \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.key /usr/local/bin/frp.freefrp.net.key \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.cer /frp.freefrp.net.cer \
  && cp ${DIR_TMP}/frp.freefrp.net/frp.freefrp.net.key /frp.freefrp.net.key \
  && rm -rf ${DIR_TMP}











ENTRYPOINT ["bash", "-c", "/opt/entrypoint.sh"]











