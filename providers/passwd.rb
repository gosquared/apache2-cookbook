action :add do
  ruby_block "Adding #{new_resource.username} to Apache authentication" do
    block do
      htdigest = %x{printf "#{new_resource.username}:Authorized:#{new_resource.password}" | md5sum | cut -d' ' -f1}.chomp
      unless ::File.read("/etc/apache2/.passwds").include? "#{new_resource.username}:Authorized:#{htdigest}"
        ::File.open("/etc/apache2/.passwds", 'a') { |f| f.puts "#{new_resource.username}:Authorized:#{htdigest}" }
      end
    end
  end
end

action :remove do
  ruby_block "Removing #{new_resource.username} from Apache authentication" do
    block do
      unless ::File.size("/etc/apache2/.passwds") == 0
        apache_passwds = Chef::Util::FileEdit.new("/etc/apache2/.passwds")
        apache_passwds.search_file_replace_line("#{new_resource.username}:Authorized:#{htdigest}", "")
        apache_passwds.write_file
      end
    end
  end
end

def load_current_resource
  file "/etc/apache2/.passwds" do
    mode "0644"
    owner "root"
    group "root"
    action :create_if_missing
    backup false
  end
end
