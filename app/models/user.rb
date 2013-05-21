require 'openerp'
class User < OpenStruct


  def self.authenticate(dbname,login,password)
    Openerp.login(dbname,login,password)
  end

  def self.find(user_context, id, fields = [])
    Openerp.read(user_context,'res.users',[id], fields)
  end

end
