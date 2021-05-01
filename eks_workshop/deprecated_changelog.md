# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.1 Initial  Release 
### Added 
    *  eks_launch script
    *  cleanup script

## 0.2 
### Added
* Link to cloud9 console in cleanup script steps
* eksctl launch prerequisite steps

### Fixed
* Moved IAM steps above prompt checking they are done
*  Removed `-admin` from the role example
*  Renamed the ssh key from `eksworkshop` to a variable `eksworkshop-<Name>`

## 0.3
### Changed
 * Ran Shellcheck

### Fixed
 * Changed eksworkshop-name to eksworkshop_name

 ## 0.4
 ### Changed
 * Added extra cleanup script
 
 ### Added 
 * Created zip of eks_workshop to have a single download instead of 2
