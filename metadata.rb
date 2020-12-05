name 'ovh_the_bastion'
maintainer 'Axel Amigo'
maintainer_email 'axl89@users.noreply.github.com'
license 'GPL-3.0'
description 'Installs/Configures ovh_the_bastion'
version '1.0.1'
chef_version '>= 14.0'

supports 'debian', '>= 8.0'
supports 'centos', '>= 7.0'
supports 'redhat', '>= 7.0'
supports 'ubuntu', '>= 14.04'
supports 'opensuseleap', '>= 15.0'

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
