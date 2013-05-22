require 'xmlrpc/client'
class Openerp

  @host = Config.get[:openerp][:host]
  @port = Config.get[:openerp][:port]
  @common = Config.get[:openerp][:common]
  @object = Config.get[:openerp][:object]
  @base = Config.get[:openerp][:base]
  @common_client = XMLRPC::Client.new(@host,@common,@port).proxy(nil)

  def self.login(dbname,user,password)
    @common_client.login(dbname,user,password)
  end

  def self.read(user_context,model,ids,fields)
    object_client(user_context).execute(model,'read',ids,fields)
  end

  def self.search(user_context,model,args = [])
    object_client(user_context).execute(model,'search',args)
  end

  def self.object_client(user_context)
    XMLRPC::Client.new(@host,@object,@port).proxy(nil,user_context[:dbname],user_context[:uid],user_context[:pwd])
  end

  private_class_method :object_client

end