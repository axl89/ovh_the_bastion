# Basic attributes
default['ovh_the_bastion']['version'] = 'v3.01.02'
default['ovh_the_bastion']['path'] = '/opt/bastion'
default['ovh_the_bastion']['gpg_data_bag_name'] = 'gpg_databag'
default['ovh_the_bastion']['gpg_data_bag_item'] = 'admin_gpg'

# See /opt/bastion/bin/admin/install --help
default['ovh_the_bastion']['installation_options'] = ''

# Optional packages
default['ovh_the_bastion']['packages']['syslog-ng'] = false
default['ovh_the_bastion']['packages']['development'] = false
default['ovh_the_bastion']['packages']['ovh-ttyrec'] = false

# Values for bastion.conf file.
# See https://github.com/ovh/the-bastion/blob/master/etc/bastion/bastion.conf.dist
# for documentation.
default['ovh_the_bastion']['config']['template_cookbook_name'] = 'ovh_the_bastion'
default['ovh_the_bastion']['config']['bastionName'] = 'fix-my-config-please-missing-bastion-name'
default['ovh_the_bastion']['config']['bastionCommand'] = 'ssh USER@HOSTNAME -t -- '
default['ovh_the_bastion']['config']['debug'] = 0
default['ovh_the_bastion']['config']['defaultLogin'] = ''
default['ovh_the_bastion']['config']['adminAccounts'] = []
default['ovh_the_bastion']['config']['superOwnerAccounts'] = []
default['ovh_the_bastion']['config']['allowedNetworks'] = []
default['ovh_the_bastion']['config']['forbiddenNetworks'] = []
default['ovh_the_bastion']['config']['ingressToEgressRules'] = []
default['ovh_the_bastion']['config']['egressKeysFrom'] = []
default['ovh_the_bastion']['config']['ingressKeysFrom'] = []
default['ovh_the_bastion']['config']['ingressKeysFromAllowOverride'] = 1
default['ovh_the_bastion']['config']['accountUidMin'] = 2000
default['ovh_the_bastion']['config']['accountUidMax'] = 99999
default['ovh_the_bastion']['config']['ttyrecGroupIdOffset'] = 100000
default['ovh_the_bastion']['config']['accountExternalValidationProgram'] = ''
default['ovh_the_bastion']['config']['accountExternalValidationDenyOnFailure'] = 1
default['ovh_the_bastion']['config']['alwaysActiveAccounts'] = []
default['ovh_the_bastion']['config']['allowedIngressSshAlgorithms'] = %w(rsa ecdsa ed25519)
default['ovh_the_bastion']['config']['allowedEgressSshAlgorithms'] = %w(rsa ecdsa ed25519)
default['ovh_the_bastion']['config']['minimumIngressRsaKeySize'] = 4096
default['ovh_the_bastion']['config']['maximumIngressRsaKeySize'] = 8192
default['ovh_the_bastion']['config']['minimumEgressRsaKeySize'] = 4096
default['ovh_the_bastion']['config']['maximumEgressRsaKeySize'] = 8192
default['ovh_the_bastion']['config']['defaultAccountEgressKeyAlgorithm'] = 'rsa'
default['ovh_the_bastion']['config']['defaultAccountEgressKeySize'] = 4096
default['ovh_the_bastion']['config']['sshClientHasOptionE'] = 0
default['ovh_the_bastion']['config']['sshClientDebugLevel'] = 0
default['ovh_the_bastion']['config']['displayLastLogin'] = 1
default['ovh_the_bastion']['config']['accountMaxInactiveDays'] = 0
default['ovh_the_bastion']['config']['accountExpiredMessage'] = ''
default['ovh_the_bastion']['config']['accountCreateSupplementaryGroups'] = []
default['ovh_the_bastion']['config']['accountCreateDefaultPersonalAccesses'] = []
default['ovh_the_bastion']['config']['accountMFAPolicy'] = 'enabled'
default['ovh_the_bastion']['config']['MFAPasswordMinDays'] = 0
default['ovh_the_bastion']['config']['MFAPasswordMaxDays'] = 90
default['ovh_the_bastion']['config']['MFAPasswordWarnDays'] = 15
default['ovh_the_bastion']['config']['MFAPasswordInactiveDays'] = -1
default['ovh_the_bastion']['config']['MFAPostCommand'] = []
default['ovh_the_bastion']['config']['remoteCommandEscapeByDefault'] = 0
default['ovh_the_bastion']['config']['readOnlySlaveMode'] = 0
default['ovh_the_bastion']['config']['interactiveModeAllowed'] = 1
default['ovh_the_bastion']['config']['interactiveModeTimeout'] = 60
default['ovh_the_bastion']['config']['interactiveModeByDefault'] = 1
default['ovh_the_bastion']['config']['enableSyslog'] = 1
default['ovh_the_bastion']['config']['syslogFacility'] = 'local7'
default['ovh_the_bastion']['config']['syslogDescription'] = 'bastion'
default['ovh_the_bastion']['config']['enableGlobalAccessLog'] = 1
default['ovh_the_bastion']['config']['enableAccountAccessLog'] = 1
default['ovh_the_bastion']['config']['enableGlobalSqlLog'] = 1
default['ovh_the_bastion']['config']['enableAccountSqlLog'] = 1
default['ovh_the_bastion']['config']['moshAllowed'] = 0
default['ovh_the_bastion']['config']['moshTimeoutNetwork'] = 86400
default['ovh_the_bastion']['config']['moshTimeoutSignal'] = 30
default['ovh_the_bastion']['config']['moshCommandLine'] = ''
default['ovh_the_bastion']['config']['keyboardInteractiveAllowed'] = 1
default['ovh_the_bastion']['config']['passwordAllowed'] = 0
default['ovh_the_bastion']['config']['telnetAllowed'] = 0
default['ovh_the_bastion']['config']['idleLockTimeout'] = 0
default['ovh_the_bastion']['config']['idleKillTimeout'] = 0
default['ovh_the_bastion']['config']['warnBeforeLockSeconds'] = 0
default['ovh_the_bastion']['config']['warnBeforeKillSeconds'] = 0
default['ovh_the_bastion']['config']['ttyrecFilenameFormat'] = '%Y-%m-%d.%H-%M-%S.#usec#.&uniqid.&account.&user.&ip.&port.ttyrec'
default['ovh_the_bastion']['config']['ttyrecAdditionalParameters'] = []
default['ovh_the_bastion']['config']['documentationURL'] = 'https://ovh.github.io/the-bastion/'
