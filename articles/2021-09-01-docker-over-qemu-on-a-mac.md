---
title: Docker over Qemu on a Mac
published: true
description: How to use docker on a mac without Docker for Mac.
tags: docker, ssh, qemu
---

Yesterday, Docker announced that Docker for Mac is going to require a paid account for large companies soon. While this does not immediately impact me, I have been relying on docker desktop for mac for a while and that annoys me for several reasons:

- it's somewhat flaky. I've had loads of issues over the years where I had to wipe it out and reinstall.
- the update process is flaky
- it barfs a lot of stuff all over the file system making cleanup a PITA

## The Alternative: DOCKER_HOST && ssh

Docker is s simple binary that acts as a client to the  docker daemon. Normally it connects to that via a socket that the locally running docker daemon creates.

However, you can easily make it connect to a remotely running docker daemon by either using the `-H` option or setting the `DOCKER_HOST` environment variable. One of the supported protocols is `ssh`.

So, I set up `qemu` via homebrew, installed a linux distribution (manjaro), installed ssh && docker on that, and set up an authorized key so I can ssh into that from my mac terminal. I configured the networking to forward port 5555 to the ssh port 22 on the vm.

Then I simply set this environment variable:

```bash
export DOCKER_HOST=jilles@localhost:5555
```

After this all my docker commands (using the client that came with docker for mac; but of course you can install that via homebrew as well), go to the remote host, which is where all the docker containers run.

## Docker port forwarding

The point of running docker is launching things like databases, web servers, etc. with the goal of actually connecting to these things. These things have ports that you might want to talk to. Normally what you do is forward those ports with the -p option. For example,

```bash
docker run -p8080:80 nginx
```

would run nginx and allow you to connect to that from localhost via port 8080. One minor problem: those ports will be inside the linux vm and not on your mac's localhost.

There are various ways to address this. An easy one is to use ssh for this. To forward a port, you can use the `-L` option with ssh:

```
ssh -L 8080:localhost:8080 -p 5555 jilles@localhost
```

After this, you can access it in your browser.

## Installing Qemu on a mac

You can make this work with any remote ssh; including cloud based options for this. But I wanted a locally running vm. There are ways to do this on mac. A nice OSS and lightweight option for this is qemu. But of course, you can probably make this work with parallels, virtualbox, vmware, or whatever else.

You can install qemu via homebrew (or whatever else you prefer). Also make sure to install libvirt. I was not able to get networking going without it.

```bash
brew install qemu libvirt
```

When that has finished and you've started the libvirt service (see instructions it dumps in your terminal when it installs), you can create a disk image and start qemu with a linux iso of your choice (or whatever OS you prefer).

For reference, here's a script that I use to start qemu:

```
#  qemu-img create -f qcow2 manjaro.qcow2 30G
#   -cdrom  manjaro-xfce-21.1.1-210827-linux513.iso \

qemu-system-x86_64 \
  -m 4G \
  -vga virtio \
  -display default,show-cursor=on \
  -usb \
  -device usb-tablet \
  -machine type=q35,accel=hvf \
  -smp 2 \
  -drive file=manjaro.qcow2,if=virtio \
  -cpu Nehalem \
  -device e1000,netdev=net0 \
  -netdev user,id=net0,hostfwd=tcp::5555-:22 \
  -soundhw
```

The commented first line is the command you use to create a disk image. The line below that is the command line option for qemu you use to mount the linux iso. After you've installed to your disk image, you can remoe that and boot from the disk image. I went with manjaro, which was pretty hassle free to get going. The networking options are important as you need port forwarding for ssh.

## Benefits & down sides

On the plus side:

- I have a nice sandboxed linux vm that contains all my docker stuff. I can shut it down, upgrade it, wipe it out, etc.
- Docker command line works as normally and things like docker-compose work as well
- qemu is reasonably fast and uses a similar virtualization strategy as docker for mac does
- I can uninstall docker for mac.

Downsides:

- This stuff needs memory and cpu. I noticed the vm struggling a bit with some of the things I normally run in docker for mac.
- While command line docker works fine, other things like some of our gradle build files assume docker is running locally. I may have to investigate forwarding a socket over ssh. Likewise docker port forwarding needs some manual work as well.
- You need some level of skills on the command line, setting up linux, getting qemu going. If you have that; great.

Let me know on twitter (@jillesvangurp) what you think about this.
