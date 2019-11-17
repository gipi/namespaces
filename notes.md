# Container technologies

## Implementations

### RKT

[Home page](https://coreos.com/rkt/docs/latest/)

    $ ./rkt --dir=$PWD/../lib --local-config=$PWD/../etc fetch docker://busybox
    
[it seems abandoned](https://www.twistlock.com/labs-blog/breaking-out-of-coresos-rkt-3-new-cves/) as project.

### Docker

 - http://jpetazzo.github.io/2014/06/23/docker-ssh-considered-evil/ : avoid ``SSH`` and use ``nsenter``

    $ sudo docker run -i -t gipi/chmod /bin/bash

 - https://zwischenzugs.wordpress.com/2015/05/21/a-field-guide-to-docker-security-measures/

### Dokku

 - https://github.com/progrium/dokku

It uses ``sshcommand`` to call the main executable ``dokku`` during a ``git`` push. It intercepts the commits that are pushed
and using the ``build`` subcommand (you can find it at ``dokku/plugins/00_dokku-standard/commands``) by a buildstep

**PROTIP:** pass ``--trace`` like ``ssh -i ~/.ssh/id_rsa dokku@10.0.0.2 git-receive-pack miao --trace`` to see what commands are
executed.

The flow internally is this

```bash
case "$1" in
  receive)
    APP="$2"; IMAGE="dokku/$APP"; IMAGE_SOURCE_TYPE="$3"; TMP_WORK_DIR="$4"
    dokku_log_info1 "Cleaning up..."
    dokku cleanup
    dokku_log_info1 "Building $APP from $IMAGE_SOURCE_TYPE..."
    dokku build "$APP" "$IMAGE_SOURCE_TYPE" "$TMP_WORK_DIR"
    dokku_log_info1 "Releasing $APP..."
    dokku release "$APP" "$IMAGE_SOURCE_TYPE"
    dokku_log_info1 "Deploying $APP..."
    dokku deploy "$APP"
    dokku_log_info2 "Application deployed:"
         dokku urls "$APP" | sed "s/^/       /"
    echo
    ;;
```
### Dokku-alt

Fork of original dokku

https://github.com/dokku-alt/dokku-alt

### Rocket 

You need go, in Debian install ``golang-go`` and then reinstall using the command line

    # apt-get install golang-go
    $ mkdir go && export GOPATH=$PWD/go/
    $ go get launchpad.net/godeb
    # apt-get remove golang-go && apt-get autoremove
    $ go/bin/godeb install

- https://coreos.com/blog/rocket/

### Herokuish

Herokuish is made for platform authors. The project consolidates and decouples Heroku compatibility logic (running buildpacks, parsing Procfile) and supporting workflow (importing/exporting slugs) from specific platform images like those in Dokku/Buildstep, Deis, Flynn, etc.

The goal is to be the definitive, well maintained and heavily tested Heroku emulation utility shared by all. It is complemented by progrium/cedarish, which focuses on reproducing the base Heroku system image. Together they form a toolkit for achieving Heroku compatibility.

 - https://github.com/johanneswuerbach/herokuish

## Links

 - [Demystifying Containers - Part I: Kernel Space](https://medium.com/@saschagrunert/demystifying-containers-part-i-kernel-space-2c53d6979504)
 - [Containers from scratch](https://ericchiang.github.io/post/containers-from-scratch/)
