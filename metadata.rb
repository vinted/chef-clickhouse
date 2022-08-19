name 'clickhouse'
maintainer 'Vinted'
maintainer_email 'sre@vinted.com'
license 'MIT'
description 'Installs/Configures chef-clickhouse'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/vinted/chef-clickhouse/issues'
source_url 'https://github.com/vinted/chef-clickhouse'
version '1.0.0'
chef_version '>= 12.5' if respond_to?(:chef_version)

supports 'redhat'
supports 'centos'
supports 'rocky'
supports 'ubuntu'
supports 'debian'

depends 'poise', '~> 2.8.2'
depends 'ulimit', '~> 1.0.0'
depends 'systemd', '~> 3.2.4'
