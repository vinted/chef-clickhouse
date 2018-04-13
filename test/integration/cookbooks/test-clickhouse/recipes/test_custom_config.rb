clickhouse_custom_config 'clickhouse server custom config' do
  service_name 'clickhouse-server-test'
  config 'whatever'
  config_name 'test-custom.xml'
end
