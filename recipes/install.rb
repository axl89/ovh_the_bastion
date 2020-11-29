#
# Cookbook:: ovh_the_bastion
# Recipe:: install
#
# Copyright:: 2020,  Axel Amigo
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

version = node['ovh_the_bastion']['version']
path = node['ovh_the_bastion']['path']

# Part 0: prerequisites

apt_update 'all platforms' do
  action :nothing
  only_if { platform_family?('debian') }
end

## Install git, curl
package %w(git curl) do
  action :install
  notifies :update, 'apt_update[all platforms]', :before
end

## Download the bastion
bash "Download OVH The bastion #{version}" do
  code <<-EOH
    git clone https://github.com/ovh/the-bastion #{path}
    cd #{path} && git checkout #{version}
  EOH
  not_if { ::Dir.exist?(path) }
  notifies :run, 'execute[Install ovh-ttyrec]', :immediately
  notifies :run, 'execute[Check needed packages]', :immediately
  notifies :run, 'execute[Install OVH The bastion]', :immediately
end

## Or update it, if the version is different
bash "Update OVH The bastion to #{version}" do
  code <<-EOH
    umask 0022 && cd #{path} && git fetch && git checkout #{version}
    #{path}/bin/admin/install --managed-upgrade
  EOH
  not_if "cd #{path} && git status | grep 'HEAD detached at #{version}'"
  notifies :run, 'execute[Install ovh-ttyrec]', :immediately
  notifies :run, 'execute[Check needed packages]', :immediately
  notifies :run, 'execute[Upgrade OVH The bastion]', :immediately
end

## Install ovh-ttyrec if specified by node's attributes
execute 'Install ovh-ttyrec' do
  command "#{path}/bin/admin/install-ttyrec.sh -a"
  only_if { node['ovh_the_bastion']['packages']['ovh-ttyrec'] == true }
  action :nothing
end

check_packages_command = "#{path}/bin/admin/packages-check.sh -i"
check_packages_command += ' -s' if node['ovh_the_bastion']['packages']['syslog-ng']
check_packages_command += ' -d' if node['ovh_the_bastion']['packages']['development']
check_packages_command += ' -t' if node['ovh_the_bastion']['packages']['ovh-ttyrec']

## Check needed packages with the OVH utility
execute 'Check needed packages' do
  command check_packages_command
  action :nothing
end

# Part 1: installation

execute 'Install OVH The bastion' do
  command "#{path}/bin/admin/install --new-install #{node['ovh_the_bastion']['installation_options']}"
  action :nothing
end

execute 'Upgrade OVH The bastion' do
  command "#{path}/bin/admin/install --managed-upgrade"
  action :nothing
end
