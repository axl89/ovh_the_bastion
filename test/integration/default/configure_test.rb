# InSpec test for recipe ovh_the_bastion::configure

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe file('/etc/bastion/bastion.conf') do
  it { should exist }
end
