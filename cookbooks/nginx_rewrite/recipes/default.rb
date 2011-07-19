require 'pp'
#
# Cookbook Name:: nginx_rewrite
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  node[:applications].each do |app_name, data|   
    template "/etc/nginx/servers/#{app_name}.custom.conf" do
      owner 'deploy'
      group 'deploy'
      mode  0644
      source "server.conf.erb"
    end
  end
  
  execute "restarting-nginx" do
    command "/etc/init.d/nginx restart"
  end
  
  
end
