opencart_home = node['opencart']['home_dir'] + "/releases/" + node['opencart']['release']
opencart_conf_home = node['opencart']['home_dir'] + "/config/" + node['opencart']['release']

bash 'apt-get update' do
  code <<-EOH
    apt-get update
    EOH
end

#apt-get install php5-mcrypt php5-curl php5-gd
bash 'install-env' do
  code <<-EOH
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password #{node['opencart']['rdbms']['root_password']}'
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password #{node['opencart']['rdbms']['root_password']}'

  sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-user string #{node['opencart']['rdbms']['root_username']}'
  sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password #{node['opencart']['rdbms']['root_password']}'
  sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'
  sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass #{node['opencart']['rdbms']['root_password']}'
  sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm #{node['opencart']['rdbms']['root_password']}'

  sudo apt-get -y install mysql-server phpmyadmin lynx php5-mcrypt php5-gd php5-curl lynx vim curl
  php5enmod gd
  php5enmod curl
  php5enmod mcrypt

  ln -s #{opencart_conf_home}/apache2_opencart.conf /etc/apache2/sites-enabled 2>/dev/null
  exit 0
  EOH
end
