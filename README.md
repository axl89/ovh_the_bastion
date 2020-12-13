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
- `node['ovh_the_bastion']['gpg_data_bag_name']` - Name of the [data bag](https://docs.chef.io/data_bags/) to look for admin's public PGP key when using the `import_gpg_key` recipe.
- `node['ovh_the_bastion']['gpg_data_bag_item']` - Name of the [data bag](https://docs.chef.io/data_bags/) item to look for admin's public PGP key when using the `import_gpg_key` recipe. This item MUST have the `public_key` attribute set with the **PGP public key in base64**. See the [admin_gpg.json](https://github.com/axl89/ovh_the_bastion/blob/eb5aa0926c379ceafd4a8720edb0493ae000a1de/test/integration/data_bags/gpg_databag/admin_gpg.json) file for an example.
- `node['ovh_the_bastion']['installation_options']` - Additional parameters to pass to the installation script. See `/opt/bastion/bin/admin/install --help`.
- `node['ovh_the_bastion']['packages']['syslog-ng']` - Whether to install `syslog-ng` or not.
- `node['ovh_the_bastion']['packages']['development']` - Whether to install packages needed for developing the software or not (useless in production).
- `node['ovh_the_bastion']['packages']['ovh-ttyrec']` - Whether to install `ovh-ttyrec` or not.
- `node['ovh_the_bastion']['config']['template_cookbook_name']` - The cookbook in which the `bastion.conf.erb` template file is located.
- `node['ovh_the_bastion']['config']` - A Hash containing the key/values to configure the bastion. See [bastion.conf.dist](https://github.com/ovh/the-bastion/blob/master/etc/bastion/bastion.conf.dist) for the full reference.


## Recipes

### `ovh_the_bastion::default`

Installs and configures [ovh/the-bastion].

### `ovh_the_bastion::install`

Installs the [ovh/the-bastion] software only.

### `ovh_the_bastion::configure`

Configures the [ovh/the-bastion] software.

### `ovh_the_bastion::import_gpg_key`

Imports the admins public GPG key used by the bastion to encrypt the backups and the ttyrec files. See [Encryption & signature GPG keys](https://ovh.github.io/the-bastion/installation/advanced.html#generating-and-importing-the-admins-gpg-key).

This recipe requires the `ovh_the_bastion.gpg_data_bag_name` and `ovh_the_bastion.gpg_data_bag_item` attributes to be set. See the **attributes** section.

## Usage

Normally you would add the `ovh_the_bastion::default` with a custom set of attributes specified directly to the node, or through a role, environment, etc.

[ovh/the-bastion]: https://github.com/ovh/the-bastion
[default configuration]: https://github.com/ovh/the-bastion/blob/master/etc/bastion/bastion.conf.dist
