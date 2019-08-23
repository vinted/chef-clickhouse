describe file('/etc/clickhouse-server/clickhouse-server-test/conf.d/kitchen_custom_zookeeper.xml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 00640 }
  it { should be_owned_by 'clickhouse' }
  it { should be_grouped_into 'clickhouse' }
  its(:content) { should match(%r{<host>127.0.0.1<\/host>}) }
  its(:content) { should match(%r{<port>2181<\/port>}) }
end
