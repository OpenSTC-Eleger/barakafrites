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

  def self.read(user_context,model,ids,fields = [])
    object_client(user_context).execute(model,'read',ids,fields)
  end

  def self.search(user_context,model,args = [])
    object_client(user_context).execute(model,'search',args)
  end

  def self.write(user_context,model,ids,args)
    begin
      res = object_client(user_context).execute(model,'write',ids,args)
      {success: res, errors: nil}
    rescue RuntimeError => e
      Rails.logger.error(e.message.inspect)
      {success: false, errors: e.message}
    end
  end

  def self.create(user_context,model,args)
    begin
     id = object_client(user_context).execute(mode,'create', args)
     {success:true,errors:nil,id:id}
    rescue RuntimeError => e
      Rails.logger.error(e.message)
      {success:false,errors:e.message}
  end


  # Openerp.object_client is the XMLRPC connection proxy
  # It handles server connection to the object namespace
  def self.object_client(user_context)
    XMLRPC::Client.new(@host,@object,@port).proxy(nil,user_context[:dbname],user_context[:uid],user_context[:pwd])
  end

  private_class_method :object_client

end