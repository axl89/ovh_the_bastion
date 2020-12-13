# InSpec test for recipe ovh_the_bastion::configure

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe file('/etc/bastion/bastion.conf') do
  it { should exist }
end

describe command("perl -I/opt/bastion/lib/perl -MOVH::Bastion -e 'die OVH::Bastion::load_configuration()'") do
  its('stderr') { should match /OK/ }
  its('stdout') { should eq '' }
end
