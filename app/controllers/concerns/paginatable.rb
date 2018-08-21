module Paginatable
  private def render_with_pagination_meta(collection)
    render json: collection, meta: pagination_meta(collection)
  end

  private def pagination_meta(collection)
    return nil unless collection.respond_to?(:current_page)

    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
