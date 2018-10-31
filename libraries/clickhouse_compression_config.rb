require_relative 'clickhouse_custom_config'

class Chef
  class Resource
    # ClickHouse compression configuration
    class ClickHouseCompressionConfig < ClickHouseCustomConfig
      provides(:clickhouse_compression_config)

      def config_name
        'compression'
      end

      def template_cookbook
        node['clickhouse']['server']['compression']['cookbook']
      end
    end
  end

  class Provider
    # ClickHouse compression provider
    class ClickHouseCompressionConfig < ClickHouseCustomConfig
      provides(:clickhouse_compression_config)

      protected

      def custom_config_path
        ::File.join(service_conf_d_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
