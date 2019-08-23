clickhouse_zookeeper_config 'clickhouse server zookeeper config' do
  service_name 'clickhouse-server-test'
  config_name 'kitchen_custom_zookeeper'
  nodes [
    { host: '127.0.0.1', port: 2181 }
  ]
end
