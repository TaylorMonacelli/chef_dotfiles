include_recipe 'chocolatey'

if node['platform'] != 'windows'
  package 'git'
else

  chocolatey_package 'git'

  windows_path 'C:\Program Files\Git\bin' do
    action :add
  end
end

git node['chef_dotfiles']['dotfiles_path'] do
  repository 'https://github.com/taylormonacelli/dotfiles.git'
  revision 'master'
  depth 50
  action :sync
end
