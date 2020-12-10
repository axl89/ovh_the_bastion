# InSpec test for recipe ovh_the_bastion::install

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

packages = %w(git curl ovh-ttyrec syslog-ng)

packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

describe directory('/opt/bastion') do
  it { should be_directory }
end

describe bash('cd /opt/bastion && git status') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match /HEAD detached at v3.01.01/ }
end

describe bash('/opt/bastion/bin/dev/perl-check.sh') do
  its('exit_status') { should eq 0 }
end