module Jekyll
  class ArchivesGenerator < Generator
    def generate(site)
      categories_map = {}
      site.posts.each do |post|
        if categories_map.has_key?(post.categories)
          categories_map[post.categories] << {"url"=>post.url, "title"=>post.title}
        else
          categories_map[post.categories] = [{"url"=>post.url, "title"=>post.title}]
        end
      end

      site.pages <<  ArchivesPage.new(site, site.source, "", "index.html", categories_map)
    end
  end

  class ArchivesPage < Page
    def initialize(site, base, dir, name, categories_map)
      super(site, base, dir, name)
      self.data['categories_map'] = categories_map 
    end
  end
end