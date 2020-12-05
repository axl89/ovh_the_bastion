#
# Cookbook:: ovh_the_bastion
# Spec:: default
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
  describe 'ovh_the_bastion::default' do
    platform_name = platform.split[0].downcase
    platform_version = platform.split[1].downcase
    platform platform_name, platform_version

    context "When all attributes are default, on #{platform_name} #{platform_version}" do
      it 'converges successfully' do
        stub_command("cd /opt/bastion && git status | grep 'HEAD detached at v3.01.00'").and_return(0)
        expect { chef_run }.to_not raise_error
      end

      recipes_that_should_include = %w(ovh_the_bastion::install ovh_the_bastion::configure)

      recipes_that_should_include.each do |recipe|
        it "Includes #{recipe} recipe" do
          stub_command("cd /opt/bastion && git status | grep 'HEAD detached at v3.01.00'").and_return(0)
          expect(chef_run).to include_recipe(recipe)
        end
      end
    end
  end
end
