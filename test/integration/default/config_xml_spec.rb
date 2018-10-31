settings_to_test = %w(
  <level>error</level>
  <size>101M</size>
  <count>100</count>
  <display_name>kitchen-test</display_name>
  <interserver_http_port>9019</interserver_http_port>
  <listen_host>::1</listen_host>
  <listen_try>0</listen_try>
  <listen_reuse_port>0</listen_reuse_port>
  <listen_backlog>10</listen_backlog>
  <max_connections>3000</max_connections>
  <keep_alive_timeout>4</keep_alive_timeout>
  <max_concurrent_queries>100</max_concurrent_queries>
  <uncompressed_cache_size>10101010101</uncompressed_cache_size>
  <mark_cache_size>10101</mark_cache_size>
  <path>/var/lib/clickhouse-server-test/</path>
  <tmp_path>/var/lib/clickhouse-server-test/tmp/</tmp_path>
  <user_files_path>/var/lib/clickhouse-server-test/user_files/</user_files_path>
  <users_config>users.xml</users_config>
  <timezone>Zulu</timezone>
  <builtin_dictionaries_reload_interval>12</builtin_dictionaries_reload_interval>
  <max_session_timeout>4999</max_session_timeout>
  <default_session_timeout>41</default_session_timeout>
) + [
  '<remote_servers>',
  '<zookeeper />',
  '<macros />',
  '<compression>',
]

describe file('/etc/clickhouse-server/clickhouse-server-test/config.xml') do
  settings_to_test.each do |setting_to_test|
    its(:content) { should match(setting_to_test) }
  end
end
