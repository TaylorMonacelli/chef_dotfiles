include_recipe 'chef_dotfiles::packages'

dfpath = node['chef_dotfiles']['dotfiles_path']

directory dfpath do
  action :create
  recursive true
end

case node['platform']
when 'windows'
  powershell_script "force checkout dotfiles to \"#{dfpath}\"" do
    cwd dfpath
    code <<-EOH
      git init
      git remote add origin https://github.com/taylormonacelli/dotfiles.git
      git fetch --depth 50
      $ec = $error.count
      git checkout --force master
      if ($ec -ne $error.count) {
        $error.removeAt(0)
      }
    EOH
    not_if { ::Dir.exist?('.git') }
  end

else
  bash "force checkout dotfiles to \"#{dfpath}\"" do
    cwd dfpath
    code <<-EOH
      git init
      git remote add origin https://github.com/taylormonacelli/dotfiles.git
      git fetch --depth 50
      git checkout --force master
    EOH
    not_if { ::Dir.exist?('.git') }
  end

end
