class Chef
  class Resource
    # ClickHouse keeper configuration
    class ClickHouseKeeperConfig < ClickHouseCustomConfig
      provides(:clickhouse_keeper_config)

      # Must be array of hashes, e.g.:
      # [{'server_id': 1, 'host' => 'localhost'}]
      attribute(:nodes, kind_of: Array, default: lazy do
        raise "`nodes` attribute can't be empty"
      end)
      attribute(
        :config,
        kind_of: [Hash, Chef::Node::ImmutableMash],
        default: lazy { node['clickhouse']['server']['config']['keeper'] }
      )
      attribute(:config_name, kind_of: String, default: 'keeper')

      def template_cookbook
        node['clickhouse']['server']['keeper']['cookbook']
      end

      def template_source
        'keeper.xml.erb'
      end
    end
  end

  class Provider
    # ClickHouse keeper provider
    class ClickHouseKeeperConfig < ClickHouseCustomConfig
      provides(:clickhouse_keeper_config)

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
          raise_error_msg "#{node} missing key 'server_id'" unless node['server_id']
          raise_error_msg "#{node} missing key 'host'" unless node['host']
          raise_error_msg "#{node} key 'server_id' must be Integer" unless node['server_id'].is_a?(Integer)
        end
      end

      def keeper_server_id
        keeper_node = new_resource.nodes.detect { |n| n['host'] == node['fqdn'] }
        raise_error_msg "Can't find #{node['fqdn']} `server_id` in nodes #{new_resource.nodes}" unless keeper_node
        keeper_node['server_id']
      end

      def variables
        {
          server_id: keeper_server_id,
          nodes: new_resource.nodes,
          config: new_resource.config,
        }
      end

      def custom_config_path
        ::File.join(service_conf_d_path, "#{new_resource.config_name}.xml")
      end
    end
  end
end
