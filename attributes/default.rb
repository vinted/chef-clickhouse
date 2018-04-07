default['clickhouse']['user'] = 'clickhouse'
default['clickhouse']['group'] = 'clickhouse'

case node['platform']
when 'rhel', 'centos'
  default['clickhouse']['server']['version'] = '1.1.54362'
when 'ubuntu', 'debian'
  default['clickhouse']['server']['version'] = '1.1.54343'
end

# Override config.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['configuration']['cookbook'] = 'clickhouse'
