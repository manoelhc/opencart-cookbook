resource_name :opencart

# Git properties
property :git_url, String, default: "https://github.com/opencart/opencart.git"
property :branch, String, default: 'master'

# Unix properties
property :username, String, default: 'opencart'

# DB properties
property :rdbms_name         , String, default: 'mysqli'
property :rdbms_root_username, String, default: 'root'
property :rdbms_root_password, String, default: 'root'
property :rdbms_hostname     , String, default: 'localhost'
property :rdbms_port         , Integer, default: 3306
property :rdbms_username     , String, default: 'opencart'
property :rdbms_password     , String, default: 'opencart'
property :rdbms_dbname       , String, default: 'opencart'
property :rdbms_table_prefix , String, default: 'oc_'

# OpenCart properties
property :admin_username, String, default: 'admin'
property :admin_password, String, default: 'admin123'
property :opencart_home, String, default: '/opt/opencart'
property :server_name, String, default: 'opencart.test'
property :webmaster_email, String, default: 'webmaster@example.com'

# Apache httpd properties
property :url_path, String, default: '/'
property :http_port, Integer, default: 80
property :ssl_port, Integer, default: 443
property :ssl_cert, String, default: "/etc/opencart/certs/domain.com.crt"
property :ssl_cert_key, String, default: "/etc/opencart/certs/domain.com.key"
property :ssl_trusted_cert, String, default: "/etc/opencart/certs/unified-ssl.crt"

action :create do

  directory '/etc/opencart/certs' do
    owner 'root'
    group 'root'
    recursive true
    mode '0755'
    action :create
  end

  user 'opencart' do
    action :create
  end

  git_client 'default' do
    action :install
  end

  directory "#{opencart_home}/releases/#{branch}" do
    owner 'root'
    group 'root'
    recursive true
    mode '0755'
    action :create
  end

  git "#{opencart_home}/releases/#{branch}" do
    repository git_url
    revision branch
    action :export
  end

  directory "#{opencart_home}/releases/#{branch}/vendor" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  bash "apt-flush-cache" do
    code <<-EOH
      apt-get update
    EOH
    only_if { node['platform_family'] == 'debian' }
  end

  # Install certs
  OpenCartHelper::Certificates.new(ssl_cert, ssl_cert_key, ssl_trusted_cert)

  include_recipe 'php'
  php_fpm_pool "default" do
    action :install
  end
  include_recipe 'chef_nginx::default'

  directory "/var/log/nginx" do
    owner 'nginx'
    group 'nginx'
    mode '0755'
    action :create
  end

  template '/etc/nginx/sites-enabled/000-default' do
    source 'nginx_config.conf.erb'
    owner 'root'
    group 'root'
    variables partials: {
      'http_port'        => http_port,
      'ssl_port'         => ssl_port,
      'ssl_cert'         => ssl_cert,
      'ssl_cert_key'     => ssl_cert_key,
      'ssl_trusted_cert' => ssl_trusted_cert,
      'opencart_home'    => opencart_home,
      'branch'           => branch,
      'server_name'      => server_name
    }
    mode '0775'
  end

end

action :delete do
  directory opencart_home do
    action :delete
  end
end
