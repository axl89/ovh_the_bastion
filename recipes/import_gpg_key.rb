#
# Cookbook:: ovh_the_bastion
# Recipe:: import_gpg_key
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

# Part 0: pre-reqs
include_recipe 'ovh_the_bastion::install'

apt_update 'all platforms' do
  action :nothing
  only_if { platform_family?('debian') }
end

package_name = if platform?('opensuseleap')
                 'gpg2'
               else
                 'gnupg2'
               end

package package_name do
  action :install
  notifies :update, 'apt_update[all platforms]', :before
end

# Part 1: variable definition

path = node['ovh_the_bastion']['path']
data_bag_name = node['ovh_the_bastion']['gpg_data_bag_name']
data_bag_item_name = node['ovh_the_bastion']['gpg_data_bag_item']
base64_gpg_key = data_bag_item(data_bag_name, data_bag_item_name)['public_key']

# Part 2: actually import the GPG key
execute 'Importing the admins GPG key' do
  command "echo '#{base64_gpg_key}' | base64 -d | #{path}/bin/admin/setup-gpg.sh --import"
  sensitive true
  timeout 3600
  user 'root'
  group 'root'
  not_if { ::File.exist?('/etc/bastion/osh-encrypt-rsync.conf.d/50-gpg-admins-key.conf') || ::File.exist?('/etc/bastion/osh-backup-acl-keys.conf.d/50-gpg.conf') }
end
