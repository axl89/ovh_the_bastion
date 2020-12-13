#
# Cookbook:: ovh_the_bastion
# Spec:: configure
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

platforms = ['Ubuntu 18.04', 'Ubuntu 20.04', 'Debian 10', 'Debian 9', 'Debian 8', 'Centos 7', 'Amazon 2']

platforms.each do |platform|
  describe 'ovh_the_bastion::configure' do
    platform_name = platform.split[0].downcase
    platform_version = platform.split[1].downcase
    platform platform_name, platform_version

    context "When all attributes are default, on #{platform_name} #{platform_version}" do
      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
      it 'creates the bastion.conf template' do
        expect(chef_run).to create_template('Configure OVH The bastion')
      end
    end
  end
end
