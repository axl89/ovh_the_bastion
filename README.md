# ovh_the_bastion Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/ovh_the_bastion.svg)](https://supermarket.chef.io/cookbooks/ovh_the_bastion)
[![CircleCI](https://circleci.com/gh/axl89/ovh_the_bastion.svg?style=shield)](https://circleci.com/gh/axl89/ovh_the_bastion)
[![License](https://img.shields.io/badge/License-GPL%203.0-green.svg)](https://opensource.org/licenses/GPL-3.0)


Installs [ovh/the-bastion] and sets up its [default configuration].


## Requirements

### Platforms

- Debian 8+
- Ubuntu 14.04+
- RHEL 7.x and 8.x
- Amazon Linux 2 (EPEL is enabled as required)
- CentOS 7.x, 8.x
- OpenSUSE Leap 15.x

### Cookbooks

- yum-epel

## Attributes

These attributes are set by the cookbook, following the program's [default configuration]:

- `node['ovh_the_bastion']['version']` - Version of [ovh/the-bastion] to be installed or updated to.
- `node['ovh_the_bastion']['path']` - Path to install [ovh/the-bastion] software.
- `node['ovh_the_bastion']['installation_options']` - Additional parameters to pass to the installation script. See `/opt/bastion/bin/admin/install --help`.
- `node['ovh_the_bastion']['packages']['syslog-ng']` - Whether to install `syslog-ng` or not.
- `node['ovh_the_bastion']['packages']['development']` - Whether to install packages needed for developing the software or not (useless in production).
- `node['ovh_the_bastion']['packages']['ovh-ttyrec']` - Whether to install `ovh-ttyrec` or not.
- `node['ovh_the_bastion']['config']['template_cookbook_name']` - The cookbook in which the `bastion.conf.erb` template file is located.
- `node['ovh_the_bastion']['config']['bastionName']` - This will be the name advertised in the aliases admins will give to bastion users, you can see it as a friendly name everybody will use to refer to this machine (try to avoid using the full hostname here).
- `node['ovh_the_bastion']['config']['bastionCommand']` - The ssh command to launch to connect to this bastion as a user. This will be printed on accountCreate, so that the new user knows how to connect. Magic values are ACCOUNT (replaced at runtime by the account name), BASTIONNAME (replaced at runtime by the name defined in `bastionName'), HOSTNAME (replaced at runtime by the hostname of the system, namely what is returned by `perl -MSys::Hostname -e 'print hostname'`). Note that previous magic values where USER (=ACCOUNT) and CACHENAME (=BASTIONNAME), they're still supported.
- `node['ovh_the_bastion']['config']['debug']` - Enables or disables debug GLOBALLY. Discouraged. Prefer using the dev/debug_toggle.sh tool to enable/disable per account. Mostly useful for bastion developer on bastion dev machine only.
- `node['ovh_the_bastion']['config']['defaultLogin']` - The default remote user to use for egress ssh connections where no user has been specified by our caller. If set to "", will default to the account name of the caller. Some legacy bastions had "root" as a default, which is somehow discouraged but depends on your infrastructure policy.
- `node['ovh_the_bastion']['config']['adminAccounts']` - The list of accounts that are Admins of the bastion. Admins can't be deleted or have their ingress keys reset by non-admins. They also gain access to special dangerous/sensitive --osh commands. Note that an admin is also always considered as a Super Owner, which means they can override allchecks of group administrative commands. Don't forget to add them to the osh-admin group too, or they won't really be considered as admins (additional security measure). Rule of thumb: only add here people that have root@localhost access to the bastion.
- `node['ovh_the_bastion']['config']['superOwnerAccounts']` - The list of accounts that are Admins of the bastion. Admins can't be deleted or have their ingress keys reset by non-admins. They also gain access to special dangerous/sensitive --osh commands. Note that an admin is also always considered as a Super Owner, which means they can override allchecks of group administrative commands. Don't forget to add them to the osh-admin group too, or they won't really be considered as admins (additional security measure). Rule of thumb: only add here people that have root@localhost access to the bastion.
- `node['ovh_the_bastion']['config']['allowedNetworks']` - Restricts egress connection attempts to those listed networks only. This is enforced at all times and can NOT be overridden by users. It's probably a good idea to list the prefixes of your ASN here.
- `node['ovh_the_bastion']['config']['forbiddenNetworks']` - Prevents egress connection to the listed networks, even if they match configured allowed networks. This can be used to prevent connection to some hosts or subnets in a broadly allowed prefix. This is enforced at all times and can NOT be overridden by users.
- `node['ovh_the_bastion']['config']['ingressToEgressRules']` - Fine-grained rules (a la netfilter) to apply global restrictions to possible egress destinations given ingress IPs. Rules here are enforced at all times and can NOT be overridden by users or admins.
- `node['ovh_the_bastion']['config']['egressKeysFrom']` - These IPs will be added to the from="..." of the personal account keys and the group keys. Typically you want to specify only the bastions IP here (including all the slaves).
- `node['ovh_the_bastion']['config']['ingressKeysFrom']` - This array of IPs (or prefixes, such as 10.20.30.0/24) will be used to build the from="" in front of the ingress account public keys used to connect to the bastion (in accountCreate or selfAddIngressKey). If the array is empty, then NO from="" is added.
- `node['ovh_the_bastion']['config']['ingressKeysFromAllowOverride']` - If set to 0 (false), any from="..." specified in user keys (selfAddIngressKey or accountCreate) are ignored and replaced by the IPs in the ingressKeysFrom configuration option (if any). If set to 1 (true), any from="..." specified in user keys (selfAddIngressKey or accountCreate) will override the value set in ingressKeysFrom (if any). When no user-specified from="..." appears, the value of ingressKeysFrom is still used, regardless of this option.
- `node['ovh_the_bastion']['config']['accountUidMin']` - Minimum allowed UID for accounts on this bastion. Hardcoded > 1000 even if configured for less.
- `node['ovh_the_bastion']['config']['accountUidMax']` - Maximum allowed UID for accounts on this bastion.
- `node['ovh_the_bastion']['config']['ttyrecGroupIdOffset']` - Offset to apply on user group uid to create -tty group, should be > accountUidMax.
- `node['ovh_the_bastion']['config']['accountExternalValidationProgram']` - Binary or script that will be called by the bastion, with the account name in parameter, to check whether this account should be allowed to connect to the bastion. If empty, this check is skipped. $BASEDIR is a magic value that is replaced by where the bastion code lives (usually, /opt/bastion). You can use this configuration parameter to counter-verify all accounts against an external system, for example an LDAP, right when they're connecting to the bastion (on the ingress side). However, it is advised to avoid calling an external system in the flow of an incoming connection (this violates the "the bastion must be working at all times, regardless of the status of the other components of the company's infrastructure" rule). Instead, you should have a cronjob to periodically fetch all the allowed accounts from said external system, and store this list somewhere on the bastion, then write a simple script that will be called by the bastion to verify whether the connecting account is present on this locally cached list. An account present in this list, is called an "active account", in the bastion's jargon. An inactive account is an account existing on the bastion, but not in this list, and won't be able to connect. Note that for security reasons, inactive bastions administrators would be denied as any other account. The result is interpreted from the program's exit code. If the program return 0, the account is deemed active. If the program returns 1, the account is deemed inactive. A return code of 2, 3 or 4 indicates a failure of the program in determining the activeness of the account. In this case, the decision to allow or deny the access is determined by the option below. Status code 3 additionally logs the stderr of the program *silently* to the syslog (this can be used to warn admins of a problem without leaking information to the user). Status code 4 does the same, but the stderr is also shown directly to the user. Any other return code deems the account inactive (same behavior that return code 1).
- `node['ovh_the_bastion']['config']['accountExternalValidationDenyOnFailure']` - If we can't validate an account using the above configured program, for example because the path doesn't exist, the file is not executable, or because the program returns the exit code 4 (see above for more information), this configuration option indicates whether we should deny or allow access. Note that the bastion admins will always be allowed if the accountExternalValidationProgram doesn't work correctly, because they're expected to be able to fix it. They would be denied, as any other account, if accountExternalValidationProgram works correctly and denies them access, however. If you're still testing your account validation procedure, and don't want to break your users workflow while you're not 100% sure it works correctly, you can say 0 ("false") here, and return 4 instead of 1 in your accountExternalValidationProgram when you would want to deny access.
- `node['ovh_the_bastion']['config']['alwaysActiveAccounts']` - List of accounts which should NOT be checked against the accountExternalValidationProgram mechanism above (for example bot accounts). This can also be set per-account at account creation time or later with the accountModify plugin's '--always-active' flag.
- `node['ovh_the_bastion']['config']['allowedIngressSshAlgorithms']` - The algorithms authorized for ingress ssh public keys added to this bastion. possible values: dsa, rsa, ecdsa, ed25519, note that some of those might not be supported by your current version of OpenSSH, unsupported algorithms are automatically omitted at runtime.
- `node['ovh_the_bastion']['config']['allowedEgressSshAlgorithms']` - The algorithms authorized for egress ssh public keys generated on this bastion. possible values: dsa, rsa, ecdsa, ed25519, note that some of those might not be supported by your current version of OpenSSH, unsupported algorithms are automatically omitted at runtime.
- `node['ovh_the_bastion']['config']['minimumIngressRsaKeySize']` - The minimum allowed size for ingress RSA keys (user->bastion). Sane values range from 2048 to 4096.
- `node['ovh_the_bastion']['config']['maximumIngressRsaKeySize']` - The maximum allowed size for ingress RSA keys (user->bastion). Too big values (>8192) are extremely CPU intensive and don't really add that much security.
- `node['ovh_the_bastion']['config']['minimumEgressRsaKeySize']` - The minimum allowed size for egress RSA keys (bastion->server). Sane values range from 2048 to 4096.
- `node['ovh_the_bastion']['config']['maximumEgressRsaKeySize']` - The maximum allowed size for ingress RSA keys (bastion->server). Too big values (>8192) are extremely CPU intensive and don't really add that much security.
- `node['ovh_the_bastion']['config']['defaultAccountEgressKeyAlgorithm']` - The default algorithm to use to create the egress key of a newly created account.
- `node['ovh_the_bastion']['config']['defaultAccountEgressKeySize']` - The default size to use to create the egress key of a newly created account (also see defaultAccountEgressKeyAlgorithm).
- `node['ovh_the_bastion']['config']['sshClientHasOptionE']` - Set to 1 if your ssh client supports the -E option and you want to use it to log debug info on opened sessions. Discouraged, has some annoying side effects (some ssh errors then go silent from the user perspective).
- `node['ovh_the_bastion']['config']['sshClientDebugLevel']` - Indicates the number of -v that will be added to the ssh client command line when starting a session. Probably a bad idea unless you want to annoy your users.
- `node['ovh_the_bastion']['config']['displayLastLogin']` - If != 0, display last login information on connection.
- `node['ovh_the_bastion']['config']['fanciness']` - Customize to which extent the text output by the program will use decorations to enhance human-friendliness and highlight warnings or critical messages. Note that if a given session's terminal doesn't advertise UTF-8 support, UTF-8 will not be used, regardless of what is set here.
- `node['ovh_the_bastion']['config']['accountMaxInactiveDays']` - If != 0, deny access to accounts that didn't log in since at least that many days. A value of 0 means that this functionality is disabled (will never deny access).
- `node['ovh_the_bastion']['config']['accountExpiredMessage']` - If non-empty, customizes the message that will be printed to a user attempting to connect with an expired account (see accountMaxInactiveDays above). When empty, defaults to the standard message "Sorry, but your account has expired (#DAYS# days), access denied by policy.".
- `node['ovh_the_bastion']['config']['accountCreateSupplementaryGroups']` - List of groups to add a new account to. Can be useful to grant some restricted commands by default to new accounts. For example osh-selfAddPersonalAccess, osh-selfDelPersonalAccess, etc.
- `node['ovh_the_bastion']['config']['accountCreatedefaultPersonalAccesses']` - List of strings of the form USER@IP or USER@IP:PORT or IP or IP:PORT, with IP being IP or prefix (such as 1.2.3.0/24). This is the list of accesses to add to the personal access list of newly created accounts. The special value ACCOUNT is replaced by the name of the account being created. This can be useful to grant some accesses by default to new accounts (for example ACCOUNT@0.0.0.0/0)
- `node['ovh_the_bastion']['config']['ingressRequirePIV']` - When set to true, only PIV-enabled SSH keys will be able to be added with selfAddIngressKey, hence ensuring that an SSH key generated on a computer, and not within a PIV-compatible hardware token, can't be used to access The Bastion. If you only want to enable this on a per-account basis, leave this to false and set the flag on said accounts using accountPIV instead. When set to false, will not require PIV-enabled SSH keys to be added by selfAddIngressKey. If you have no idea what PIV keys are, leave this to false, this is what you want.
- `node['ovh_the_bastion']['config']['accountMFAPolicy']` - Set a MFA policy for the bastion accounts, see OPTIONS below for the supported policies list.
- `node['ovh_the_bastion']['config']['MFAPasswordMinDays']` - For the PAM UNIX password MFA, sets the minimum amount of days between two password changes (see `chage -m').
- `node['ovh_the_bastion']['config']['MFAPasswordMaxDays']` - For the PAM UNIX password MFA, sets the maximum amount of days after which the password must be changed (see `chage -M').
- `node['ovh_the_bastion']['config']['MFAPasswordWarnDays']` - For the PAM UNIX password MFA, sets the number of days before expiration on which the user will be warned to change his password (see `chage -W')
- `node['ovh_the_bastion']['config']['MFAPasswordInactiveDays']` - For the PAM UNIX password MFA, the account will be blocked after the password is expired (and not renewed) for this amount of days (see `chage -E'). -1 disables this feature. Note that this is different from the accountMaxInactiveDays option above, that is handled by the bastion software itself instead of PAM.
- `node['ovh_the_bastion']['config']['MFAPostCommand']` - When using JIT MFA (i.e. not directly by calling PAM from SSHD's configuration, but using pamtester from within the code), execute this command on success. This can be used for example if you're using pam_tally2 in your PAM MFA configuration, pamtester can't reset the counter to zero because this is usually done in the account_mgmt PAM phase. You can use a script to reset it here. The magic value %ACCOUNT% will be replaced by the account name.
- `node['ovh_the_bastion']['config']['TOTPProvider']` - Defines which is the provider of the TOTP MFA, that will be used for the ``(self|account)MFA(Setup|Reset)TOTP`` commands.
- `node['ovh_the_bastion']['config']['remoteCommandEscapeBydefault']` - If set to 0, will not escape simple quotes in remote commands by default. Leave it to 0 if possible. Will escape simple quotes otherwise (legacy "broken" behavior). Can be overridden at runtime with --never-escape and --always-escape.
- `node['ovh_the_bastion']['config']['readOnlySlaveMode']` - If set to 0, this bastion will work in standalone mode, or will be the master in a master/slave mode. If set to 1, this'll be the slave which means all plugins that modify groups, accounts, or access rights will be disabled, and the master bastion will push its modifications using inotify/rsync, please refer do the documentation to set this up.
- `node['ovh_the_bastion']['config']['interactiveModeAllowed']` - If set to 1, --interactive mode is allowed. Otherwise, this feature is disabled.
- `node['ovh_the_bastion']['config']['interactiveModeTimeout']` - The number of idle seconds after which the user is disconnected from the bastion when in interactive mode. A value of 0 will disable this feature (user will never be disconnected for idle timeout).
- `node['ovh_the_bastion']['config']['interactiveModeBydefault']` - If true (1), drops the user to interactive mode if nothing is specified on the command line. If false (0), displays the help and exits with an error. Note that for `true' to have the expected effect, interactive mode must be enabled (see the `interactiveModeAllowed` option above).
- `node['ovh_the_bastion']['config']['interactiveModeProactiveMFAenabled']` - If enabled, the ``mfa`` command is allowed in interactive mode, to trigger a proactive MFA challenge, so that subsequent commands normally requiring MFA won't ask for it again.
- `node['ovh_the_bastion']['config']['interactiveModeProactiveMFAexpiration']` - If the above ``interactiveModeProactiveMFAenabled`` option is ``true``, then this is the amount of seconds after which the proactive MFA mode is automatically disengaged.
- `node['ovh_the_bastion']['config']['enableSyslog']` - If set to 0, syslog will be disabled. If set to 1, we'll send logs through syslog (don't forget to setup your syslogd).
- `node['ovh_the_bastion']['config']['syslogFacility']` - Sets the facility that will be used for syslog.
- `node['ovh_the_bastion']['config']['syslogDescription']` - Sets the description that will be used for syslog.
- `node['ovh_the_bastion']['config']['enableGlobalAccessLog']` - If set to 1, all accesses will still be logged in the old /home/osh.log (never rotated, world-writable -> discouraged). If set to 0, we'll no longer log there (modern way is syslog, see above).
- `node['ovh_the_bastion']['config']['enableAccountAccessLog']` - If set to 1, all accesses will still be logged in the user's home /home/USER/USER-log-YYYYMM.log. If set to 0, we won't log there.
- `node['ovh_the_bastion']['config']['enableGlobalSqlLog']` - If set to 1, all accesses will be logged (in a short SQL format) in /home/logkeeper/*.sqlite. If set to 0, we won't log there.
- `node['ovh_the_bastion']['config']['enableAccountSqlLog']` - If set to 1, all accesses will be logged (in a detailed SQL format) in the user's home /home/USER/USER-log-YYYYMM.sqlite. Otherwise, we won't log there.
- `node['ovh_the_bastion']['config']['moshAllowed']` - If set to 1, mosh usage is allowed (mosh needs to be installed on serverside, obviously). Otherwise, this feature is disabled.
- `node['ovh_the_bastion']['config']['moshTimeoutNetwork']` - Number of seconds of inactivity (network-wise) after a mosh-server will exit. By design even if the client is disconnected "for good", mosh-server would wait forever. If mosh is meant to handle shaky connections but not mobility, you can set this to a low value. It sets the MOSH_SERVER_NETWORK_TMOUT envvar for mosh, see `man mosh-server' for more information (mosh 1.2.6+).
- `node['ovh_the_bastion']['config']['moshTimeoutSignal']` - Number of seconds of inactivity (network-wise) a mosh-server will wait after receiving a SIGUSR1 before exiting. It sets the MOSH_SERVER_SIGNAL_TMOUT envvar for mosh, see `man mosh-server' for more information (mosh 1.2.6+).
- `node['ovh_the_bastion']['config']['moshCommandLine']` - Additional parameters that will be passed as-is to mosh-server. See `man mosh-server', you should at least add the -p option to specify a fixed number of ports (easier for firewall configuration)
- `node['ovh_the_bastion']['config']['keyboardInteractiveAllowed']` - If set to 1, will allow keyboard-interactive authentication when publickey auth is requested for egress connections, this is needed e.g. for 2FA.
- `node['ovh_the_bastion']['config']['passwordAllowed']` - If set to 1, will allow password authentication for egress ssh, so that user can type his remote password interactively.
- `node['ovh_the_bastion']['config']['telnetAllowed']` - If set to 1, will allow telnet egress connections (-e / --telnet).
- `node['ovh_the_bastion']['config']['idleLockTimeout']` - If set to a positive value >0, the number of seconds of input idle time after which the session is locked. If 0, disabled.
- `node['ovh_the_bastion']['config']['idleKillTimeout']` - If set to a positive value >0, the number of seconds of input idle time after which the session is killed. If 0, disabled. If idleLockTimeout is set, this value must be higher (obviously).
- `node['ovh_the_bastion']['config']['warnBeforeLockSeconds']` - If set to a positive value >0, the number of seconds before idleLockTimeout where the user will receive a warning message telling him about the upcoming lock of his session.
- `node['ovh_the_bastion']['config']['warnBeforeKillSeconds']` - If set to a positive value >0, the number of seconds before idleKillTimeout where the user will receive a warning message telling him about the upcoming kill of his session.
- `node['ovh_the_bastion']['config']['ttyrecFilenameFormat']` - Sets the filename format of the output files of ttyrec for a given session. Magic tokens are: &bastionname, &uniqid, &account, &ip, &port, &user (they'll be replaced by the corresponding values of the current session). Then, this string (automatically prepended with the correct folder) will be passed to ttyrec's -F parameter, which uses strftime() to expand it, so the usual character conversions will be done (%Y for the year, %H for the hour, etc., see man strftime). Note that in a addition to the usual strftime() conversion specifications, ttyrec also supports #usec#, to be replaced by the current microsecond value of the time.
- `node['ovh_the_bastion']['config']['ttyrecAdditionalParameters']` - Additional parameters you want to pass to ttyrec invocation. Useful, for example, to enable on-the-fly compression, disable cheatcodes, or set/unset any other ttyrec option. This is an ARRAY, not a string. e.g. ["-s", "This is a message with spaces", "--zstd"].
- `node['ovh_the_bastion']['config']['documentationURL']` - The URL of the documentation where users will be pointed to, for example when displaying help. If you have some internal documentation about the bastion, you might want to advertise it here.


## Recipes

### `ovh_the_bastion::default`

Installs and configures [ovh/the-bastion].

### `ovh_the_bastion::install`

Installs the [ovh/the-bastion] software only.

### `ovh_the_bastion::configure`

Configures the [ovh/the-bastion] software.

### `ovh_the_bastion::import_gpg_key`

Imports the admins public GPG key used by the bastion to encrypt the backups and the ttyrec files. See [Encryption & signature GPG keys](https://ovh.github.io/the-bastion/installation/advanced.html#encryption-signature-gpg-keys).

## Usage

Normally you would add the `ovh_the_bastion::default` with a custom set of attributes specified directly to the node, or through a role, environment, etc.

[ovh/the-bastion]: https://github.com/ovh/the-bastion
[default configuration]: https://github.com/ovh/the-bastion/blob/master/etc/bastion/bastion.conf.dist
