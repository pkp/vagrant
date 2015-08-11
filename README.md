## Introduction

A test/play virtual machine for [Open Journal Systems](http://pkp.sfu.ca/ojs/). It should work on any operating system that supports VirtualBox and Vagrant.

This virtual machine **should not** be used in production.

## Prerequisites

Install the following prerequisites on your laptop or desktop:

1. [VirtualBox](https://www.virtualbox.org/)
2. [Vagrant](http://www.vagrantup.com/)

## Setting up your virtual machine

1. `git clone https://github.com/pkp/ojs-vagrant.git` (or download the .zip/.tar version)
2. `cd ojs-vagrant`
3. `vagrant up`

When all the scripts have finished running, your virtual machine is ready for use.

## Accessing OJS

You can connect to OJS a web browser at [http://localhost:8000/ojs](http://localhost:8000/ojs). You will need to enter the required information on the installation page. Some things to watch for:

* Under "File Settings," /var/www/files has been created for you. You don't need to change this setting.
* Under "Database Settings," use 'localhost' for Host, and 'ojs' for Username, Password, and Database name. Uncheck "Create new database" (the database has been done for you).

Once you have installed OJS, it is ready for use. The [OJS Documentation wiki](https://pkp.sfu.ca/wiki/index.php?title=OJS_Documentation) contains everything you need to know.

## Other details you might find useful

You can connect to the machine via ssh: `ssh -p 2222 vagrant@localhost` and log in with:
  - username: vagrant
  - password: vagrant

You won't normally need the following but just in case:

MySQL credentials:
  - username: root
  - password: ojs

OJS database details:
  - database: ojs
  - user: ojs
  - password: ojs

## Environment

The virtual machine runs:

- Ubuntu 14.04
- MySQL 5.5.41
- Apache 2.26
- PHP 5.5.9 
- OJS 2.4.6

## Thanks

This Vagrant virtual machine is based on [Islandora Vagrant](https://github.com/Islandora-Labs/islandora_vagrant).
