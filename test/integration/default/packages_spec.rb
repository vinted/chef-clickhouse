require_relative 'helpers_spec'

describe package('curl') do
  it { should be_installed }
end

if rhel_family?
  describe package('clickhouse-server') do
    it { should be_installed }
  end
end

if debian_family?
  describe package('clickhouse-server-base') do
    it { should be_installed }
  end
end
