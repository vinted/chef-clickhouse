require 'poise'
require 'chef/resource'
require 'chef/provider'

class Chef
  class Resource
    # Base Clickhouse resource which is meant to be derived
    class ClickhouseBaseService < Chef::Resource
      include Poise(container: true)

      actions(:install)

      attribute(
        :user,
        kind_of: String,
        default: lazy { node['clickhouse']['user'] }
      )
      attribute(
        :group,
        kind_of: String,
        default: lazy { node['clickhouse']['group'] }
      )
      attribute(:config_dir, kind_of: String, default: '/etc/clickhouse-server')
    end
  end

  class Provider
    # Base Clickhouse provider which is meant to be derived
    class ClickhouseBaseService < Chef::Provider
      include Poise

      def action_install
        converge_by("Installing ClickHouse: #{new_resource.name}") do
          notifying_block do
            validate!
            create_user
            manage_ulimit
            install_dependencies
            install_clickhouse_repository
            deriver_install
          end
        end
      end

      def action_delete
        raise 'Not implemented: action_delete'
      end

      def rhel_family?
        %w[rhel centos].include?(node['platform'])
      end

      def debian_family?
        %w[debian ubuntu].include?(node['platform'])
      end

      protected

      def deriver_install
        raise_error_msg 'Not implemented: deriver_install'
      end

      def raise_error_msg(m)
        raise "Clickhouse #{self.class.name} #{new_resource.name}: #{m}"
      end

      def validate!
        platform_supported?
        cpu_sse4_flag_present?
      end

      def cpu_sse4_flag_present?
        return if node['cpu']['0']['flags'].include?('sse4_2')
        raise_error_msg 'SSE4 CPU flag is not supported'
      end

      def platform_supported?
        return if %w[redhat centos debian ubuntu].include?(node['platform'])
        raise_error_msg "Platform #{node['platform']} is not supported"
      end

      def create_directories(*dirs)
        Array(dirs).flatten.each do |dir|
          directory dir do
            owner new_resource.user
            group new_resource.group
            mode '0750'
          end
        end
      end

      def check_if_dir_exist?(dir, msg)
        return if Dir.exist?(dir)
        raise_error_msg "directory #{dir} does not exist, #{msg}"
      end

      private

      def manage_ulimit
        user_ulimit new_resource.user do
          filehandle_soft_limit 262_144
          filehandle_hard_limit 262_144
        end
      end

      def create_user
        group new_resource.group do
          action :create
        end

        user new_resource.user do
          group new_resource.group
          shell '/bin/false'
          action :create
        end
      end

      def install_dependencies
        package 'curl'
      end

      # rubocop:disable Metrics/LineLength
      # rubocop:disable Metrics/MethodLength
      def install_clickhouse_repository
        case node['platform']
        when 'rhel', 'centos'
          execute 'curl -s https://packagecloud.io/install/repositories/Altinity/clickhouse/script.rpm.sh | sudo bash' do
            creates '/etc/yum.repos.d/Altinity_clickhouse.repo'
          end
        when 'ubuntu', 'debian'
          execute 'apt_update_for_chef_clickhouse' do
            command %(apt-get update)
            action :nothing
          end

          execute 'curl -s https://packagecloud.io/install/repositories/Altinity/clickhouse/script.deb.sh | sudo bash' do
            creates '/etc/apt/sources.list.d/Altinity_clickhouse.list'
            notifies :run, 'execute[apt_update_for_chef_clickhouse]', :immediate
          end
        end
      end
    end
  end
end
