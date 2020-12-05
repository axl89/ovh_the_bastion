# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<a name="unreleased"></a>
## [Unreleased]


<a name="v1.0.1"></a>
## [v1.0.1] - 2020-12-05
### Added
- Added yum-epel cookbook dependency
- Added openSUSE Leap 15.X to CI

### Changed
- Changed install recipe to install epel if Amazon Linux
- Changed ovh/the-bastion version to v3.01.01
- Changed README.md to be more awesome

### Removed
- Removed unnecessary commands before CI


<a name="v1.0.0"></a>
## [v1.0.0] - 2020-11-29
### Added
- Added cookstyle and foodcritic steps for CI
- Added amazonlinux-2 to CI
- Added more tests
- Added Ubuntu 18.04 to kitchen file
- Added configure recipe and inSpec tests
- Added dokken tests to CI
- Added Dangerfile from sous-chefs
- Added circle-ci config file

### Changed
- Changed CircleCI workflow name to test
- Changed optional package attributes to false
- Changed CI job to dokken-single
- Changed CI to use custom attributes for testing purposes
- Changed bastion.conf template to allow cookbook parametrization
- Changed git to improve retrocompatibility
- Changed kitchen to use dokken instead of Vagrant
- Changed context
- Changed Dangerfile
- Changed orb version pinning to 2.1.1
- Changed circle-ci config to Sous Chef

### Fixed
- Fixed CI not being able to remove containers
- Fixed wrong dokken image name
- Fixed dokken workflow required parameter
- Fixed wrong parameter
- Fixed yamllint errors

### Removed
- Removed Danger checks
- Removed context
- Removed markdown linting


<a name="v0.1.1"></a>
## [v0.1.1] - 2020-11-28
### Added
- Added git-chlog to manage CHANGELOG
- Added new MFAPasswordWarnDays config


<a name="v0.1.0"></a>
## v0.1.0 - 2020-11-28
### Added
- Added tests, and other minor things
- Added install recipe

### Changed
- Changed README description

### Removed
- Removed duplicate MFAPasswordMaxDays attribute
- Removed Chef Workflow files


[Unreleased]: https://github.com/axl89/ovh_the_bastion/compare/v1.0.1...master
[v1.0.1]: https://github.com/axl89/ovh_the_bastion/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/axl89/ovh_the_bastion/compare/v0.1.1...v1.0.0
[v0.1.1]: https://github.com/axl89/ovh_the_bastion/compare/v0.1.0...v0.1.1
