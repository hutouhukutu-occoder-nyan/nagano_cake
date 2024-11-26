module Admin::ItemsHelper

  def item_status(item)
    item.is_active ? 'text-success' : 'text-danger'
  end

end
