clickhouse_server_service 'clickhouse server instance' do
  service_name 'clickhouse-server-test'
  zookeeper_config_nodes [{ 'host' => 'localhost', 'port' => 2181 }]
end
