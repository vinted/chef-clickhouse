describe file('/etc/clickhouse-server/clickhouse-server-test/zookeeper-servers.xml') do
  its(:content) { should match(%r{<host>127.0.0.1<\/host>}) }
  its(:content) { should match(%r{<port>2181<\/port>}) }
end
