define :audit do

  name      = params[:name]

  ruby_block name do
    block do
      Chef::Log.warn("Compliance::Failure #{name}")
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
      notifies :create, resources(:ruby_block => name), :delayed
    end
  when "file"
    file name do
      owner owner
      group group
      mode mode
      notifies :create, resources(:ruby_block => name), :delayed
    end
  end
end
