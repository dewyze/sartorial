module Jekyll
  class StyledTabledTag < Liquid::Tag

    def initialize(tag_name, data, tokens)
      super
      @data = data
    end

    def render(context)
      @table = context[@data]

      result = "<table>"
      result << _headers(@table["headers"])
      result << _rows(@table["rows"])
      result << "</table>\n"
    end

    private

    def _headers(headers)
      result = "<tr>\n"
      headers.each {|header| result << _th(header) }
      result << "</tr>\n"
    end

    def _th(header)
      "<th>#{header}</th>\n"
    end

    def _rows(rows)
      @table["rows"].reduce("") do |acc, row|
        acc += _tr(row)
      end
    end

    def _tr(row)
      result = "<tr>"
      row.each_with_index do |cell, idx|
        result << _td(cell, idx)
      end
      result << "</tr>\n"
    end

    def _td(text, idx)
      classes = @table.dig("td_tags", idx, "classes")
      klass = "class=\"#{classes}\"" if classes
      "<td #{klass}>#{_wrap(text, idx)}</td>\n"
    end

    def _wrap(text, idx)
      wrapper = @table.dig("td_tags", idx, "wrapper")
      open = "<#{wrapper}>" if wrapper
      close = "</#{wrapper}>" if wrapper
      "#{open}#{text.to_s}#{close}\n"
    end
  end
end

Liquid::Template.register_tag('styled_table', Jekyll::StyledTabledTag)
