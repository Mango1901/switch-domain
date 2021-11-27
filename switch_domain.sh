#!/bin/bash
mysql_user=$1
mysql_password=$2;
mysql_db=$3;
domain_switch=$4;
mysql_port=$5;
mysql_host=$6;

if [ -z "${mysql_host}"  ]; then
    mysql_host=127.0.0.1
fi
if [ -z "${mysql_port}"  ]; then
    mysql_port=3306
fi

mysql -u "${mysql_user}" -p"${mysql_password}" -h "${mysql_host}" -P "${mysql_port}" \
  -e "use ${mysql_db};" \
  -e "UPDATE core_config_data SET value = '${domain_switch}' WHERE path = 'web/secure/base_url';" \
  -e "UPDATE core_config_data SET value = '${domain_switch}' WHERE path = 'web/unsecure/base_url';" \
  -e "UPDATE core_config_data SET value = '0' WHERE path = 'admin/url/use_custom';" \
  -e "UPDATE core_config_data SET value = '0' WHERE path = 'web/secure/use_in_frontend';" \
  -e "UPDATE core_config_data SET value = '0' WHERE path = 'web/secure/use_in_adminhtml';" \
  -e "UPDATE core_config_data SET value = '0' WHERE path = 'dev/static/sign';"
  exit