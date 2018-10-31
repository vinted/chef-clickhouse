require_relative 'clickhouse_custom_config'

class Chef
  class Resource
    # ClickHouse remote_servers configuration
    class ClickHouseRemoteServerConfig < ClickHouseCustomConfig
      provides(:clickhouse_remote_servers_config)

      def config_name
        'remote_servers'
      end

      def template_cookbook
        node['clickhouse']['server']['remote_servers']['cookbook']
      end
    end
  end

  class Provider
    # ClickHouse remote_servers provider
    class ClickHouseRemoteServerConfig < ClickHouseCustomConfig
      provides(:clickhouse_remote_servers_config)

      protected

      def custom_config_path
        ::File.join(service_conf_d_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
