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

        # Set to false to disable the cookbook 
        # (will not disable nad if running)        
        :enabled => true, 

        # Where to store the tarball during installation
        :tmp_path => '/tmp',

        # URL without filename
        :download_url => 'http://updates.circonus.com/node-agent',

        # File to download.  Varies by platform; ubuntu shown.
        :download_file => "ubuntu-12.04.1-64-nad.tar.gz"
    }

## See Also

https://github.com/modcloth-cookbooks/nad

