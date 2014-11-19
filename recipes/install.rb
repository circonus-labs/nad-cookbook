# Installs nad using omnibus tarball method

unless node[:nad][:enabled] then return end

return if File.exists?('/opt/circonus/sbin/nad')

require 'open-uri'

file_name = node[:nad][:download_file]
unless file_name then

  # e.g. :
  # nad-omnibus-20140630T182203Z-1.ubuntu.14.04_amd64.deb or
  # nad-omnibus-20140630T182203Z-1.el6.x86_64.rpm

  prefix = "nad-omnibus"
  arch = node[:kernel][:machine] # From ohai
  suffix = ".tar.gz"

  os = nil
  case node[:platform]
  when 'ubuntu'    
    platform = 'ubuntu.'
    # Want '12.04' as string
    platform += node[:platform_version] + '_'
    # because Debian
    if arch == 'x86_64'
      arch = 'amd64'
    end
    platform += arch
    suffix = ".deb"
  when 'centos', 'rhel', 'scientific'
    platform = 'el'
    # Want 5 or 6 as string, no minor version
    platform += node[:platform_version].to_i.to_s + '.'
    platform += arch
    suffix = ".rpm"
  else
    raise "No pre-packaged nad for #{platform}"
  end

  release = node[:nad][:release]
  unless release then
    html = open(node[:nad][:download_url]).read

    # The right thing to do
    # doc = Nokogiri::HTML(html)
    # candidates = doc.xpath("//a[starts-with(@href, '#{prefix}') and ends-with(@href, '#{platform}#{suffix}')]/@href")

    # The portable thing to do    
    candidates = html.scan(/href="#{prefix}-(.+)\.#{platform}#{suffix}"/).map { |c| c[0] }
    if candidates.empty? then 
      raise "Could not find a release version for #{platform} at #{node[:nad][:download_url]}.  Consider setting node[:nad][:download_file] to explicitly set it."
    end
    release = candidates.sort[-1]                          
  end

  file_name  = prefix + '-' 
  file_name += release + '.'
  file_name += platform
  file_name += suffix

end

local_path = File.join(node[:nad][:tmp_path], file_name)
url = node[:nad][:download_url] + '/' + file_name

remote_file local_path do
  source url
  mode '0644'
  retries 5
  retry_delay 5
end

case node[:platform]
  when 'ubuntu'
    install_command = "dpkg -i #{local_path} && rm #{local_path}"
  when 'centos', 'rhel', 'scientific'
    install_command = "yum -y --nogpgcheck localinstall #{local_path} && rm #{local_path}"
end

bash "install nad" do
  code install_command
  only_if "test -f #{local_path}"
end

service "nad (starter)" do
  service_name 'nad'
  action [:enable, :start]
end

