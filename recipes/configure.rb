details = {}
case node[:platform]
when 'ubuntu', 'debian'
  details[:conf_file] = '/etc/default/nad'
when 'centos', 'rhel', 'scientific'
  details[:conf_file] = '/etc/sysconfig/nad'
when 'smartos'
  details[:conf_file] = '/opt/circonus/etc/nad.conf'
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

case node[:platform]  
when 'smartos'
smf "nad" do
  user "nobody"
  start_command "/opt/circonus/sbin/nad -c /opt/circonus/etc/node-agent.d -p #{node['privateaddress']}:#{node['nad']['port']}"
  environment "HOME" => "/opt/circonus/etc",
              "PATH" => "/opt/local/bin:/opt/local/sbin:/usr/bin:/usr/sbin",
              "NODE_PATH" => "/opt/circonus/lib/node_modules"
  manifest_type "application"
  duration "child"
end
service 'nad'
end
