#
# Author:: Adam Garside (<adam.garside@gmail.com>)
# Cookbook Name:: compliance
# Definition:: audit
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
define :audit do
  name      = params[:name]

  if node[:compliance][:ignore].include?(name)
    Chef::Log.warn("Compliance::Ignore #{name}")
  else

    ruby_block name do
      block do
        Chef::Log.warn("Compliance::Failure #{name}")
        node.set[:compliance][:failure] = true
        node.save
      end
      action :nothing
    end
    
    resource  = params[:resource]
    owner     = params[:owner]
    group     = params[:group]
    mode      = params[:mode]

    case resource
    when "directory"
      directory name do
        owner owner
        group group
        mode mode
        only_if do 
          File.exists?(name)
        end
        notifies :create, resources(:ruby_block => name), :delayed
      end
    when "file"
      file name do
        owner owner
        group group
        mode mode
        only_if do 
          File.exists?(name)
        end
        notifies :create, resources(:ruby_block => name), :delayed
      end
    end

  end
end
