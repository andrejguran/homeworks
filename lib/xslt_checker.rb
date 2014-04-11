class XsltChecker

  def check
    return "checkujem xslt"
  end

  def self.generate work
    xsl_file = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"), work.homework_file_name)
    xml_file = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package.tr(".", "/"), work.task.task_file_file_name)
    doc = Nokogiri::XML(File.read(xml_file))
    xslt = Nokogiri::XSLT(File.read(xsl_file))

    return xslt.transform(doc)
  end

end
