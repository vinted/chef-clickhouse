require_relative 'clickhouse_custom_config'

class Chef
  class Resource
    # ClickHouse zookeeper configuration
    class ClickHouseZookeeperConfig < ClickHouseCustomConfig
      provides(:clickhouse_zookeeper_config)

      # Must be array of hashes, e.g.:
      # [{index: 1, 'host' => 'localhost', 'port' => 2181}]
      # index: key is optional
      attribute(:nodes, kind_of: Array, default: lazy {
        raise "`nodes` attribute can't be empty"
      })
      attribute(:config_name, kind_of: String, default: 'zookeeper')

      def template_cookbook
        node['clickhouse']['server']['zookeeper']['cookbook']
      end

      def template_source
        'zookeeper.xml.erb'
      end
    end
  end

  class Provider
    # ClickHouse zookeeper provider
    class ClickHouseZookeeperConfig < ClickHouseCustomConfig
      provides(:clickhouse_zookeeper_config)

      protected

      def validate_config_attribute!
      end

      def validate!
        super
        nodes = new_resource.nodes
        unless nodes.is_a?(Array)
          raise_error_msg '`nodes` attribute must be Array'
        end
        nodes.each do |node|
          raise_error_msg "#{node} must be hash" unless node.is_a?(Hash)
          raise_error_msg "#{node} missing key 'host'" unless node['host']
          raise_error_msg "#{node} missing key 'port'" unless node['port']
          raise_error_msg "#{node} key 'port' must be Integer" unless node['port'].is_a?(Integer)
        end
      end

      def variables
        {
          nodes: new_resource.nodes
        }
      end

      def custom_config_path
        ::File.join(service_conf_d_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
