require 'openerp'

class Menu

  def self.fetch(user_context,root_name = Config.get[:root_menu])
    root_id = Openerp.search(user_context,'ir.ui.menu',[['name', '=',root_name]]).first
    recursive_fetch(user_context,root_id)
  end


  def self.recursive_fetch(user_context,id)
    item = Openerp.read(user_context, 'ir.ui.menu', id,['child_id','name','complete_name','parent_id' ])
    item['path'] = item['complete_name'].split('/').map(&:parameterize).join('/')
    item['submenu'] = Array.new
    case item['child_id'].count
      when 0
        item
      else
        item['child_id'].each do |c|
          item['submenu'] << recursive_fetch(user_context,c)
        end
        item
    end
  end

end