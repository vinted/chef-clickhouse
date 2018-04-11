%w[
  /etc/clickhouse-server/clickhouse-server-test/config.xml
  /etc/clickhouse-server/clickhouse-server-test/zookeeper-servers.xml
].each do |directory|
  describe file(directory) do
    it { should exist }
    it { should be_file }
    it { should be_mode 00640 }
    it { should be_owned_by 'clickhouse' }
    it { should be_grouped_into 'clickhouse' }
  end
end
