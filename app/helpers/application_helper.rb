module ApplicationHelper

    def svg(name)
        file_path = "#{Rails.root}/app/assets/images/svg/#{name}.svg"
        return File.read(file_path).html_safe if File.exists?(file_path)
        '(not found)'
    end

    def flash_modal_title(level)
        case level.to_sym
            when :notice then "Notice"
            when :success then "Success"
            when :error then "Error Occured"
            when :alert then "Alert"
            else "Alert"     
        end
    end

    def flash_modal_button_type(level)
        case level.to_sym
            when :notice then "btn-primary"
            when :error then "btn-danger"
            when :alert then "btn-warning"
            else "btn-primary"
        end
    end

end
