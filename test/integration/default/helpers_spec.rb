def rhel_family?
  %w(redhat centos rocky).include?(os[:platform])
end
