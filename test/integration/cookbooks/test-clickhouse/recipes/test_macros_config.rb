clickhouse_macros_config 'clickhouse server macros config' do
  service_name 'clickhouse-server-test'
  config <<-CONF
    <yandex>
      <macros>
      </macros>
    </yandex>
  CONF
end
