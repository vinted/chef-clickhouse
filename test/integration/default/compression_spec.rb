describe file('/etc/clickhouse-server/clickhouse-server-test/conf.d/compression.xml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'clickhouse' }
  it { should be_grouped_into 'clickhouse' }
  its(:content) { should match(<<-CONF
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
  ) }
end
