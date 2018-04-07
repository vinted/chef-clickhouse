# Auto generated from: configs/users.xml-1.1.54362'
default['clickhouse']['server']['users']['profiles']['default']['max_memory_usage'] = 10000000000
default['clickhouse']['server']['users']['profiles']['default']['use_uncompressed_cache'] = 0
default['clickhouse']['server']['users']['profiles']['default']['load_balancing'] = 'random'

default['clickhouse']['server']['users']['profiles']['readonly']['readonly'] = 1

default['clickhouse']['server']['users']['users']['default']['networks']['incl'] = 'networks'
default['clickhouse']['server']['users']['users']['default']['networks']['replace'] = 'replace'
default['clickhouse']['server']['users']['users']['default']['networks']['ip'] = %w[
  ::/0
]

default['clickhouse']['server']['users']['users']['default']['password'] = ''
default['clickhouse']['server']['users']['users']['default']['profile'] = 'default'
default['clickhouse']['server']['users']['users']['default']['quota'] = 'default'

default['clickhouse']['server']['users']['users']['readonly']['password'] = ''
default['clickhouse']['server']['users']['users']['readonly']['networks']['incl'] = 'networks'
default['clickhouse']['server']['users']['users']['readonly']['networks']['replace'] = 'replace'
default['clickhouse']['server']['users']['users']['readonly']['networks']['ip'] = %w[
  ::1
  127.0.0.1
]
default['clickhouse']['server']['users']['users']['readonly']['profile'] = 'readonly'
default['clickhouse']['server']['users']['users']['readonly']['quota'] = 'default'

default['clickhouse']['server']['users']['quotas']['default']['interval']['duration'] = 3600
default['clickhouse']['server']['users']['quotas']['default']['interval']['queries'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['errors'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['result_rows'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['read_rows'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['execution_time'] = 0
