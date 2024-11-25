class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.search_by_name(query)
    if query.present?
      where("name LIKE ?", "%#{query}%")
    else
      all
    end
  end
  
end
