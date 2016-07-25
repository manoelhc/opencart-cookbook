#
# Cookbook Name:: opencart
# Recipe:: default
#
opencart_home      = node['opencart']['home_dir'] + "/releases/" + node['opencart']['release']
opencart_conf_home = node['opencart']['home_dir'] + "/config/" + node['opencart']['release']

user 'opencart' do
  action :create
end

git_client 'default' do
  action :install
end

directory node['opencart']['home_dir'] do
  owner 'root'
  group 'root'
  recursive true
  mode '0755'
  action :create
end

git opencart_home do
  repository node['opencart']['git_url']
  revision node['opencart']['release']
  action :export
end

directory opencart_home + "/vendor" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory opencart_conf_home do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#composer_project opencart_home do
#  dev false
#  quiet true
#  prefer_dist false
#  action :install
#end

bash 'move-php-config' do
  code <<-EOH
    mv #{opencart_home}/upload/install/php.ini #{opencart_conf_home}/php.ini
    exit 0
    EOH
end

template opencart_home + "/upload/config.php" do
  source 'config.php.erb'
  owner 'root'
  group 'root'
  mode '0775'
end

template opencart_home + "/upload/admin/config.php" do
  source 'config.admin.php.erb'
  owner 'root'
  group 'root'
  mode '0775'
end



template opencart_conf_home + "/cli_install.php" do
  source 'cli_fix.php.erb'
  owner 'root'
  group 'root'
  mode '0775'
end

template opencart_conf_home + "/apache2_opencart.conf" do
  source 'apache.opencart.conf.erb'
  owner 'root'
  group 'root'
  mode '0775'
end
