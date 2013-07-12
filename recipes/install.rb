# Installs nad using omnibus tarball method

unless node[:nad][:enabled] then return end

return if File.exists?('/opt/circonus/sbin/nad')

require 'open-uri'

file_name = node[:nad][:download_file]
unless file_name then

  # e.g. :
  # nad-omnibus-20130711T191911Z-rhel5-i386.tar.gz

  prefix = "nad-omnibus"
  arch = node[:kernel][:machine] # From ohai
  suffix = ".tar.gz"

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

  release = node[:nad][:release]
  unless release then
    html = open(node[:nad][:download_url]).read

    # The right thing to do
    # doc = Nokogiri::HTML(html)
    # candidates = doc.xpath("//a[starts-with(@href, '#{prefix}') and ends-with(@href, '#{os}-#{arch}#{suffix}')]/@href")

    # The portable thing to do    
    candidates = html.scan(/href="#{prefix}-(.+)-#{os}-#{arch}#{suffix}"/).map { |c| c[0] }
    if candidates.empty? then 
      raise "Could not find a release version for #{os}-#{arch} at #{node[:nad][:download_url]}.  Consider setting node[:nad][:download_file] to explicitly set it."
    end
    release = candidates.sort[-1]                          
  end

  file_name  = prefix + '-' 
  file_name += release + '-'
  file_name += os + '-'
  file_name += arch
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

bash "unpack nad tarball" do
  code "tar xzf #{local_path} -C / && rm #{local_path}"
  only_if "test -f #{local_path}"
end

service "nad (starter)" do
  service_name 'nad'
  action [:enable, :start]
end

