def rhel_family?
  %w[rhel centos rocky].include?(os[:platform])
end
