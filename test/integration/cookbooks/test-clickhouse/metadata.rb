name 'test-clickhouse'
maintainer 'Ernestas Poskus'
maintainer_email 'ernestas.poskus@gmail.com'
license 'MIT'
description 'Tests clickhouse'
chef_version '>= 12.1' if respond_to?(:chef_version)
issues_url 'https://github.com/ernestas-poskus/chef-clickhouse/issues'
source_url 'https://github.com/ernestas-poskus/chef-clickhouse'
version '0.1.0'

depends 'clickhouse'
depends 'zookeeper', '~> 10.0.1'
