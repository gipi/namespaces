Experiments around Linux's namespaces

    $ gcc -Wall ns.c -o ns
    # ./ns -m -p sh 
    sh-4.2# mount -t proc proc /proc
    sh-4.2# ps ax
      PID TTY      STAT   TIME COMMAND
        1 pts/0    S      0:00 sh
        4 pts/0    R+     0:00 ps ax

It's the same as running

    $ sudo unshare --mount-proc --fork -m -p /bin/bash
    sh-4.2# ps ax
      PID TTY      STAT   TIME COMMAND
        1 pts/0    S      0:00 sh

## Mounting a new root filesystem

```
$ sudo unshare -m
# mount --bind rootfs rootfs
# cd rootfs/
# pivot_root . put_old
# cd /
/# ls
bin      dev      etc      home     lib      media    mnt      opt      proc     put_old  root     run      sbin     srv      sys      tmp      usr      var
/# mount
mount: no /proc/mounts
/# umount -l put_old/
/# ls put_old/
/# mount
mount: no /proc/mounts
/# mount -t proc proc /proc
/# mount
/dev/sdb1 on / type ext4 (rw,relatime)
proc on /proc type proc (rw,relatime)
```

## Links

 - https://stackoverflow.com/questions/44666700/unshare-pid-bin-bash-fork-cannot-allocate-memory/45973522
 - https://blog.mister-muffin.de/2015/10/25/unshare-without-superuser-privileges/
 - https://unix.stackexchange.com/questions/460085/how-to-unshare-n-without-changing-to-root
 - https://unix.stackexchange.com/questions/252714/is-it-possible-to-run-unshare-n-program-as-an-unprivileged-user
 - https://stackoverflow.com/questions/45972426/unshare-user-namespace-and-set-uid-mapping-with-newuidmap
 - https://unix.stackexchange.com/questions/440177/unshare-map-root-user-switch-to-original-uid-username-after-setup/457419
 - http://man7.org/conf/meetup/understanding-user-namespaces--Google-Munich-Kerrisk-2019-10-25.pdf
