# nad cookbook

Install and configure nad, a nodejs-based monitoring agent.

More info on nad: https://github.com/circonus-labs/nad

## Platforms

centos, ubuntu

Other un*xes likely; windows unlikely

## Recipes

### `nad` (`nad::default`)

Runs the install recipe.

### `nad::install`

Installs nad by downloading tarballs from updates.circonus.com .

## LWRPs

## Attributes

Defaults are shown below.

    :nad => {

        #------
        #  Cookbook Toggle
        #------
        # Set to false to disable the cookbook 
        # (will not disable nad if running)        
        :enabled => true, 

        #------
        #  Installation
        #------
        # Where to store the tarball during installation
        :tmp_path => '/tmp',

        # URL without filename
        :download_url => 'http://updates.circonus.com/node-agent',

        # File to download.  Varies by platform; ubuntu shown.
        :download_file => "ubuntu-12.04.1-64-nad.tar.gz"

        #-----
        # Daemon Config
        #-----
        :port => 2609,
        :config_dir => '/opt/circonus/etc/node_agent.d',

        # These are nil by default
        # Listen on a specific interface
        :ip => nil, 
        # Use SSL (must place na.crt and na.key in conf dir).  If ssl_port is provided, :ip and :port are not used.
        :ssl_port => nil, 
        :ssl_ip => nil,
    }

## See Also

https://github.com/modcloth-cookbooks/nad

