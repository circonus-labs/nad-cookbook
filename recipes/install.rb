# Installs nad using tarball method

unless node[:nad][:enabled] then return end

package "nodejs for nad" do
  case node[:platform]
  when 'ubuntu'
    package_name 'nodejs'
  when 'centos'
    package_name 'npm' # EPEL
  end
end  

file_name = node[:nad][:download_file]
unless file_name then
  case node[:platform]
  when 'ubuntu'
    # TODO make this arch and release safe
    local_file = 'ubuntu-12.04.1-64-nad.tar.gz'
  else
    #raise "TODO"
  end
end

#local_path = File.join(node[:nad][:tmp_path], file_name)
#url = node[:nad][:download_url] + '/' + local_file

#remote_file local_path do
#   source nadPkgSource 
#   mode 00644
#   retries 5
#   retry_delay 5
#   only_if { ! File.exist ... } # TODO check for existing nad install
#end

# bash "unpack nad tarball" do
#    cwd node[:nad][:tmp_path]
#    command "tar xzf #{file_name} -C / && rm #{local_path}"
#    only_if "test -f #{local_path}"
# end

# service "nad" do
#    action [:enable, :start]
# end

