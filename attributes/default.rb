default[:nad][:enabled] = true
default[:nad][:tmp_path] = '/tmp'
default[:nad][:download_url] = 'http://updates.circonus.net/node-agent/packages'

# recipe nad::install provides a default if you don't override
default[:nad][:download_file] = nil 

# recipe nad::install provides a default if you don't override
default[:nad][:release] = nil

default[:nad][:port] = 2609
# default[:nad][:ip] = 
# default[:nad][:ssl_port] = 
# default[:nad][:ssl_ip] = 

default[:nad][:config_dir] = '/opt/circonus/etc/node-agent.d'
