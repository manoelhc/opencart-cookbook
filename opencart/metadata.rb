name             'opencart'
maintainer       'Manoel Carvalho'
maintainer_email 'manoelhc@gmail.com'
license          'All rights reserved'
description      'Installs/Configures opencart'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'yum'
depends          'apt'

%w[ centos redhat fedora debian ubuntu ].each do |os|
  supports os
end

attribute "opencart/git_url",
  :display_name          => "OpenCart Git repository URL",
  :description           => "The URL of OpenCart repository to be installed",
  :default               => "https://github.com/opencart/opencart.git"

attribute "opencart/url_path",
  :display_name          => "OpenCart URL path",
  :description           => "This is the path used after domain:port in URL. Ex.: http://local:port${url_path}",
  :default               => "/"

attribute "opencart/home_dir",
  :display_name          => "OpenCart home directory",
  :description           => "The directory of OpenCart installation",
  :default               => "/usr/local/opencart"

attribute "opencart/http_port",
  :display_name          => "OpenCart port for HTTP",
  :description           => "The port number for HTTP connections",
  :default               => "58080"

attribute "opencart/https_port",
  :display_name          => "OpenCart port HTTPS",
  :description           => "The port number for HTTP connections",
  :default               => "12443"

attribute "opencart/version",
  :display_name          => "OpenCart version",
  :description           => "The version number to be installed",
  :default               => "latest"

attribute "opencart/mysql/hostname",
  :display_name          => "MySQL Hostname",
  :description           => "The hostname of the MySQL Server",
  :default               => "localhost"

attribute "opencart/mysql/port",
  :display_name          => "MySQL Port",
  :description           => "The port number of the MySQL Server",
  :default               => "3306"

attribute "opencart/mysql/username",
  :display_name          => "MySQL Username",
  :description           => "The user of the MySQL Server which will be used by OpenCart",
  :default               => "opencart"

attribute "opencart/mysql/password",
  :display_name          => "MySQL Password",
  :description           => "The password for the provided MySQL Server username",
  :default               => ""

attribute "opencart/mysql/dbname",
  :display_name          => "Database name",
  :description           => "The name of the database which will be used by OpenCart",
  :default               => "opencart"

attribute "opencart/mysql/table_prefix",
  :display_name          => "Table prefix",
  :description           => "This prefix will be prepended to the table's name",
  :default               => ""

attribute "opencart/admin/username",
  :display_name          => "Admin username",
  :description           => "Admin username",
  :default               => "admin"

attribute "opencart/admin/password",
  :display_name          => "Admin password",
  :description           => "Admin password",
  :default               => "admin"

attribute "opencart/admin/email",
  :display_name          => "Admin email",
  :description           => "Admin email",
  :default               => ""
