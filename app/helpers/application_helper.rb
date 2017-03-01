module ApplicationHelper

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end

  def set_main_category(name, controller_name)
    return 'active' if name == controller_name
  end
end
