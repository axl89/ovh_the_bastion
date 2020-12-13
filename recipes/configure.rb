#
# Cookbook:: ovh_the_bastion
# Recipe:: configure
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

template 'Configure OVH The bastion' do
  cookbook node['ovh_the_bastion']['config']['template_cookbook_name']
  source 'bastion.conf.erb'
  path '/etc/bastion/bastion.conf'
  variables(
    bastion_config: node['ovh_the_bastion']['config']
  )
end
