case node[:platform]
when 'ubuntu', 'debian', 'centos', 'rhel', 'scientific'
  include_recipe "nad::install"
when 'smartos'
  include_recipe "nad::smartos"
end
include_recipe "nad::configure"
