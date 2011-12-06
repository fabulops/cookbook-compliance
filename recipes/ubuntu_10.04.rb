#
# Author:: Adam Garside (<adam.garside@gmail.com>)
# Cookbook Name:: compliance
# Recipe:: ubuntu_10.04
#
# Copyright 2009-2011, Adam Garside
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
Chef::Log.debug("Compliance:: Running on Ubuntu 10.04")

# Standard directories
%w{ bin boot build cdrom dev etc home lib media mnt opt sbin selinux srv sys usr var }.each do |dir|
  audit "/#{dir}" do
    resource "directory"
    owner "root"
    group "root"
    mode "0755"
  end
end

audit "/tmp" do
  resource "directory"
  owner "root"
  group "root"
  mode "1777"
end

# SUID /usr/bin binaries
%w{ passwd }.each do |bin|
  audit "/usr/bin/#{bin}" do
    resource "file"
    owner "root"
    group "root"
    mode  "4755"
  end
end
