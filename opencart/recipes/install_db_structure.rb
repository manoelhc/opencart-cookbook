user 'opencart' do
  action :create
end

opencart_home = node['opencart']['home_dir'] + "/releases/" + node['opencart']['release']
opencart_conf_home = node['opencart']['home_dir'] + "/config/" + node['opencart']['release']

directory opencart_conf_home  do
  group 'root'
  owner 'root'
  recursive true
  mode '0755'
  action :create
end

template opencart_conf_home + '/config.php' do
  source 'config.php.erb'
  owner 'root'
  group 'root'
  mode '0664'
end

template opencart_conf_home + "/db_bootstrap.php" do
  source 'db_bootstrap.php.erb'
  owner 'root'
  group 'root'
  mode '0775'
end

bash 'execute-db-bootstrap' do
  code <<-EOH
    php "#{opencart_conf_home}/db_bootstrap.php"
    EOH
end
