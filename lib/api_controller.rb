module ApiController




  def format_filters(params_filter)
    filters = if params_filter.size > 0
                params_filter.map do |filter|
                  [filter[:field], filter[:operator], filter[:value]]
                end
              else
                params_filter
              end
  end

end