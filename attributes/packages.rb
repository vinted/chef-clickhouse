case node['platform']
when 'rhel', 'centos'
  platform_version = node['platform_version'].to_i
  default['clickhouse']['server']['package_release'] = "1.el#{platform_version}"

when 'debian', 'ubuntu'
  lsb_release = Mixlib::ShellOut.new('lsb_release -sc')
  lsb_release.run_command
  lsb_release.error!
  lsb_release = lsb_release.stdout.chomp

  default['clickhouse']['server']['package_release'] = "1.#{lsb_release}"
end
