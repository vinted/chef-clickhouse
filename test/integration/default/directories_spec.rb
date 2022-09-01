%w(
  /etc/clickhouse-server
  /etc/clickhouse-server/clickhouse-server-test
  /etc/clickhouse-server/clickhouse-server-test/conf.d
  /var/log/clickhouse-server-test
  /var/lib/clickhouse-server-test
  /var/lib/clickhouse-server-test/user_files
  /var/lib/clickhouse-server-test/tmp
  /var/lib/clickhouse-server-test/format_schemas
).each do |directory|
  describe file(directory) do
    it { should exist }
    it { should be_directory }
    it { should be_mode 00750 }
    it { should be_owned_by 'clickhouse' }
    it { should be_grouped_into 'clickhouse' }
  end
end
