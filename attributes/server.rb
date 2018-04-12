# Auto generated from: config.xml-1.1.54362'
default['clickhouse']['server']['config']['logger']['level'] = 'trace'
default['clickhouse']['server']['config']['logger']['log'] = '/var/log/clickhouse-server/clickhouse-server.log'
default['clickhouse']['server']['config']['logger']['errorlog'] = '/var/log/clickhouse-server/clickhouse-server.err.log'
default['clickhouse']['server']['config']['logger']['size'] = '1000M'
default['clickhouse']['server']['config']['logger']['count'] = 10

default['clickhouse']['server']['config']['http_port'] = 8123
default['clickhouse']['server']['config']['tcp_port'] = 9000

# SSL
default['clickhouse']['server']['config']['enable_ssl'] = false
default['clickhouse']['server']['config']['https_port'] = 8443
default['clickhouse']['server']['config']['tcp_ssl_port'] = 9440
default['clickhouse']['server']['config']['openSSL']['server']['certificateFile'] = '/etc/clickhouse-server/server.crt'
default['clickhouse']['server']['config']['openSSL']['server']['privateKeyFile'] = '/etc/clickhouse-server/server.key'
default['clickhouse']['server']['config']['openSSL']['server']['dhParamsFile'] = '/etc/clickhouse-server/dhparam.pem'
default['clickhouse']['server']['config']['openSSL']['server']['verificationMode'] = 'none'
default['clickhouse']['server']['config']['openSSL']['server']['loadDefaultCAFile'] = true
default['clickhouse']['server']['config']['openSSL']['server']['cacheSessions'] = true
default['clickhouse']['server']['config']['openSSL']['server']['disableProtocols'] = 'sslv2,sslv3'
default['clickhouse']['server']['config']['openSSL']['server']['preferServerCiphers'] = true
default['clickhouse']['server']['config']['openSSL']['client']['loadDefaultCAFile'] = true
default['clickhouse']['server']['config']['openSSL']['client']['cacheSessions'] = true
default['clickhouse']['server']['config']['openSSL']['client']['disableProtocols'] = 'sslv2,sslv3'
default['clickhouse']['server']['config']['openSSL']['client']['preferServerCiphers'] = true
default['clickhouse']['server']['config']['openSSL']['client']['invalidCertificateHandler']['name'] = 'RejectCertificateHandler'

default['clickhouse']['server']['config']['interserver_http_port'] = 9009
default['clickhouse']['server']['config']['max_connections'] = 4096
default['clickhouse']['server']['config']['keep_alive_timeout'] = 3
default['clickhouse']['server']['config']['max_concurrent_queries'] = 100
default['clickhouse']['server']['config']['uncompressed_cache_size'] = 8589934592
default['clickhouse']['server']['config']['mark_cache_size'] = 5368709120
# default['clickhouse']['server']['config']['path'] = '/var/lib/clickhouse/'
# default['clickhouse']['server']['config']['tmp_path'] = '/var/lib/clickhouse/tmp/'
default['clickhouse']['server']['config']['users_config'] = 'users.xml'
default['clickhouse']['server']['config']['default_profile'] = 'default'
default['clickhouse']['server']['config']['system_profile'] = 'default'
default['clickhouse']['server']['config']['default_database'] = 'default'

# Please note, that server could display time zone alias instead of specified name.
# Example: W-SU is an alias for Europe/Moscow and Zulu is an alias for UTC.
default['clickhouse']['server']['config']['timezone'] = 'Zulu'

default['clickhouse']['server']['config']['remote_servers']['incl'] = 'clickhouse_remote_servers'

default['clickhouse']['server']['config']['zookeeper']['incl'] = 'zookeeper-servers'
default['clickhouse']['server']['config']['zookeeper']['optional'] = true

default['clickhouse']['server']['config']['macros']['incl'] = 'macros'
default['clickhouse']['server']['config']['macros']['optional'] = true

default['clickhouse']['server']['config']['builtin_dictionaries_reload_interval'] = 3600
default['clickhouse']['server']['config']['max_session_timeout'] = 3600
default['clickhouse']['server']['config']['default_session_timeout'] = 60

default['clickhouse']['server']['config']['query_log']['database'] = 'system'
default['clickhouse']['server']['config']['query_log']['table'] = 'query_log'
default['clickhouse']['server']['config']['query_log']['partition_by'] = 'toYYYYMM(event_date)'
default['clickhouse']['server']['config']['query_log']['flush_interval_milliseconds'] = 7500


default['clickhouse']['server']['config']['part_log']['enable'] = false
default['clickhouse']['server']['config']['part_log']['database'] = 'system'
default['clickhouse']['server']['config']['part_log']['table'] = 'part_log'
default['clickhouse']['server']['config']['part_log']['flush_interval_milliseconds'] = 7500


default['clickhouse']['server']['config']['dictionaries_config'] = '*_dictionary.xml'
default['clickhouse']['server']['config']['compression']['incl'] = 'clickhouse_compression'
default['clickhouse']['server']['config']['distributed_ddl']['path'] = '/clickhouse/task_queue/ddl'

# default['clickhouse']['server']['config']['graphite_rollup_example']['pattern']['regexp'] = 'click_cost'
# default['clickhouse']['server']['config']['graphite_rollup_example']['pattern']['function'] = 'any'
# default['clickhouse']['server']['config']['graphite_rollup_example']['pattern']['retention']['age'] = 86400
# default['clickhouse']['server']['config']['graphite_rollup_example']['pattern']['retention']['precision'] = 60
# default['clickhouse']['server']['config']['graphite_rollup_example']['default']['function'] = 'max'
# default['clickhouse']['server']['config']['graphite_rollup_example']['default']['retention']['age'] = 86400
# default['clickhouse']['server']['config']['graphite_rollup_example']['default']['retention']['precision'] = 3600

default['clickhouse']['server']['config']['format_schema_path'] = '/var/lib/clickhouse/format_schemas/'
