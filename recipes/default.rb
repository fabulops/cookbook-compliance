#
# Author:: Adam Garside (<adam.garside@gmail.com>)
# Cookbook Name:: compliance
# Recipe:: default
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

platform = "#{node[:platform]}-#{node[:platform_version]}"

case platform
when "ubuntu-10.04"
  include_recipe "compliance::ubuntu_10.04"
else
  Chef::Log.debug("Compliance:: Unsupported Platform")
end
