#
# Cookbook:: ovh_the_bastion
# Spec:: import_gpg_key
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

require 'spec_helper'

platforms = ['OpenSUSE 15.0', 'OpenSUSE 15.1', 'OpenSUSE 15.2', 'Ubuntu 14.04', 'Ubuntu 16.04', 'Ubuntu 18.04', 'Ubuntu 20.04', 'Debian 10', 'Debian 9', 'Debian 8', 'Centos 7', 'Amazon 2']

platforms.each do |platform|
  describe 'ovh_the_bastion::import_gpg_key' do
    platform_name = platform.split[0].downcase
    platform_version = platform.split[1].downcase
    platform platform_name, platform_version

    context "When all attributes are default, on #{platform_name} #{platform_version}" do
      it 'converges successfully' do
        stub_data_bag_item('gpg_databag', 'admin_gpg').and_return('gato')
        stub_command("cd /opt/bastion && git status | grep 'HEAD detached at v3.01.02'").and_return(0)
        expect { chef_run }.to_not raise_error
      end
    end
  end
end
