require_relative 'clickhouse_base'

class Chef
  class Resource
    # ClickHouse server resource
    class ClickhouseServerService < ClickhouseBaseService
      provides(:clickhouse_server_service)

      attribute(
        :version,
        kind_of: String,
        default: lazy { node['clickhouse']['server']['version'] }
      )
      attribute(
        :package_release,
        kind_of: String,
        default: lazy { node['clickhouse']['server']['package_release'] }
      )
      attribute(:bin_dir, kind_of: String, default: '/usr/bin')
      attribute(
        :generic_bin,
        kind_of: String,
        default: lazy { ::File.join(bin_dir, 'clickhouse') }
      )
      attribute(
        :server_bin,
        kind_of: String,
        default: lazy { ::File.join(bin_dir, 'clickhouse-server') }
      )
      attribute(
        :config,
        kind_of: [Hash, Chef::Node::ImmutableMash],
        default: lazy { node['clickhouse']['server']['config'] }
      )
      attribute(
        :users,
        kind_of: [Hash, Chef::Node::ImmutableMash],
        default: lazy { node['clickhouse']['server']['users'] }
      )

      # Service
      attribute(:service_name, kind_of: String, default: 'clickhouse-server')
      attribute(
        :service_provider,
        kind_of: Symbol,
        default: lazy do
          init_systemd = Mixlib::ShellOut.new('ps --no-headers -o comm 1')
          init_systemd.run_command
          init_systemd.error!
          if init_systemd.stdout.chomp == 'systemd'
            :systemd
          else
            :sysvinit
          end
        end
      )

      attribute(
        :config_template_cookbook,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['configuration']['cookbook']
        end
      )

      attribute(
        :users_template_cookbook,
        kind_of: String,
        default: lazy do
          node['clickhouse']['server']['users']['cookbook']
        end
      )
      attribute(:config_template_source, kind_of: String, default: 'config.xml.erb')
      attribute(:users_template_source, kind_of: String, default: 'users.xml.erb')
    end
  end

  class Provider
    # ClickHouse server provider
    # rubocop:disable Metrics/ClassLength
    class ClickhouseServerService < ClickhouseBaseService
      provides(:clickhouse_server_service)

      def action_delete
        service new_resource.service_name do
          action %i[stop disable]
        end
        file config_file_path do
          action :delete
        end
      end

      protected

      # rubocop:disable Metrics/MethodLength
      def deriver_install
        install_clickhouse_server_package
        create_directories(
          new_resource.config_dir,
          service_config_path,
          log_path,
          data_path,
          temp_data_path,
          format_schema_path
        )
        install_config
        install_users
        install_service
      end

      private

      def service_config_path
        @service_config_path ||= ::File.join(
          new_resource.config_dir,
          new_resource.service_name
        )
      end

      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/LineLength
      # rubocop:disable Style/FormatStringToken
      def install_config
        variables = template_config
        template config_file_path do
          source new_resource.config_template_source
          user new_resource.user
          group new_resource.group
          cookbook new_resource.config_template_cookbook
          mode '0640'
          variables variables
          # For releases of the chef-client prior to 12.5
          # (chef-client 12.4 and earlier) the correct syntax is:
          # %{path} vs %{file}
          verify "#{new_resource.generic_bin} extract-from-config --config-file='%{path}' --key=path"
        end
      end

      def template_config
        dp = data_path
        tdp = temp_data_path
        fsp = format_schema_path
        {
          config: new_resource.config,
          log_path: log_path,
          data_path: dp.end_with?('/') ? dp : "#{dp}/",
          temp_data_path: tdp.end_with?('/') ? tdp : "#{tdp}/",
          format_schema_path: fsp.end_with?('/') ? fsp : "#{fsp}/"
        }
      end

      def service_args
        @service_args ||= %W[
          --pid-file=#{pid_file_path}
          --config-file=#{config_file_path}
        ].join(' ')
      end

      def install_users
        template users_file_path do
          source new_resource.users_template_source
          user new_resource.user
          group new_resource.group
          cookbook new_resource.users_template_cookbook
          mode '0640'
          variables users: new_resource.users
        end
      end

      def data_path
        ::File.join('/var/lib', new_resource.service_name)
      end

      def temp_data_path
        ::File.join(data_path, '/tmp')
      end

      def format_schema_path
        ::File.join(data_path, '/format_schemas')
      end

      def config_file_path
        ::File.join(service_config_path, 'config.xml')
      end

      def users_file_path
        ::File.join(service_config_path, new_resource.config['users_config'])
      end

      def pid_file_path
        "/var/run/#{new_resource.service_name}.pid"
      end

      def log_path
        "/var/log/#{new_resource.service_name}"
      end

      def install_service
        command = "#{new_resource.server_bin} #{service_args}"
        poise_service new_resource.service_name do
          provider new_resource.service_provider
          command command
          user new_resource.user
          stop_signal 'TERM'
        end
      end

      def package_name
        if debian_family?
          'clickhouse-server-base'
        else
          'clickhouse-server'
        end
      end

      def install_clickhouse_server_package
        version = [
          new_resource.version,
          new_resource.package_release
        ].compact.join('-')
        package package_name do
          flush_cache %i[before] if rhel_family?
          version version
        end

        %w[
          /etc/cron.d/clickhouse-server
          /etc/init.d/clickhouse-server
          /etc/security/limits.d/clickhouse.conf
          /etc/clickhouse-server/users.xml
          /etc/clickhouse-server/config.xml
        ].each do |f|
          file f do
            action :delete
          end
        end
      end
    end
  end
end
