%w[
  /etc/clickhouse-server/clickhouse-server/config.xml
].each do |directory|
  describe file(directory) do
    it { should exist }
    it { should be_file }
    it { should be_mode 0o640 }
    it { should be_owned_by 'clickhouse' }
    it { should be_grouped_into 'clickhouse' }
  end
end
