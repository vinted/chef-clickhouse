require_relative 'clickhouse_base'

class Chef
  class Resource
    # ClickHouse macros configuration
    class ClickHouseMacrosConfig < ClickhouseBaseService
      provides(:clickhouse_macros_config)

      # Service
      attribute(:service_name, kind_of: String, default: 'clickhouse-server')
      attribute(
        :config_name,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['config']['macros']['incl']
        end
      )
      # Whatever format
      attribute(:config)

      attribute(
        :template_cookbook,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['macros']['cookbook']
        end
      )
      attribute(:template_source, kind_of: String, default: 'macros.xml.erb')
    end
  end

  class Provider
    # ClickHouse macros provider
    class ClickHouseMacrosConfig < ClickhouseBaseService
      provides(:clickhouse_macros_config)

      def action_delete
        file macros_config_path do
          action :delete
        end
      end

      protected

      def validate!
        super
        check_if_dir_exist?(
          service_config_path,
          'check if `service_name` attribute is set and valid'
        )
        config = new_resource.config
        raise_error_msg 'config attribute is required' unless config
      end

      # rubocop:disable Metrics/AbcSize
      def deriver_install
        template macros_config_path do
          source new_resource.template_source
          user new_resource.user
          group new_resource.group
          cookbook new_resource.template_cookbook
          mode '0640'
          variables config: new_resource.config
        end
      end

      private

      def service_config_path
        ::File.join(new_resource.config_dir, new_resource.service_name)
      end

      def macros_config_path
        ::File.join(service_config_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
