include_recipe 'java::default'
include_recipe 'zookeeper::default'

zookeeper_service 'zookeeper' do
  service_style 'systemd'
end
