#
# Author:: Adam Garside (<adam.garside@gmail.com>)
# Cookbook Name:: compliance
# Recipe:: ubuntu_10.04
#
# Copyright 2009-2012, Adam Garside
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

audit "/root" do
  resource "directory"
  owner "root"
  group "root"
  mode "0700"
end

# Sticky bit directories
audit "/var/spool/cron/crontabs" do
  resource "directory"
  owner "root"
  group "crontab"
  mode "1730"
end

%w{ /dev/shm /tmp /tmp/.ICE-unix /tmp/.X11-unix /var/lock /var/tmp }.each do |dir|
  audit dir do
    resource "directory"
    owner "root"
    group "root"
    mode "1777"
  end
end

# SUID /bin binaries
%w{ mount ping ping6 su umount }.each do |bin|
  audit "/bin/#{bin}" do
    resource "file"
    owner "root"
    group "root"
    mode  "4755"
  end
end

# SUID /usr/bin binaries
%w{ chfn chsh gpasswd newgrp passwd sudo sudoedit }.each do |bin|
  audit "/usr/bin/#{bin}" do
    resource "file"
    owner "root"
    group "root"
    mode  "4755"
  end
end

# SUID /usr/lib binaries
%w{ eject/dmcrypt-get-device openssh/ssh-keysign pt_chown }.each do |lib|
  audit "/usr/bin/#{lib}" do
    resource "file"
    owner "root"
    group "root"
    mode  "4755"
  end
end

# SGID binaries
%w{ /sbin/unix_chkpwd /usr/bin/chage /usr/bin/expiry }.each do |bin|
  audit bin do
    resource "file"
    owner "root"
    group "shadow"
    mode  "2755"
  end
end

%w{ bsd-write wall }.each do |bin|
  audit "/usr/bin/#{bin}" do
    resource "file"
    owner "root"
    group "tty"
    mode  "2755"
  end
end

%w{ dotlockfile mail-lock mail-touchlock mail-unlock }.each do |bin|
  audit "/usr/bin/#{bin}" do
    resource "file"
    owner "root"
    group "mail"
    mode  "2755"
  end
end
  
audit "/usr/bin/crontab" do
  resource "file"
  owner "root"
  group "crontab"
  mode  "2755"
end

audit "/usr/bin/ssh-agent" do
  resource "file"
  owner "root"
  group "ssh"
  mode  "2755"
end

# SGID directories
%w{ /lib/python2.6 /lib/python2.6/dist-packages %/lib/python2.6/site-packages /lib/site_ruby/1.8/x86_64-linux %/share/ca-certificates /share/fonts /share/sgml /share/sgml/declaration %/share/sgml/dtd /share/sgml/entities /share/sgml/misc %/share/sgml/stylesheet /share/xml /share/xml/declaration %/share/xml/entities /share/xml/misc /share/xml/schema }.each do |dir|
  audit "/usr/local/#{dir}" do
    resource "directory"
    owner "root"
    group "staff"
    mode  "2775"
  end
end

audit "/var/cache/man" do
  resource "directory"
  owner "man"
  group "root"
  mode  "2755"
end

audit "/usr/src" do
  resource "directory"
  owner "root"
  group "src"
  mode  "2775"
end

audit "/var/lib/libuuid" do
  resource "directory"
  owner "libuuid"
  group "libuuid"
  mode  "2775"
end

audit "/var/local" do
  resource "directory"
  owner "root"
  group "staff"
  mode  "2775"
end

audit "/var/mail" do
  resource "directory"
  owner "root"
  group "mail"
  mode  "2775"
end

# /etc/{passwd, group}
%w{ passwd group }.each do |conf|
  audit "/etc/#{conf}" do
    resource "file"
    owner "root"
    group "root"
    mode "0644"
  end
end

# /etc/{shadow, gshadow}
%w{ shadow gshadow }.each do |conf|
  audit "/etc/#{conf}" do
    resource "file"
    owner "root"
    group "shadow"
    mode "0640"
  end
end
