# Changelog
## 23.05 - 2023-05-03

### Added
- image tag `latest` for docker image

### Changed
- used new base docker image ([oupfiz5/ubuntu-s6:22.04-3.1.4.2](https://hub.docker.com/layers/oupfiz5/ubuntu-s6/22.04-3.1.4.2/images/sha256-3374d789ac3295add644bb97915738d17149b6e003c8189201c688583cfdd80e?context=repo))
- upgrade tcl version to version 8.6.13
- downgrade tcllib to version 1.20
- upgrade thread to version 2.8.8
- install `rl_json` using download source from github
- `hook/push.sh` push docker image with tag `latest`
- github pipeline will use ``runs-on: ubuntu-22.04`
