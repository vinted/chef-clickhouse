require_relative 'clickhouse_base'

class Chef
  class Resource
    # ClickHouse zookeeper configuration
    class ClickHouseZookeeperConfig < ClickhouseBaseService
      provides(:clickhouse_zookeeper_config)

      # Service
      attribute(:service_name, kind_of: String, default: 'clickhouse-server')
      attribute(
        :config_name,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['config']['zookeeper']['incl']
        end
      )
      # Must be array of hashes, e.g.:
      # [{index: 1, host: 'localhost', port: 2181}]
      # index: key is optional
      attribute(:nodes, kind_of: Array, default: [])

      attribute(
        :template_cookbook,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['zookeeper']['cookbook']
        end
      )
      attribute(:template_source, kind_of: String, default: 'zookeeper.xml.erb')
    end
  end

  class Provider
    # ClickHouse zookeeper provider
    class ClickHouseZookeeperConfig < ClickhouseBaseService
      provides(:clickhouse_zookeeper_config)

      def action_delete
        file zookeeper_config_path do
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
        nodes = new_resource.nodes
        raise_error_msg "`nodes` attribute can't be empty" if nodes.empty?
        unless nodes.is_a?(Array)
          raise_error_msg '`nodes` attribute must be Array'
        end
        nodes.each do |node|
          raise_error_msg "#{node} must be hash" unless node.is_a?(Hash)
          raise_error_msg "#{node} missing key :host" unless node[:host]
          raise_error_msg "#{node} missing key :port" unless node[:port]
          raise_error_msg "#{node} key :port must be Integer" unless node[:port].is_a?(Integer)
        end
      end

      # rubocop:disable Metrics/AbcSize
      def deriver_install
        template zookeeper_config_path do
          source new_resource.template_source
          user new_resource.user
          group new_resource.group
          cookbook new_resource.template_cookbook
          mode '0640'
          variables nodes: new_resource.nodes
        end
      end

      private

      def service_config_path
        ::File.join(new_resource.config_dir, new_resource.service_name)
      end

      def zookeeper_config_path
        ::File.join(service_config_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
