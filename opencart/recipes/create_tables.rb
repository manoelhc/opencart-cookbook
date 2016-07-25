opencart_home      = node['opencart']['home_dir'] + "/releases/" + node['opencart']['release']
opencart_conf_home = node['opencart']['home_dir'] + "/config/" + node['opencart']['release']

bash 'create-db-structure' do
  code <<-EOH
    php -d #{opencart_conf_home}/php.ini #{opencart_conf_home}/cli_install.php install \
      --db_hostname "#{node['opencart']['rdbms']['hostname']}" \
      --db_username "#{node['opencart']['rdbms']['root_username']}" \
      --db_password "#{node['opencart']['rdbms']['root_password']}" \
      --db_database "#{node['opencart']['rdbms']['dbname']}" \
      --db_driver "#{node['opencart']['rdbms']['name']}" \
      --db_prefix "#{node['opencart']['rdbms']['table_prefix']}" \
      --db_port "#{node['opencart']['rdbms']['port']}" \
      --username "#{node['opencart']['rdbms']['username']}" \
      --password "#{node['opencart']['rdbms']['password']}" \
      --email "#{node['opencart']['webmaster_email']}" \
      --http_server "http://#{node['opencart']['hostname']}:#{node['opencart']['http_port']}#{node['opencart']['url_path']}"
  EOH
end
