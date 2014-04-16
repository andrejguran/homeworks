class XsltChecker < Checker

  def check
    return "checkujem xslt"
  end

  def self.compilable? work
    begin
      Nokogiri::XSLT(File.read(work.homework.path))
    rescue
      return false
    end

    return true
  end

  def self.generate work
    xsl_file = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"), work.homework_file_name)
    xml_file = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package.tr(".", "/"), work.task.task_file_file_name)
    doc = Nokogiri::XML(File.read(xml_file))
    xslt = Nokogiri::XSLT(File.read(xsl_file))

    return xslt.transform(doc)
  end

  def self.compile work
    new_file_path = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"), work.homework_file_name)
    FileUtils.mkdir_p(File.dirname(new_file_path))
    FileUtils.cp work.homework.path, new_file_path
  end

end
