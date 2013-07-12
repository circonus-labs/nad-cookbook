

details = {}
case node[:platform]
when 'ubuntu', 'debian'
  details[:conf_file] = '/etc/default/nad'
when 'centos', 'rhel', 'scientific'
  details[:conf_file] = '/etc/sysconfig/nad'
end

template details[:conf_file] do 
  source 'nad.conf.erb'
  mode '0444'
end

service "nad (restarter)" do
  action :nothing
  service_name 'nad'
  subscribes :restart, resources("template[#{details[:conf_file]}]")
end
