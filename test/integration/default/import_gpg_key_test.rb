# InSpec test for recipe ovh_the_bastion::import_gpg_key

# The InSpec reference, with examples and extensive documentation, can be
# found at https://www.inspec.io/docs/reference/resources/

packages = %w(gpg)

packages.each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

files = [
  '/etc/bastion/osh-encrypt-rsync.conf.d/50-gpg-admins-key.conf',
  '/etc/bastion/osh-backup-acl-keys.conf.d/50-gpg.conf'
]

files.each do |file|
  describe file(file  ) do
    it { should exist }
  end
end
