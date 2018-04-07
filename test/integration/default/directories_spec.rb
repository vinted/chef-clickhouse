%w[
  /etc/clickhouse-server
  /etc/clickhouse-server/clickhouse-server
  /var/log/clickhouse-server
  /var/lib/clickhouse-server
  /var/lib/clickhouse-server/tmp
  /var/lib/clickhouse-server/format_schemas
].each do |directory|
  describe file(directory) do
    it { should exist }
    it { should be_directory }
    it { should be_mode 0o750 }
    it { should be_owned_by 'clickhouse' }
    it { should be_grouped_into 'clickhouse' }
  end
end
