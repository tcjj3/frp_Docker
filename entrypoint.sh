#!/bin/sh




Frpc_Conf_Path="/usr/local/bin/frpc_custom.ini"

Domain_Infos="freefrp_net"








if [ ! -z "$SERVER_ADDR" ]; then
if [ ! -z "$SERVER_PORT" ]; then
if [ ! -z "$TOKEN" ]; then




if [ ! -z "$PROTOCOL" ]; then

if [ ! -z "$LOCAL_IP" ]; then
if [ ! -z "$LOCAL_PORT" ]; then

if [ ! -z "$SUBDOMAIN" ] || [ ! -z "$CUSTOM_DOMAINS" ]; then






echo "" > ${Frpc_Conf_Path}

echo "[common]" >> ${Frpc_Conf_Path}
echo "server_addr = ${SERVER_ADDR}" >> ${Frpc_Conf_Path}
echo "server_port = ${SERVER_PORT}" >> ${Frpc_Conf_Path}
echo "token = ${TOKEN}" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}

echo "admin_addr = 0.0.0.0" >> ${Frpc_Conf_Path}
echo "admin_port = 7400" >> ${Frpc_Conf_Path}
echo "admin_user = admin" >> ${Frpc_Conf_Path}
echo "admin_pwd = admin" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}

echo "login_fail_exit = false" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}

echo "tls_enable = true" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}




tmp_CUSTOM_DOMAINS=`echo "${CUSTOM_DOMAINS}" | sed "s/\./_/gi"`


if [ "$PROTOCOL" == "https" ]; then
echo "[${SUBDOMAIN}_${Domain_Infos}_${tmp_CUSTOM_DOMAINS}_https]" >> ${Frpc_Conf_Path}
echo "type = https" >> ${Frpc_Conf_Path}
echo "local_ip = ${LOCAL_IP}" >> ${Frpc_Conf_Path}
echo "local_port = ${LOCAL_PORT}" >> ${Frpc_Conf_Path}
[ ! -z "$CUSTOM_DOMAINS" ] && echo "custom_domains = ${CUSTOM_DOMAINS}" >> ${Frpc_Conf_Path}
[ ! -z "$SUBDOMAIN" ] && echo "subdomain = ${SUBDOMAIN}" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
fi


if [ "$PROTOCOL" == "http" ] || [ "$PROTOCOL" == "httponly" ]; then
echo "[${SUBDOMAIN}_${Domain_Infos}_${tmp_CUSTOM_DOMAINS}_http]" >> ${Frpc_Conf_Path}
echo "type = http" >> ${Frpc_Conf_Path}
echo "local_ip = ${LOCAL_IP}" >> ${Frpc_Conf_Path}
echo "local_port = ${LOCAL_PORT}" >> ${Frpc_Conf_Path}
[ ! -z "$CUSTOM_DOMAINS" ] && echo "custom_domains = ${CUSTOM_DOMAINS}" >> ${Frpc_Conf_Path}
[ ! -z "$SUBDOMAIN" ] && echo "subdomain = ${SUBDOMAIN}" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
fi


if [ "$PROTOCOL" == "https2http" ] || [ "$PROTOCOL" == "http" ]; then
echo "[${SUBDOMAIN}_${Domain_Infos}_${tmp_CUSTOM_DOMAINS}_https2http]" >> ${Frpc_Conf_Path}
echo "type = https" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
echo "plugin = https2http" >> ${Frpc_Conf_Path}
echo "plugin_local_addr = ${LOCAL_IP}:${LOCAL_PORT}" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
[ ! -z "$CUSTOM_DOMAINS" ] && echo "custom_domains = ${CUSTOM_DOMAINS}" >> ${Frpc_Conf_Path}
[ ! -z "$SUBDOMAIN" ] && echo "subdomain = ${SUBDOMAIN}" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}

echo "plugin_crt_path = /usr/local/bin/frp.freefrp.net.cer" >> ${Frpc_Conf_Path}
echo "plugin_key_path = /usr/local/bin/frp.freefrp.net.key" >> ${Frpc_Conf_Path}

