# chef-clickhouse

[![Build Status](https://travis-ci.org/ernestas-poskus/chef-clickhouse.svg?branch=master)](https://travis-ci.org/ernestas-poskus/chef-clickhouse)
[![Cookbook Version](https://img.shields.io/cookbook/v/clickhouse.svg)](https://supermarket.chef.io/cookbooks/clickhouse)

TODO: Enter the cookbook description here.

### Manual tuning

CPU frequency tunning
```
sudo echo 'performance' | tee /sys/devices/system/cpu/cpu\*/cpufreq/scaling_governor
```

Disable huge pages
```
echo 'never' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
```

### Production architecture

https://github.com/yandex/ClickHouse/issues/1272
