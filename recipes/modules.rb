# Helper which will load all modules defined in the array
#
node[:apache][:modules].each do |name|
  include_recipe "apache2::mod_#{name}"
end
