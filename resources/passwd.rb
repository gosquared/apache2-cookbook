actions :add,
        :remove

attribute :username,    :kind_of => String, :name_attribute => true
attribute :realm,       :kind_of => String, :default => "Authorized"
attribute :password,    :kind_of => String
attribute :passwd_file, :kind_of => String, :default => "/etc/apache2/.passwds"
