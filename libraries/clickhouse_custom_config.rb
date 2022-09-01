require_relative 'clickhouse_base'

class Chef
  class Resource
    # ClickHouse custom configuration
    class ClickHouseCustomConfig < ClickhouseBaseService
      provides(:clickhouse_custom_config)

      # Service
      attribute(:service_name, kind_of: String, default: 'clickhouse-server')
      attribute(:config_name, kind_of: String, default: 'custom.xml')
      # Whatever format
      attribute(:config, kind_of: [String, Hash, Chef::Node::ImmutableMash])

      attribute(:template_cookbook, kind_of: String, default: 'clickhouse')
      attribute(:template_source, kind_of: String, default: 'custom.xml.erb')
    end
  end

  class Provider
    # ClickHouse custom provider
    class ClickHouseCustomConfig < ClickhouseBaseService
      provides(:clickhouse_custom_config)

      def action_delete
        file custom_config_path do
          action :delete
        end
      end

      protected

      def validate_config_attribute!
        config = new_resource.config
        raise_error_msg 'config attribute is required' unless config
      end

      def validate!
        super
        check_if_dir_exist?(
          service_config_path,
          'check if `service_name` attribute is set and valid'
        )
        validate_config_attribute!
      end

      def variables
        {
          config: new_resource.config,
        }
      end

      # rubocop:disable Metrics/AbcSize
      def deriver_install
        vars = variables
        template custom_config_path do
          source new_resource.template_source
          user new_resource.user
          group new_resource.group
          cookbook new_resource.template_cookbook
          mode '0640'
          variables vars
        end
      end

      def service_config_path
        ::File.join(new_resource.config_dir, new_resource.service_name)
      end

      def service_conf_d_path
        ::File.join(service_config_path, 'conf.d')
      end

      def custom_config_path
        ::File.join(service_conf_d_path, new_resource.config_name)
      end
    end
  end
end
