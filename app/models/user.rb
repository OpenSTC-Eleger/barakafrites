require 'open_object'

class User < OpenStruct



  def self.find(user_context, id, fields = [])
    OpenObject.read(user_context,'res.users',[id], fields)
  end

end
