# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v0.5.0]

### Added

- Option to provide replicator technical user permission to close accounts based on tag restrictions. This allows for more granular control over which accounts can be closed by the replicator service.
- Possibility to set `meshstack_access_role_name` from the top-level module.

### Removed

- Option to provide replicator technical user permission to close accounts for specified resource org paths (i.e. landing zones) - this feature has been replaced by the tag-based closure configuration, since using Organization Units other than root did not work as expected.

## [v0.4.0]

### Added

- Option to provide replicator technical user permission to close accounts for specified resource org paths (i.e. landing zones)

## [v0.3.0]

### Added

- Added workload identity federation
- Added option to disable access keys

## [v0.2.0]

### Added

- Added CHANGELOG.md
- Added pre-commit hooks
- Added ARNs of managed accounts roles to output
- Added meshStack access role to output

### Changed

- Renamed metering related parts from kraken to metering

## [v0.1.0]

- Initial Release

[unreleased]: https://github.com/meshcloud/terraform-aws-meshplatform/compare/v0.5.0...HEAD
[v0.1.0]: https://github.com/meshcloud/terraform-aws-meshplatform/releases/tag/v0.1.0
[v0.2.0]: https://github.com/meshcloud/terraform-aws-meshplatform/releases/tag/v0.2.0
[v0.3.0]: https://github.com/meshcloud/terraform-aws-meshplatform/releases/tag/v0.3.0
[v0.4.0]: https://github.com/meshcloud/terraform-aws-meshplatform/releases/tag/v0.4.0
[v0.5.0]: https://github.com/meshcloud/terraform-aws-meshplatform/releases/tag/v0.5.0
