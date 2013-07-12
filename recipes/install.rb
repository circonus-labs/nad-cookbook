# Installs nad using omnibus tarball method

unless node[:nad][:enabled] then return end

file_name = node[:nad][:download_file]
unless file_name then

  # e.g. :
  # nad-omnibus-20130711T191911Z-rhel5-i386.tar.gz

  arch = node[:kernel][:machine] # From ohai
  os = nil

  case node[:platform]
  when 'ubuntu'    
    os = 'ubuntu-'
    # Want '12.04' as string
    os += node[:platform_version]    
  when 'centos', 'rhel', 'scientific'
    os = 'rhel'  # no hyphen, sigh
    # Want 5 or 6 as string, no minor version
    os += node[:platform_version].to_i.to_s    
  else
    raise "TODO - port nad install to #{node[:platform]}"
  end

  file_name = 'nad-omnibus-' 
  file_name += node[:nad][:release] + '-'
  file_name += os + '-'
  file_name += arch
  file_name += '.tar.gz'

end

local_path = File.join(node[:nad][:tmp_path], file_name)
url = node[:nad][:download_url] + '/' + file_name

remote_file local_path do
  source url
  mode '0644'
  retries 5
  retry_delay 5
  not_if { File.exist?('/opt/circonus/sbin/nad') }
end

bash "unpack nad tarball" do
  code "tar xzf #{local_path} -C / && rm #{local_path}"
  only_if "test -f #{local_path}"
end

service "nad (starter)" do
  service_name 'nad'
  action [:enable, :start]
end

