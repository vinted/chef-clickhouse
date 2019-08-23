describe file('/etc/clickhouse-server/clickhouse-server-test/conf.d/test-custom.xml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'clickhouse' }
  it { should be_grouped_into 'clickhouse' }
  its(:content) { should match('<yandex></yandex>') }
end
