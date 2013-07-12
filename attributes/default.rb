default[:nad][:enabled] = true
default[:nad][:tmp_path] = '/tmp'
default[:nad][:download_url] = 'http://updates.circonus.com/node-agent'
# recipe nad::install provides a default if you don't override
default[:nad][:download_file] = nil 
#default[:nad][:release] = '20130711T191911Z'
default[:nad][:release] = '20130712T154029Z'
default[:nad][:port] = 2609
# default[:nad][:ip] = 
# default[:nad][:ssl_port] = 
# default[:nad][:ssl_ip] = 

default[:nad][:config_dir] = '/opt/circonus/etc/node-agent.d'
