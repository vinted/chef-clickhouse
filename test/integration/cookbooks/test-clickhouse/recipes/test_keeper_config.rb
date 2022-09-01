clickhouse_keeper_config 'clickhouse keeper config' do
  service_name 'clickhouse-server-test'
  config_name 'kitchen_custom_keeper'
  nodes [
    { 'server_id' => 1, 'host' => node['fqdn'] }
  ]
end
