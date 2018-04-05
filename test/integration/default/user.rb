describe group('clickhouse') do
  it { should exist }
end

describe user('clickhouse') do
  it { should exist }
  its('groups') { should include('clickhouse') }
  its('shell') { should include('/bin/false') }
end
