# ovh_the_bastion Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/ovh_the_bastion.svg)](https://supermarket.chef.io/cookbooks/ovh_the_bastion)
[![CircleCI](https://circleci.com/gh/axl89/ovh_the_bastion.svg?style=shield)](https://circleci.com/gh/axl89/ovh_the_bastion)
[![License](https://img.shields.io/badge/License-GPL%203.0-green.svg)](https://opensource.org/licenses/GPL-3.0)


Chef cookbook that installs and configures .

Installs [ovh/the-bastion] and sets up a fairly basic configuration. Since [ovh/the-bastion] is very complex, we provide a baseline only.

## Requirements

### Platforms

- Debian 8+
- Ubuntu 14.04+
- RHEL 7.x and 8.x w/ (EPEL is enabled as required)
- Amazon Linux 2 (EPEL is enabled as required)
- CentOS 7.x, 8.x
- OpenSUSE Leap 15.x

### Cookbooks

None :smile:

## Attributes

These attributes are set by the cookbook by default.

TODO

## Recipes

### `ovh_the_bastion::default`

Installs and configures [ovh/the-bastion].

### `ovh_the_bastion::install`

Installs the ovh_the_bastion software only.

### `ovh_the_bastion::configure`

Configures the ovh_the_bastion software only.

[ovh/the-bastion]: https://github.com/ovh/the-bastion
