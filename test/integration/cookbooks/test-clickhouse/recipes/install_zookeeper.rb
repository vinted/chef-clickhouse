openjdk_install '11'

directory '/usr/lib/zookeeper' do
  mode '0755'
  action :create
end

execute 'curl -k https://dlcdn.apache.org/zookeeper/zookeeper-3.8.0/apache-zookeeper-3.8.0-bin.tar.gz | tar -xz --strip-components 1 -C /usr/lib/zookeeper' do
  creates '/usr/lib/zookeeper/bin/zkServer.sh'
end

file '/usr/lib/zookeeper/conf/zoo.cfg' do
  content lazy { ::File.open('/usr/lib/zookeeper/conf/zoo_sample.cfg').read }
  mode '0755'
end

# dirty way to start zookeeper
execute 'start zookeeper' do
  command '/usr/lib/zookeeper/bin/zkServer.sh start'
  creates '/tmp/zookeeper/zookeeper_server.pid'
  action :run
end
