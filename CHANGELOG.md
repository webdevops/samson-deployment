# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [WebDevOps.io Samson Deployment](https://github.com/webdevops/samson-deployment).

## [1.5.0] - upcoming
### Added
- Notification for Slack service
- TYPO3: Added automatic migration for "typo3cms" path for TYPO3 6.2
### Changed
- Added readable command output inside Ansible
- Running finalize commands inside current/ instead of releases/xxxx/ path
- Reduced opcode cache clearing to 3 times instead of 10
- Disabled retry file for ansistrano

## [1.4.0] - 2016-04-06
### Changed
- Fixed ssh control path length for very long host names (see https://github.com/ansible/ansible/issues/11536)
- Set default ansistrano deployment strategy to "rsync" instead of "symlink" to fix issues (see https://github.com/zendtech/ZendOptimizerPlus/issues/126)

## [1.3.0] - 2016-03-28
### Changed
- Moved /app/db to /storage/db (make backup before update!)
- Added storage for npm and composer
- Implemented reading of samson project/group environment variables when using ansistrano
- Local tasks only run once for all affected hosts

## [1.2.0] - 2016-02-24
### Changed
- TYPO3 deployment support 
- rsync excludes because of deployment issues

### Removed
- MySQL support, switched to sqlite because of stability issues

## [1.1.0] - 2016-02-16
### Added
- Added basic symfony 2 und 3 support
- Added support for prefetched ssh public keys (more secure) 
- Added Makefile for common tasks
- Added `DEPLOYMENT_PROJECT` support

### Changed
- Improved deployment README
- Renamed /opt/deployment to /opt/ansistrano
- Cleaned up etc/environment.yml
- Switched to Apache 2.0 license to match zendesk/samson license

## [1.0.1] - 2016-02-16
### Changed
- Updated README

## [1.0.0] - 2016-02-16
Initial revision
