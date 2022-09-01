keeper_hostname = inspec.command('hostname').stdout.chomp

settings_to_test = %W(
  <server_id>1</server_id>
  <tcp_port>2181</tcp_port>
  <log_storage_path>/var/lib/clickhouse/coordination/log</log_storage_path>
  <snapshot_storage_path>/var/lib/clickhouse/coordination/snapshots</snapshot_storage_path>
  <operation_timeout_ms>10000</operation_timeout_ms>
  <min_session_timeout_ms>10000</min_session_timeout_ms>
  <session_timeout_ms>100000</session_timeout_ms>
  <dead_session_check_period_ms>500</dead_session_check_period_ms>
  <heart_beat_interval_ms>500</heart_beat_interval_ms>
  <election_timeout_lower_bound_ms>1000</election_timeout_lower_bound_ms>
  <election_timeout_upper_bound_ms>2000</election_timeout_upper_bound_ms>
  <rotate_log_storage_interval>100000</rotate_log_storage_interval>
  <reserved_log_items>100000</reserved_log_items>
  <snapshot_distance>100000</snapshot_distance>
  <snapshots_to_keep>3</snapshots_to_keep>
  <stale_log_gap>10000</stale_log_gap>
  <fresh_log_gap>200</fresh_log_gap>
  <max_requests_batch_size>100</max_requests_batch_size>
  <force_sync>true</force_sync>
  <quorum_reads>false</quorum_reads>
  <raft_logs_level>debug</raft_logs_level>
  <auto_forwarding>true</auto_forwarding>
  <shutdown_timeout>5000</shutdown_timeout>
  <startup_timeout>30000</startup_timeout>
  <raft_configuration>
  <server>
  <id>1</id>
  <hostname>#{keeper_hostname}</hostname>
  <port>9444</port>
  </server>
  </raft_configuration>
)

describe file('/etc/clickhouse-server/clickhouse-server-test/conf.d/kitchen_custom_keeper.xml') do
  it { should exist }
  it { should be_file }
  it { should be_mode 00640 }
  it { should be_owned_by 'clickhouse' }
  it { should be_grouped_into 'clickhouse' }
  settings_to_test.each do |setting_to_test|
    its(:content) { should match(setting_to_test) }
  end
end
