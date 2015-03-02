#
# Cookbook Name:: s3
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'aws'

aws_s3_file "/home/ec2-user/clm502.zip" do
	bucket "vmimage-sydney"
	remote_path "CLM-Web-Installer-Linux-5.0.2.zip"
	aws_access_key_id "your key"
	aws_secret_access_key "your key"
end

execute "unzip" do
	creates "/home/ec2-user/launchpad.sh"
	command <<-EOH
		unzip /home/ec2-user/clm502.zip -d /home/ec2-user
	EOH
end

execute "installIM" do
	creates "/tmp/silent-install/JazzTeamServer"
	command <<-EOH
		/home/ec2-user/im/linux.gtk.x86_64/installc -acceptLicense -showVerboseProgress -input /home/ec2-user/im/linux.gtk.x86_64/silent-install-server.xml --launcher.ini /home/ec2-user/im/linux.gtk.x86_64/silent-install.ini
	EOH
end
