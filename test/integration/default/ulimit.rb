describe file('/etc/security/limits.d/clickhouse_limits.conf') do
  it { should exist }
  its(:content) { should include('clickhouse soft nofile 262144') }
  its(:content) { should include('clickhouse hard nofile 262144') }
end
