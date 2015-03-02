#
# Cookbook Name:: s3
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'aws'

aws_s3_file "/home/ec2-user/im/im181.zip" do
	bucket "vmimage-sydney"
	remote_path "agent.installer.linux.gtk.x86_64_1.8.1000.20141126_2002.zip"
	aws_access_key_id "AKIAJZMBDN54UTCHYW2Q"
	aws_secret_access_key "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"
end

aws_s3_file "/home/ec2-user/clm/clm502.zip" do
	bucket "vmimage-sydney"
	remote_path "JTS-CCM-QM-RM-repo-5.0.2.zip"
	aws_access_key_id "AKIAJZMBDN54UTCHYW2Q"
	aws_secret_access_key "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"
end

execute "unzipIM" do
	creates "/home/ec2-user/im/installc"
	command <<-EOH
		unzip /home/ec2-user/im/im181.zip -d /home/ec2-user/im
	EOH
end

execute "unzipCLM" do
	creates "/home/ec2-user/clm/repository.xml"
	command <<-EOH
		unzip /home/ec2-user/clm/clm502.zip -d /home/ec2-user/clm
	EOH
end

execute "installIM" do
	creates "/opt/IBM/InstallationManager"
	command <<-EOH
		/home/ec2-user/im/installc -log install.log -acceptLicense
	EOH
end
