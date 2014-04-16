class XqueryChecker < Checker

  def self.check
    return "checkujem xquery"
  end

  def self.generate work
    xq_file = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"), work.homework_file_name)
    command = "java -cp " + Rails.root.to_s + "/lib/assets/saxon9he.jar net.sf.saxon.Query " + xq_file
    response = `#{command}`

    require 'rexml/document'
    doc = REXML::Document.new(response)
    f = REXML::Formatters::Pretty.new
    pretty_xml = String.new
    f.write(doc, pretty_xml)

    return CodeRay.scan(pretty_xml, :xml).div
  end


  def self.compilable? work
    new_file_path = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"), work.homework_file_name)
    FileUtils.mkdir_p(File.dirname(new_file_path))
    FileUtils.cp work.homework.path, File.dirname(new_file_path)

    test_file_path = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package.tr(".", "/"), work.task.task_file_file_name)

    FileUtils.cp test_file_path, File.dirname(new_file_path)

    command = "java -cp " + Rails.root.to_s + "/lib/assets/saxon9he.jar net.sf.saxon.Query " + new_file_path
    return system(command)
  end

  def self.compile work
    work.status = "pending"
  end

end
