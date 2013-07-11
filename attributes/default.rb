default[:nad][:enabled] = true
default[:nad][:tmp_path] = '/tmp'
default[:nad][:download_url] = 'http://updates.circonus.com/node-agent'
# recipe nad::install provides a default if you don't override
default[:nad][:download_file] = nil 
