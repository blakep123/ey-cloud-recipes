require 'pp'
#
# Cookbook Name:: nginx_rewrite
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  node[:applications].each do |app_name, data| 
    
    
    template "/etc/nginx/servers/#{app_name}.rewrites" do
      owner 'deploy'
      group 'deploy'
      mode  0644
      source "default.rewrites.erb"
    end
  end
end
