class Category::Filter
  def filter(scope, query_params)
    if query_params[:title].present?
      scope = scope.where("title ILIKE :title OR description ILIKE :title", title: "%#{query_params[:title]}%")
    end

    scope
  end
end
