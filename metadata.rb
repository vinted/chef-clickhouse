name 'clickhouse'
maintainer 'Ernestas Poskus'
maintainer_email 'ernestas.poskus@gmail.com'
license 'MIT'
description 'Installs/Configures chef-clickhouse'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/ernestas-poskus/chef-clickhouse/issues'
source_url 'https://github.com/ernestas-poskus/chef-clickhouse'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports 'redhat'
supports 'centos'
supports 'ubuntu'
supports 'debian'

depends 'poise', '~> 2.8.1'
depends 'poise-service', '~> 1.5.2'
