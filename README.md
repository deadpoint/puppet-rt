puppet-rt
=========

Overview
--------

Installs and allows you to easily manage Request Tracker with Puppet

Module Description
-------------------

Request Tracker (RT) is an enterprise-grade ticketing system which enables a
group of people to intelligently and efficiently manage tasks, issues, and
requests submitted by a community of users. It features a web, email and
command-line interfaces.

The rt modules allow you to manage request tracker packages and extensions,
if they are available, on several operating systems, as well as basic queue
creation.

Basic Usage
-----------

To install Request Tracker

    class { "rt": dbtype => "postgres" }

To install the Request Tracker RT::Authen::ExternalAuth extension

    class { "rt::ext::externalauth": }

To install Request Tracker mailgate

    class { "rt::mailgate": }

Create a Request Tracker queue
------------------------------

*!NOTICE!*
Your RT *root* user's password will be exposed in your puppet manifest. Ensure
site.pp and or node configuration is properly secured so only puppet can read
it.

Configure the rt command line tool

    class { "rt::tool": 
        rt_user     => "root",
        rt_passwd   => "password"
        rt_server   => "http://rt.domain.com"
     }

Define your queue

    rt::queue { "queue1":
        description     => "RT queue 1",
        reply_email     => "rtq1@domain.com",
        comment_email   => "rtq1-comments@domain.com"
    }

Requirements outside this module
--------------------------------

The following depencencies are required by this module.

* Apache

Request Tracker requires either Apache mod_perl or mod_fcgid.

If using this with puppetlabs-apache you'll need to set one of the following
in your node manifest.

    class { "apache::mod::perl": }

    OR

    class { "apache::mod::fcgid": }

puppetlabs-apache is not a dependency of this module because it requires
puppetlabs/firewall which only supports Redhat and Debian systems.

* Database

Setting up the database is outside the scope of this module. Perhaps one of the
mysql or postgres modules can simplify this task for you.

* Request Tracker

We do not touch RT\_SiteConfig.pm at this time, other then ensuring it's
permissions.

* Email aliases, maps, etc.

Setting up aliases, maps, etc is outside the scope of this module at this time.
Perhaps one of the postfix or sendmail modules can simplify this task.

Contributors
------------

 * Darin Perusich <darin@darins.net> 
 * Puppet Labs <info@puppetlabs.com>


Copyright and License
---------------------

Copyright (C) 2012 Darin Perusich <darin@darins.net> 

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

