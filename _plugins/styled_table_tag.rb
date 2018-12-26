module Jekyll
  class StyledTabledTag < Liquid::Tag

    def initialize(tag_name, source, tokens)
      super
      @source = source.strip
    end

    def render(context)
      if context["page"]["data"] && !@source.start_with?("site.data")
        data = context["page"]["data"].inject(context) {|acc, key| acc[key]}
        data = data[@source]
      else
        data = context[@source]
      end
      @data = data["data"]
      @style = data["style"]

      result = "<table class=#{@style["table"]["classes"]}>"
      result << _headers(@data["headers"])
      result << _rows(@data["rows"])
      result << "</table>\n"
    end

    private

    def _headers(headers)
      result = "<tr>\n"
      headers.each {|header| result << _th(header) }
      result << "</tr>\n"
    end

    def _rows(rows)
      @data["rows"].reduce("") do |acc, row|
        acc += _tr(row)
      end
    end

    def _tr(row)
      result = "<tr>\n"
      row.each_with_index do |cell, idx|
        result << _td(cell, idx)
      end
      result << "</tr>\n"
    end

    def _th(header)
      "<th>#{header}</th>\n"
    end

    def _td(text, idx)
      classes = @style.dig("columns", idx, "classes")
      klass = "class=\"#{classes}\"" if classes
      "<td #{klass}>#{_wrap(text, idx)}</td>\n"
    end

    def _wrap(text, idx)
      wrapper = @style.dig("columns", idx, "wrapper")
      open = "<#{wrapper}>" if wrapper
      close = "</#{wrapper}>" if wrapper
      "#{open}#{text.to_s}#{close}\n"
    end
  end
end

Liquid::Template.register_tag('styled_table', Jekyll::StyledTabledTag)
