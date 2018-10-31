require_relative 'clickhouse_custom_config'

class Chef
  class Resource
    # ClickHouse macros configuration
    class ClickHouseMacrosConfig < ClickHouseCustomConfig
      provides(:clickhouse_macros_config)

      def config_name
        'macros'
      end

      def template_cookbook
        node['clickhouse']['server']['macros']['cookbook']
      end
    end
  end

  class Provider
    # ClickHouse macros provider
    class ClickHouseMacrosConfig < ClickHouseCustomConfig
      provides(:clickhouse_macros_config)

      protected

      def custom_config_path
        ::File.join(service_conf_d_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
