clickhouse_custom_config 'clickhouse server custom config' do
  service_name 'clickhouse-server-test'
  config '<yandex></yandex>'
  config_name 'test-custom.xml'
end
