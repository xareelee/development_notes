module Jekyll
 
  class TagIndex < Page    
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
 
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_index.html')
      self.data['tag'] = tag
      self.data['category'] = "Tag Index"
      self.data['title'] = "含有標籤 <span class=\"tags\">"+tag+"</span> 的頁面"
    end
  end
 
  class TagGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'tag_index'
        dir = 'tags'
        site.tags.keys.each do |tag|
          write_tag_index(site, File.join(dir, tag), tag)
        end
      end
    end
  
    def write_tag_index(site, dir, tag)
      index = TagIndex.new(site, site.source, dir, tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
 
end