module TyneCore
  class PaginationCell < Cell::Rails
    def show(*args)
      options = args.extract_options!
      @collection = options[:collection]
      @current_page = options[:current_page]
      @page_count = options[:page_count]
      @total = options[:total]
      @page_size = options[:page_size]
      @sizes = [10, 25, 50, 100]

      render
    end
  end
end
