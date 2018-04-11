# frozen_string_literal: true
source 'https://supermarket.chef.io'

metadata

cookbook 'poise', '~> 2.8.1'
cookbook 'poise-service', '~> 1.5.2'
cookbook 'ulimit', '~> 1.0.0'

group :integration do
  cookbook 'test-clickhouse', path: 'test/integration/cookbooks/test-clickhouse'
end
