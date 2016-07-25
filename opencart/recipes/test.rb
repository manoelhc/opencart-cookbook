bash 'ping-test' do
  code <<-EOH
    wget "http://#{node['opencart']['hostname']}:#{node['opencart']['http_port']}#{node['opencart']['url_path']}/index.php?route=product/search&search=test"
  EOH
end
