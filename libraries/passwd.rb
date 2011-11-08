module Apache2
  module Passwd
    def htdigest
      return @htdigest if @htdigest

      @htdigest = ["#{new_resource.username}:#{new_resource.realm}:"]
      @htdigest << `echo -n "#{@htdigest.first}#{new_resource.password}" | md5sum | awk {'print $1'}`.chomp
    end
  end
end
