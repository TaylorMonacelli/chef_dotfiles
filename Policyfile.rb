name 'chef_dotfiles'
default_source :supermarket
run_list 'chef_dotfiles::default'
named_run_list :testbase, 'chef_dotfiles::packages'
named_run_list :myrun, 'chef_dotfiles::default'
cookbook 'chef_dotfiles', path: '.', branch: 'master'
