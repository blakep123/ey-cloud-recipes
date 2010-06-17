require 'pp'
#
# Cookbook Name:: ssmtp
# Recipe:: default
#

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  directory "/etc/ssmtp" do
    recursive true
    action :delete
  end

  directory "/data/ssmtp" do
    owner "root"
    group "root"
    mode "0755"
    action :create
    not_if "test -d /data/ssmtp"
  end
 

  link "/etc/ssmtp" do
    to '/data/ssmtp'
  end
  
  template "/etc/ssmtp/ssmtp.conf" do
    owner 'deploy'
    group 'deploy'
    mode  0644
    source "ssmtp.conf.erb"
    variables ({
      :server => "smtp.gmail.com",
      :port => "587",
      :domain => "youdesignit.com",
      :fromLineOverrides =>"YES",
      :useSTARTTLS => "YES",
      :AuthUser => "no-reply@youdesignit.com",
      :AuthPass => "ydinoreply"
      })
  end

end
