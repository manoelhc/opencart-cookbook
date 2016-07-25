Opencart Cookbook
=================

Installs/Configures opencart

Requirements
------------

### Platform:

* Centos
* Redhat
* Fedora
* Debian
* Ubuntu

### Cookbooks:

* tar
* git
* mysql
* composer
* php
* apache2

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['opencart']['git_url']</code></td>
    <td>The URL of OpenCart repository to be installed</td>
    <td><code>https://github.com/opencart/opencart.git</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['revision']</code></td>
    <td>The version number to be installed</td>
    <td><code>latest</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['url_path']</code></td>
    <td>This is the path used after domain:port in URL. Ex.: http://local:port${url_path}</td>
    <td><code>/</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['home_dir']</code></td>
    <td>The directory of OpenCart installation</td>
    <td><code>/usr/local/opencart</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['http_port']</code></td>
    <td>The port number for HTTP connections</td>
    <td><code>58080</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['webmaster_email']</code></td>
    <td>Admin email</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['name']</code></td>
    <td>The name of the RDBMS Server</td>
    <td><code>mysqli</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['hostname']</code></td>
    <td>The hostname of the RDBMS Server</td>
    <td><code>localhost</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['port']</code></td>
    <td>The port number of the RDBMS Server</td>
    <td><code>3306</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['username']</code></td>
    <td>The user of the RDBMS Server which will be used by OpenCart</td>
    <td><code>opencart</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['password']</code></td>
    <td>The password for the provided RDBMS Server username</td>
    <td><code>opercart</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['dbname']</code></td>
    <td>The name of the database which will be used by OpenCart</td>
    <td><code>opencart</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['rdbms']['table_prefix']</code></td>
    <td>This prefix will be prepended to the table's name</td>
    <td><code></code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['admin']['username']</code></td>
    <td>Admin username</td>
    <td><code>admin</code></td>
  </tr>
  <tr>
    <td><code>node['opencart']['admin']['password']</code></td>
    <td>Admin password</td>
    <td><code>admin</code></td>
  </tr>
</table>

Recipes
-------

### opencart::default

To install OpenCart PHP from git to a directory

### opencart::create_database

Create a database for OpenCart

### opencart::create_tables

Create a database's tables for OpenCart

### opencart::create_ubuntu_env_for_test

Create a Ubuntu installation with Apache2 and MySQL for testing purpose

### opencart::test

Simple installation test

### opencart::apache2_restart

Simple Apache 2 bounce


License and Author
------------------

Author:: Manoel Carvalho (<manoelhc@gmail.com>)

Copyright:: 2016, Manoel Carvalho

License:: MIT

