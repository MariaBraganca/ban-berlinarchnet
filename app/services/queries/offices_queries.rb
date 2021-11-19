module Queries
  class OfficesQueries
    attr_reader :page, :records_per_page

    def initialize(scope, page, records_per_page)
      @scope = scope
      @page = page
      @records_per_page = records_per_page
    end

    def alphabetic
      @scope
        .includes(:ratings, photo_attachment: :blob)
        .order(:name)
        .limit(records_per_page)
        .offset(page * records_per_page)
    end

    def averages(type)
      @scope
        .preload(:ratings, photo_attachment: :blob)
        .joins(:ratings)
        .group('offices.id')
        .order("avg(ratings.#{type}) desc, offices.name")
        .limit(records_per_page)
        .offset(page * records_per_page)
    end

    def search(query)
      @scope
        .includes(:ratings, photo_attachment: :blob)
        .where('name ILIKE ?',"%#{query}%")
        .order(:name)
        .limit(records_per_page)
        .offset(page * records_per_page)
    end
  end
end
