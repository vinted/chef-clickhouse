def rhel_family?
  %w[rhel centos].include?(os[:platform])
end

def debian_family?
  %w[debian ubuntu].include?(os[:platform])
end
