describe package('curl') do
  it { should be_installed }
end

describe package('clickhouse-server') do
  it { should be_installed }
end
