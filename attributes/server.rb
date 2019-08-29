# Auto generated from: clickhouse-server/config.xml'
default['clickhouse']['server']['config']['logger']['level'] = 'trace'
default['clickhouse']['server']['config']['logger']['size'] = '1000M'
default['clickhouse']['server']['config']['logger']['count'] = 10

# It is the name that will be shown in the client
default['clickhouse']['server']['config']['display_name'] = 'production'

default['clickhouse']['server']['config']['http_port'] = 8123
default['clickhouse']['server']['config']['tcp_port'] = 9000

# SSL
default['clickhouse']['server']['config']['enable_ssl'] = false
default['clickhouse']['server']['config']['https_port'] = 8443
default['clickhouse']['server']['config']['tcp_port_secure'] = 9440
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

# Listen specified host. use :: (wildcard IPv6 address), if you want to accept connections both with IPv4 and IPv6 from everywhere.
# Same for hosts with disabled ipv6:
default['clickhouse']['server']['config']['listen_host'] = '0.0.0.0'
# Don't exit if ipv6 or ipv4 unavailable, but listen_host with this protocol specified
default['clickhouse']['server']['config']['listen_try'] = '0'
# Allow listen on same address:port
default['clickhouse']['server']['config']['listen_reuse_port'] = '0'
default['clickhouse']['server']['config']['listen_backlog'] = '64'

default['clickhouse']['server']['config']['max_connections'] = 4096
default['clickhouse']['server']['config']['keep_alive_timeout'] = 3
default['clickhouse']['server']['config']['max_concurrent_queries'] = 100
default['clickhouse']['server']['config']['max_open_files'] = 262144
default['clickhouse']['server']['config']['uncompressed_cache_size'] = 8589934592
default['clickhouse']['server']['config']['mark_cache_size'] = 5368709120

default['clickhouse']['server']['config']['users_config'] = 'users.xml'
default['clickhouse']['server']['config']['default_profile'] = 'default'
default['clickhouse']['server']['config']['system_profile'] = 'default'
default['clickhouse']['server']['config']['default_database'] = 'default'
default['clickhouse']['server']['config']['mlock_executable'] = false

# Please note, that server could display time zone alias instead of specified name.
# Example: W-SU is an alias for Europe/Moscow and Zulu is an alias for UTC.
default['clickhouse']['server']['config']['timezone'] = 'Zulu'

default['clickhouse']['server']['config']['builtin_dictionaries_reload_interval'] = 3600
default['clickhouse']['server']['config']['max_session_timeout'] = 3600
default['clickhouse']['server']['config']['default_session_timeout'] = 60

default['clickhouse']['server']['config']['query_log']['database'] = 'system'
default['clickhouse']['server']['config']['query_log']['table'] = 'query_log'
default['clickhouse']['server']['config']['query_log']['partition_by'] = 'toYYYYMM(event_date)'
default['clickhouse']['server']['config']['query_log']['flush_interval_milliseconds'] = 7500

# Trace log. Stores stack traces collected by query profilers.
# See query_profiler_real_time_period_ns and query_profiler_cpu_time_period_ns settings.
default['clickhouse']['server']['config']['trace_log']['enable'] = false
default['clickhouse']['server']['config']['trace_log']['database'] = 'system'
default['clickhouse']['server']['config']['trace_log']['table'] = 'trace_log'
default['clickhouse']['server']['config']['trace_log']['partition_by'] = 'toYYYYMM(event_date)'
default['clickhouse']['server']['config']['trace_log']['flush_interval_milliseconds'] = 7500

# Uncomment if use part log. Part log contains information about all actions
# with parts in MergeTree tables (creation, deletion, merges, downloads).
default['clickhouse']['server']['config']['part_log']['enable'] = false
default['clickhouse']['server']['config']['part_log']['database'] = 'system'
default['clickhouse']['server']['config']['part_log']['table'] = 'part_log'
default['clickhouse']['server']['config']['part_log']['flush_interval_milliseconds'] = 7500

# Query thread log. Has information about all threads participated in query execution.
# Used only for queries with setting log_query_threads = 1.
default['clickhouse']['server']['config']['query_thread_log']['enable'] = false
default['clickhouse']['server']['config']['query_thread_log']['database'] = 'system'
default['clickhouse']['server']['config']['query_thread_log']['table'] = 'query_thread_log'
default['clickhouse']['server']['config']['query_thread_log']['partition_by'] = 'toYYYYMM(event_date)'
default['clickhouse']['server']['config']['query_thread_log']['flush_interval_milliseconds'] = 7500

default['clickhouse']['server']['config']['dictionaries_config'] = '*_dictionary.xml'
default['clickhouse']['server']['config']['distributed_ddl']['path'] = '/clickhouse/task_queue/ddl'

# Substitutions for parameters of replicated tables.
# Optional. If you don't use replicated tables, you could omit that.
default['clickhouse']['server']['config']['macros']['incl'] = 'macros'
default['clickhouse']['server']['config']['macros']['optional'] = true

# ZooKeeper is used to store metadata about replicas, when using Replicated tables.
# Optional. If you don't use replicated tables, you could omit that.
default['clickhouse']['server']['config']['zookeeper']['incl'] = 'zookeeper-servers'
default['clickhouse']['server']['config']['zookeeper']['optional'] = 'false'

default['clickhouse']['server']['config']['compression']['incl'] = 'clickhouse_compression'
default['clickhouse']['server']['config']['compression']['optional'] = 'true'

# Configuration of clusters that could be used in Distributed tables.
# https://clickhouse.yandex/docs/en/table_engines/distributed/
default['clickhouse']['server']['config']['remote_servers']['incl'] = 'remote_servers'
default['clickhouse']['server']['config']['remote_servers']['optional'] = 'true'
