class XqueryChecker

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

end
