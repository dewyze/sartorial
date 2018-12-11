module Jekyll
  class LinkToTag < Liquid::Tag

    def initialize(tag_name, source, tokens)
      super
      @source = source
    end

    def render(context)
      baseurl = context["site"]["baseurl"]
      text,path = @source.split("\", ")
      "<a href=\"#{baseurl}/#{path}\">#{text[1..-1]}</a>"
    end
  end
end

Liquid::Template.register_tag('link_to', Jekyll::LinkToTag)
