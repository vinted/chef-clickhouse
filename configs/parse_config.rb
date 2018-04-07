require 'active_support/all'
require 'pp'

file = ARGV[0]

raise "Provide file path to parse" unless file
raise "File #{file} does not exist" unless File.exist?(file)

config = File.read(file)

hash = Hash.from_xml(config)

def to_flat_array(keys)
  [keys].flatten
end

def map_as_attr(key)
  key = [key] unless key.is_a?(Array)
  key.map { |k| "['#{k}']" }.join('')
end

def construct_attributes(tmp_hash, k, v)
  case v
  when Hash
    v.each do |k2, v2|
      construct_attributes(tmp_hash, to_flat_array([k, k2]), v2)
    end
  when Array
    v.each do |v2|
      construct_attributes(tmp_hash, to_flat_array(k), v2)
    end
  else
    tmp_hash[k] = v
  end
end

tmp_hash = {}

hash['yandex'].each do |k, v|
  construct_attributes(tmp_hash, k, v)
end

def parse_value(v)
  if v =~ /^\d+/
    v.to_i
  elsif v =~ /^true$/
    true
  elsif v =~ /^false$/
    false
  else
    "'#{v}'"
  end
end

DEFAULT_PREFIX = "default['clickhouse']['server']['config']"
CONFIG_PREFIX = "node['clickhouse']['server']['config']"

# puts hash

server_attributes = StringIO.new
server_attributes.write "# Auto generated from: #{file}'"

tmp_hash.each do |k, v|
  v = v.to_s.strip
  next if v.empty?
  config_key = map_as_attr(k)
  config_value = parse_value(v)
  server_attributes.write("\n#{DEFAULT_PREFIX}#{config_key} = #{config_value}")
end

# IO.write(File.join(Dir.pwd, '..', 'attributes/server.rb'), server_attributes.string)
puts server_attributes.string
