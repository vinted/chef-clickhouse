# chef-clickhouse

[![Build Status](https://travis-ci.org/ernestas-poskus/chef-clickhouse.svg?branch=master)](https://travis-ci.org/ernestas-poskus/chef-clickhouse)
[![Cookbook Version](https://img.shields.io/cookbook/v/clickhouse.svg)](https://supermarket.chef.io/cookbooks/clickhouse)

Installs and manages ClickHouse server instances.

## Requirements

- Chef 12.5 or higher
- Network accessible package repositories
- Zookeeper (optional) only for distributed mode

## Attributes

```ruby
default['clickhouse']['user'] = 'clickhouse'
default['clickhouse']['group'] = 'clickhouse'

case node['platform']
when 'rhel', 'centos'
  default['clickhouse']['server']['version'] = '1.1.54362'
when 'ubuntu', 'debian'
  default['clickhouse']['server']['version'] = '1.1.54343'
end

# Override config.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['configuration']['cookbook'] = 'clickhouse'

# Override users.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['users']['cookbook'] = 'clickhouse'

# Override zookeeper-servers.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['zookeeper']['cookbook'] = 'clickhouse'

# Override macros.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['macros']['cookbook'] = 'clickhouse'

# Override macros.xml Chef template resource `cookbook` location.
# Useful in wrapping cookbooks.
default['clickhouse']['server']['remote_servers']['cookbook'] = 'clickhouse'
```

Also:
 - defaults/server.rb
 - defaults/users.rb
 - defaults/packages.rb

## Usage

Place a dependency on the mysql cookbook in your cookbook's metadata.rb

```ruby
depends 'clickhouse'
```

There are two ways to install ClickHouse.

  1. By including recipe
  ```ruby
  include_recipe 'clickhouse::server'
  ```
  2. By using Chef resources, note service_name here, it must be same
  per configured ClickHouse service instance.
  ```ruby
  clickhouse_server_service 'clickhouse server instance' do
    service_name 'clickhouse-server-test'
  end

  clickhouse_macros_config 'clickhouse server macros config' do
    service_name 'clickhouse-server-test'
    config '<macros></macros>'
  end

  clickhouse_remote_servers_config 'clickhouse remote servers config' do
    service_name 'clickhouse-server-test'
    config '<remote_servers></remote_servers>'
  end

  clickhouse_zookeeper_config 'clickhouse server zookeeper config' do
    service_name 'clickhouse-server-test'
    nodes [
      { host: '127.0.0.1', port: 2181 }
    ]
  end
  ```

## Resources Overview

### clickhouse_server_service

The `clickhouse_server_service` resource manages ClickHouse server installation.

The `:create` action handles package installation, support directories and other operating system level concerns.
The internal configuration file contains just enough to get the service up and running.

##### Example

```ruby
clickhouse_server_service 'custom instance' do
  version '1.1.54362'
end
```

Please note that when using `notifies` or `subscribes`, the resource to reference is `clickhouse_server_service[custom instance]`, not `service[custom instance]`.

##### Parameters

- `user` - operating system user to run ClickHouse
- `group` - operating system group to run ClickHouse
- `config_dir` - configuration namespace directory, default is /etc/clickhouse-server/{custom instance}
- `version` - specifies ClickHouse package version
- `package_release` - package release, usually relevant for RHEL, e.g.: el6, el7
- `bin_dir` - where to look for ClickHouse server binary
- `generic_bin` - ClickHouse generic bin, default is `clickhouse` used for config.xml template validation
- `server_bin` - ClickHouse server binary name, default is `clickhouse-server`
- `config` - given configuration of `config.xml`, default is `node['clickhouse']['server']['config']`
- `users` - given configuration of `config.xml`, `users.xml` include, default is `node['clickhouse']['server']['users']`
- `service_name` - defaults to `clickhouse-server`
- `service_provider` - accepts symbol and controls service file flavor, for `poise_service`, defaults to: `:systemd` or `sysvinit` depending on availability
- `config_template_cookbook` - template cookbook source, defaults to `node['clickhouse']['server']['configuration']['cookbook']`
- `users_template_cookbook` - template cookbook source, defaults to `node['clickhouse']['server']['users']['cookbook']`
- `config_template_source` - template cookbook source, defaults to `config.xml.erb`
- `users_template_source` - template cookbook source, defaults to `users.xml.erb`

##### Actions

- `:create` - Configures everything from repository, package to service.
- `:delete` - Removes everything but the package and directories.

### clickhouse_macros_config

The `clickhouse_macros_config` resource manages ClickHouse server macros for ClickHouse server.

The `:create` action macros file installation.

##### Example

```ruby
clickhouse_macros_config 'custom instance' do
  service_name 'clickhouse-server-your-service'
  config '<macros></macros>'
end
```

Please note that when using `notifies` or `subscribes`, the resource to reference is `clickhouse_macros_config[custom instance]`, not `service[custom instance]`.

##### Parameters

- `user` - operating system user to run ClickHouse
- `group` - operating system group to run ClickHouse
- `config_dir` - configuration namespace directory, default is /etc/clickhouse-server/{custom instance}
- `service_name` - defaults to `clickhouse-server`
- `config_name` - defaults to `node['clickhouse']['server']['config']['macros']['incl']`
- `config` - whatever is passed here is reflected in 'macros.xml'
- `template_cookbook` - template cookbook source, defaults to `node['clickhouse']['server']['macros']['cookbook']`
- `template_source` - template cookbook source, defaults to `macros.xml.erb`

##### Actions

- `:create` - Installs macros.xml configuration file
- `:delete` - Removes macros.xml configuration file

### clickhouse_zookeeper_config

The `clickhouse_zookeeper_config` resource manages ClickHouse server Zookeeper servers for ClickHouse server instance.

The `:create` action zookeeper file installation.

##### Example

```ruby
clickhouse_zookeeper_config 'custom instance' do
  service_name 'clickhouse-server-custom'
  nodes [
    { host: '127.0.0.1', port: 2181 }
  ]
end
```

Please note that when using `notifies` or `subscribes`, the resource to reference is `clickhouse_zookeeper_config[custom instance]`, not `service[custom instance]`.

##### Parameters

- `user` - operating system user to run ClickHouse
- `group` - operating system group to run ClickHouse
- `config_dir` - configuration namespace directory, default is /etc/clickhouse-server/{custom instance}
- `service_name` - defaults to `clickhouse-server`
- `config_name` - defaults to `node['clickhouse']['server']['config']['macros']['incl']`
- `nodes` - expects Array of Hash 'es, e.g.: `[{index: 1, host: 'localhost', port: 2181}]`
- `template_cookbook` - template cookbook source, defaults to `node['clickhouse']['server']['zookeeper']['cookbook']`
- `template_source` - template cookbook source, defaults to `zookeeper.xml.erb`

##### Actions

- `:create` - Installs zookeeper-servers.xml configuration file
- `:delete` - Removes zookeeper-servers.xml configuration file

### clickhouse_remote_servers_config

The `clickhouse_remote_servers_config` resource manages ClickHouse server macros for ClickHouse server.

The `:create` action macros file installation.

##### Example

```ruby
clickhouse_remote_servers_config 'custom instance' do
  service_name 'clickhouse-server-your-service'
  config '<remote_servers></remote_servers>'
end
```

Please note that when using `notifies` or `subscribes`, the resource to reference is `clickhouse_remote_servers_config[custom instance]`, not `service[custom instance]`.

##### Parameters

- `user` - operating system user to run ClickHouse
- `group` - operating system group to run ClickHouse
- `config_dir` - configuration namespace directory, default is /etc/clickhouse-server/{custom instance}
- `service_name` - defaults to `clickhouse-server`
- `config_name` - defaults to `node['clickhouse']['server']['config']['macros']['incl']`
- `config` - whatever is passed here is reflected in 'clickhouse_remote_servers.xml'
- `template_cookbook` - template cookbook, defaults to `node['clickhouse']['server']['remote_servers']['cookbook']`
- `template_source` - template cookbook source, defaults to `remote_servers.xml.erb`

##### Actions

- `:create` - Installs clickhouse_remote_servers.xml configuration file
- `:delete` - Removes clickhouse_remote_servers.xml configuration file

### clickhouse_custom_config

The `clickhouse_custom_config` resource manages ClickHouse server custom xml or any other file configuration for ClickHouse server.

The `:create` action macros file installation.

##### Example

```ruby
clickhouse_custom_config 'custom instance' do
  service_name 'clickhouse-server-your-service'
  config 'your value'
  config_name 'test-custom.xml'
end
```

Please note that when using `notifies` or `subscribes`, the resource to reference is `clickhouse_custom_config[custom instance]`, not `service[custom instance]`.

##### Parameters

- `user` - operating system user to run ClickHouse
- `group` - operating system group to run ClickHouse
- `config_dir` - configuration namespace directory, default is /etc/clickhouse-server/{custom instance}
- `service_name` - defaults to `clickhouse-server`
- `config_name` - defaults to `custom.xml`
- `config` - whatever is passed here is reflected in 'custom.xml' or whatever what is provided in `config_name`
- `template_cookbook` - template cookbook, defaults to `clickhouse`
- `template_source` - template cookbook source, defaults to `custom.xml.erb`

##### Actions

- `:create` - Installs custom.xml configuration file
- `:delete` - Removes custom.xml configuration file

## Manual tuning

CPU frequency tunning
```
sudo echo 'performance' | tee /sys/devices/system/cpu/cpu\*/cpufreq/scaling_governor
```

Disable huge pages
```
echo 'never' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
```

## Production architecture

https://github.com/yandex/ClickHouse/issues/1272

## License

```text
MIT License

Copyright (c) 2018 Ernestas Poskus

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
