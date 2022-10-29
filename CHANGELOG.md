# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<a name="unreleased"></a>
## [Unreleased]

<a name="v3.0.0"></a>
## [v2.0.2] - 2022-10-29

### Added
- Support for CentOS stream 8, Ubuntu 22.04,
OpenSUSE Leap 15.3 and 15.4.

### Removed
- Support for CentOS 7, 8, Ubuntu 16.04,
OpenSUSE Leap < 15.3

### Changed
- ovh/the-bastion version upgraded to 3.08.00 (was 3.07.00).

<a name="v2.0.2"></a>
## [v2.0.2] - 2021-12-31

### Fixed
- Boolean attributes being interpolated as strings on `bastion.conf` file.

<a name="v2.0.1"></a>
## [v2.0.1] - 2021-12-31

### Added
- New attributes to parametrize `bastion.conf`.

### Changed
- Updated `bastion.conf` template  with the new parameters in `3.07.00`.

<a name="v2.0.0"></a>
## [v2.0.0] - 2021-12-31

### Added
- Support for Debian 11

### Changed
- ovh/the-bastion version upgraded to 3.07.00 (was 3.01.02).
- CI now checks cookbook idempotence.
- CI now uses the latest version of ovh/the-bastion

### Removed
- Support for Chef Infra client < 15.3

### Fixed
- Wrong `pid_one_command` for OpenSUSE Leap 15.3

<a name="v1.1.0"></a>
## [v1.1.0] - 2020-12-12
### Added
- Added import_gpg_key recipe
- Added application configuration checks
- Added attribute's missing description

### Changed
- Changed kitchen suite name

### Fixed
- Fixed git-chlog default branch


<a name="v1.0.2"></a>
## [v1.0.2] - 2020-12-05
### Fixed
- Fixed default values in comments.
- Fixed ttyrecFilenameFormat attribute missing


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


[Unreleased]: https://github.com/axl89/ovh_the_bastion/compare/v3.0.0...main
[v3.0.0]: https://github.com/axl89/ovh_the_bastion/compare/v2.0.2...v3.0.0
[v2.0.2]: https://github.com/axl89/ovh_the_bastion/compare/v2.0.1...v2.0.2
[v2.0.1]: https://github.com/axl89/ovh_the_bastion/compare/v2.0.0...v2.0.1
[v2.0.0]: https://github.com/axl89/ovh_the_bastion/compare/v1.1.0...v2.0.0
[v1.1.0]: https://github.com/axl89/ovh_the_bastion/compare/v1.0.2...v1.1.0
[v1.0.2]: https://github.com/axl89/ovh_the_bastion/compare/v1.0.1...v1.0.2
[v1.0.1]: https://github.com/axl89/ovh_the_bastion/compare/v1.0.0...v1.0.1
[v1.0.0]: https://github.com/axl89/ovh_the_bastion/compare/v0.1.1...v1.0.0
[v0.1.1]: https://github.com/axl89/ovh_the_bastion/compare/v0.1.0...v0.1.1
