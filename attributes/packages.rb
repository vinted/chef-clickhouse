case node['platform']
when 'rhel', 'centos'
  platform_version = node['platform_version'].to_i
  default['clickhouse']['server']['package_release'] = "1.el#{platform_version}"
when 'debian', 'ubuntu'
  default['clickhouse']['server']['package_release'] = nil
end
