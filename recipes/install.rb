# Installs nad using tarball method

unless node[:nad][:enabled] then return end

file_name = node[:nad][:download_file]
unless file_name then
  case node[:platform]
  when 'ubuntu'
    # TODO make this arch and release safe
    file_name = 'ubuntu-12.04.1-64-nad.tar.gz'
  else
    #raise "TODO"
  end
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

