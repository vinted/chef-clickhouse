describe service('clickhouse-server-test') do
  # it { should be_enabled } does not work on Ubuntu1404
  it { should be_installed }
  it { should be_running }
end
