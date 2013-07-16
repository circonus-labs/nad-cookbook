def whyrun_supported?
  true
end

action :enable do
  unless new_resource.subdir then
    raise "You must specify a 'subdir' when enabling a nad_script"
  end
  real_path = ::File.join(node[:nad][:config_dir], new_resource.subdir, new_resource.name)
  link_path = ::File.join(node[:nad][:config_dir], new_resource.name)
  unless ::File.exist?(real_path)
    raise "Cannot enable nad script #{new_resource.subdir}/#{new_resource.name}: no such file #{real_path}"
  end
  link link_path do
    action :create
    to real_path
  end
end

action :disable do
  link_path = ::File.join(node[:nad][:config_dir], new_resource.name)

  link link_path do
    action :delete
  end    
end
