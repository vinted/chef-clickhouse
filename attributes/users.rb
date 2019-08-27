# Auto generated from: clickhouse-server/users.xml'

# Maximum memory usage for processing single query, in bytes.
default['clickhouse']['server']['users']['profiles']['default']['max_memory_usage'] = 10000000000

# Use cache of uncompressed blocks of data. Meaningful only for processing many of very short queries.
default['clickhouse']['server']['users']['profiles']['default']['use_uncompressed_cache'] = 0

# How to choose between replicas during distributed query processing.
# random - choose random replica from set of replicas with minimum number of errors
# nearest_hostname - from set of replicas with minimum number of errors, choose replica
# with minimum number of different symbols between replica's hostname and local hostname (Hamming distance).
# in_order - first live replica is chosen in specified order.
# first_or_random - if first replica one has higher number of errors, pick a random one from replicas with minimum number of errors.
default['clickhouse']['server']['users']['profiles']['default']['load_balancing'] = 'random'

# Profile that allows only read queries
default['clickhouse']['server']['users']['profiles']['readonly']['readonly'] = 1


default['clickhouse']['server']['users']['users']['incl'] = ''
default['clickhouse']['server']['users']['users']['optional'] = true

default['clickhouse']['server']['users']['users']['default']['enabled'] = true
default['clickhouse']['server']['users']['users']['default']['password'] = ''
default['clickhouse']['server']['users']['users']['default']['profile'] = 'default'
default['clickhouse']['server']['users']['users']['default']['quota'] = 'default'
default['clickhouse']['server']['users']['users']['default']['networks']['incl'] = ''
default['clickhouse']['server']['users']['users']['default']['networks']['replace'] = 'replace'
default['clickhouse']['server']['users']['users']['default']['networks']['optional'] = true
default['clickhouse']['server']['users']['users']['default']['networks']['ip'] = %w[
  ::/0
]

default['clickhouse']['server']['users']['users']['readonly']['enabled'] = true
default['clickhouse']['server']['users']['users']['readonly']['password'] = ''
default['clickhouse']['server']['users']['users']['readonly']['profile'] = 'readonly'
default['clickhouse']['server']['users']['users']['readonly']['quota'] = 'default'
default['clickhouse']['server']['users']['users']['readonly']['networks']['ip'] = %w[
  ::/0
]

default['clickhouse']['server']['users']['users']['chef']['enabled'] = true
default['clickhouse']['server']['users']['users']['chef']['password'] = ''
default['clickhouse']['server']['users']['users']['chef']['profile'] = 'default'
default['clickhouse']['server']['users']['users']['chef']['quota'] = 'default'
default['clickhouse']['server']['users']['users']['chef']['networks']['ip'] = %w[
  ::1
  127.0.0.1
]

default['clickhouse']['server']['users']['quotas']['default']['interval']['duration'] = 3600
default['clickhouse']['server']['users']['quotas']['default']['interval']['queries'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['errors'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['result_rows'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['read_rows'] = 0
default['clickhouse']['server']['users']['quotas']['default']['interval']['execution_time'] = 0
