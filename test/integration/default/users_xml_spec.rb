settings_to_test = %w(
  <max_memory_usage>10000000000</max_memory_usage>
  <use_uncompressed_cache>0</use_uncompressed_cache>
  <load_balancing>random</load_balancing>
)

describe file('/etc/clickhouse-server/clickhouse-server-test/users.xml') do
  settings_to_test.each do |setting_to_test|
    its(:content) { should match(setting_to_test) }
  end
end
