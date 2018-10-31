clickhouse_compression_config 'clickhouse server compression config' do
  service_name 'clickhouse-server-test'
  config <<-CONF
  <yandex>
    <compression>
        <case>
          <min_part_size>10000000000</min_part_size>
          <min_part_size_ratio>0.01</min_part_size_ratio>
          <method>zstd</method>
        </case>
    </compression>
  </yandex>
  CONF
end
