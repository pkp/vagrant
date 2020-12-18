## Introduction

A test/play virtual machine for [Open Journal Systems](http://pkp.sfu.ca/ojs/)
and [Open Monograph Press](http://pkp.sfu.ca/omp). It should work on any
operating system that supports VirtualBox and Vagrant.

This virtual machine **should not** be used in production.

## Configuration

By default this image is configured to set up the `master` branch of OJS.
You can choose OMP, or another branch, by editing the Vagrantfile and editing
the `args` part of `vm.config.provision`. For example, use `omp stable-3_2_1`
to test the OMP 3.2.1 stable branch.

(This image currently supports OJS, OMP, and OPS 3.2.0 or newer.)

## Prerequisites

Install the following prerequisites on your laptop or desktop:

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)

## Setting up your virtual machine

1. `git clone https://github.com/pkp/vagrant.git`
2. `cd vagrant`
3. `vagrant up`

When all the scripts have finished running, your virtual machine is ready for use.

Note that this image runs the data build and test suite, so it may take quite a while to complete.

## Accessing OJS

	Point your browser at [http://localhost:8000/ojs](http://localhost:8000/ojs). The [OJS Documentation Hub](https://docs.pkp.sfu.ca/) contains everything you need to know, except...
* The administrator account has username: `admin` password: `admin`
* The journal manager/editor has username: `dbarnes` password: `dbarnesdbarnes`

## Other details you might find useful

You can connect to the machine via ssh: `vagrant ssh`

OJS database details:
  - database: `ojs-ci`
  - user: `ojs-ci`
  - password: `ojs-ci`

## Thanks

This Vagrant virtual machine is based on [Islandora Vagrant](https://github.com/Islandora-Labs/islandora_vagrant).