[ ! -z "$CUSTOM_DOMAINS" ] && echo "plugin_host_header_rewrite = ${CUSTOM_DOMAINS}" >> ${Frpc_Conf_Path}
[ ! -z "$SUBDOMAIN" ] && echo "plugin_host_header_rewrite = ${SUBDOMAIN}.freefrp.net" >> ${Frpc_Conf_Path}

echo "plugin_header_X-From-Where = frp" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
fi


if [ "$PROTOCOL" == "tcp" ] || [ "$PROTOCOL" == "udp" ]; then
echo "[${Domain_Infos}_${REMOTE_PORT}_${PROTOCOL}]" >> ${Frpc_Conf_Path}
echo "type = ${PROTOCOL}" >> ${Frpc_Conf_Path}
echo "local_ip = ${LOCAL_IP}" >> ${Frpc_Conf_Path}
echo "local_port = ${LOCAL_PORT}" >> ${Frpc_Conf_Path}

if [ ! -z "$REMOTE_PORT" ]; then
echo "remote_port = ${REMOTE_PORT}" >> ${Frpc_Conf_Path}
else
	echo >&2 'error: missing required REMOTE_PORT environment variable'
	echo >&2 '  Did you forget to -e REMOTE_PORT=... ?'
	exit 1
fi
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
fi


if [ "$PROTOCOL" == "unix_domain_socket" ]; then
echo "[${Domain_Infos}_${REMOTE_PORT}_${PROTOCOL}]" >> ${Frpc_Conf_Path}
echo "type = ${PROTOCOL}" >> ${Frpc_Conf_Path}

if [ ! -z "$REMOTE_PORT" ]; then
echo "remote_port = ${REMOTE_PORT}" >> ${Frpc_Conf_Path}
else
	echo >&2 'error: missing required REMOTE_PORT environment variable'
	echo >&2 '  Did you forget to -e REMOTE_PORT=... ?'
	exit 1
fi

echo "plugin = unix_domain_socket" >> ${Frpc_Conf_Path}

if [ ! -z "$UNIX_PATH" ]; then
echo "plugin_unix_path = ${UNIX_PATH}" >> ${Frpc_Conf_Path}
else
	echo >&2 'error: missing required UNIX_PATH environment variable'
	echo >&2 '  Did you forget to -e UNIX_PATH=... ?'
	exit 1
fi
echo "" >> ${Frpc_Conf_Path}
echo "" >> ${Frpc_Conf_Path}
fi








frpc -c ${Frpc_Conf_Path} > /dev/null 2>&1










else
	echo >&2 'error: missing required SUBDOMAIN or CUSTOM_DOMAINS environment variable'
	echo >&2 '  Did you forget to -e SUBDOMAIN=... or -e CUSTOM_DOMAINS=... ?'
	exit 1
fi

else
	echo >&2 'error: missing required LOCAL_PORT environment variable'
	echo >&2 '  Did you forget to -e LOCAL_PORT=... ?'
	exit 1
fi
else
	echo >&2 'error: missing required LOCAL_IP environment variable'
	echo >&2 '  Did you forget to -e LOCAL_IP=... ?'
	exit 1
fi

else
	echo >&2 'error: missing required PROTOCOL environment variable'
	echo >&2 '  Did you forget to -e PROTOCOL=... ?'
	exit 1
fi





else
	echo >&2 'error: missing required TOKEN environment variable'
	echo >&2 '  Did you forget to -e TOKEN=... ?'
	exit 1
fi
else
	echo >&2 'error: missing required SERVER_PORT environment variable'
	echo >&2 '  Did you forget to -e SERVER_PORT=... ?'
	exit 1
fi
else
	echo >&2 'error: missing required SERVER_ADDR environment variable'
	echo >&2 '  Did you forget to -e SERVER_ADDR=... ?'
	exit 1
fi











exit 0









