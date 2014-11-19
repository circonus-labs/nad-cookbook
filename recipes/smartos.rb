#include_recipe "smf"

package 'build-essential'

git "/var/tmp/nad" do
  repository "git://github.com/circonus-labs/nad.git"
  reference node['nad']['reference']
end

execute "make and install nad binary" do
  command "cd /var/tmp/nad && make install"
  not_if "ls /opt/circonus/etc/node-agent.d"
end

execute "compile C-extensions" do
  command "cd /opt/circonus/etc/node-agent.d/illumos && test -f Makefile && make PREFIX=/opt/circonus"
  not_if "ls /opt/circonus/etc/node-agent.d/illumos/aggcpu.elf"
end
