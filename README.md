## Introduction

A test/play virtual machine for [Open Journal Systems](http://pkp.sfu.ca/ojs/). It should work on any operating system that supports VirtualBox and Vagrant.

This virtual machine **should not** be used in production.

## Prerequisites

Install the following prerequisites on your laptop or desktop:

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)

## Setting up your virtual machine

1. `git clone -b ojs-master https://github.com/pkp/vagrant.git` (or download the .zip/.tar version)
2. `cd vagrant`
3. `vagrant up`

When all the scripts have finished running, your virtual machine is ready for use.

Note that this image runs the data build and test suite, so it may take quite a while to complete; you can monitor progress via the VNC service (see below).

## Accessing OJS

Point your browser at [http://localhost:8000/ojs](http://localhost:8000/ojs). The [OJS Documentation wiki](https://pkp.sfu.ca/wiki/index.php?title=OJS_Documentation) contains everything you need to know, except...
* The administrator account has username: admin password: admin
* The journal manager/editor has username: dbarnes password: dbarnes

## Other details you might find useful

You can connect to the machine via ssh: `ssh -p 2222 vagrant@localhost` and log in with:
  - username: vagrant
  - password: vagrant

VNC: 127.0.0.1 port 5901 (display 1)

You won't normally need the following but just in case:

MySQL credentials:
  - username: root
  - password: (no password)

OJS database details:
  - database: ojs
  - user: ojs
  - password: ojs

## Thanks

This Vagrant virtual machine is based on [Islandora Vagrant](https://github.com/Islandora-Labs/islandora_vagrant).
