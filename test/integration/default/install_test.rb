# InSpec test for recipe ovh_the_bastion::install

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

describe package('git') do
  it { should be_installed }
end

describe directory('/opt/bastion') do
  it { should be_directory }
end

describe file('/etc/bastion/bastion.conf') do
  it { should exist }
end
