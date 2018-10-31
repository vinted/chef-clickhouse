clickhouse_remote_servers_config 'clickhouse remote servers config' do
  service_name 'clickhouse-server-test'
  config <<-CONF
  <yandex>
    <remote_servers>
    </remote_servers>
  </yandex>
  CONF
end
