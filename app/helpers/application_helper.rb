module ApplicationHelper

  def admin?
    current_user && current_user.admin
  end

  def upload_dir
    if ENV['OPENSHIFT_DATA_DIR']
      ENV['OPENSHIFT_DATA_DIR']
    else
      Rails.root
    end
  end

  def separator
    if RUBY_PLATFORM.include? "windows"
        ";"
    else
        ":"
    end
  end

end
