name 'ovh_the_bastion'
maintainer 'Axel Amigo'
maintainer_email 'axl89@users.noreply.github.com'
license 'GPL-3.0'
description 'Installs and configures ovh/the-bastion software'
version '2.0.2'
chef_version '>= 15.3'

supports 'debian', '>= 10.0'
supports 'centos', '>= 8.0'
supports 'redhat', '>= 7.0'
supports 'ubuntu', '>= 18.04'
supports 'opensuseleap', '>= 15.3'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/axl89/ovh_the_bastion/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/axl89/ovh_the_bastion'

depends 'yum-epel'
