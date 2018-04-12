describe file('/etc/clickhouse-server/clickhouse-server-test/macros.xml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 0o640 }
  it { should be_owned_by 'clickhouse' }
  it { should be_grouped_into 'clickhouse' }
  its(:content) { should match(%r{<macros><\/macros>}) }
end
