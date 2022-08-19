def rhel_family?
  %w[rhel centos rocky].include?(os[:platform])
end

def debian_family?
  %w[debian ubuntu].include?(os[:platform])
end
