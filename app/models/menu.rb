require 'open_object'

class Menu

  def self.fetch(user_context,root_name = BarakafritesConfig.get[:root_menu])
    root_id = Openerp.search(user_context,'ir.ui.menu',[['name', '=',root_name]]).first
    recursive_fetch(user_context,root_id)
  end


  def self.recursive_fetch(user_context,id)
    item = Openerp.read(user_context, 'ir.ui.menu', id,['child_id','name','complete_name','parent_id' ])
    item['path'] = build_path_from_string(item)
    item['submenu'] = Array.new
    case item['child_id'].try :count
      when nil
        item
      when 0
        item
      else
        item['child_id'].each do |c|
          item['submenu'] << recursive_fetch(user_context,c)
        end
        item
    end
  end




  def self.build_path_from_string(menu_item)
    case menu_item['complete_name']
      when nil
        ''
      else
        menu_item['complete_name'].split('/').map(&:parameterize).join('/')
    end
  end



end