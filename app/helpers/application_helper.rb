module ApplicationHelper
    def humanize_boolean(value)
      if value
        "Yes"
      else
        "No"
      end
    end
end
