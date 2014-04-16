class Checker

  def self.languages
    {
      'java' => {
        'class' => JavaChecker,
        'formating' => :java
      },
      'xslt' => {
        'class' => XsltChecker,
        'formating' => :php
      },
      'xquery' => {
        'class' => XqueryChecker,
        'formating' => :xml
      }
    }
  end

  def self.compilable? work
    raise "Not implemented!"
  end

  def self.generate work
    raise "Not implemented!"
  end

  def self.compile work
    raise "Not implemented!"
  end

  def self.destroy work
    work_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s)
    FileUtils.rm_rf(work_dir)
  end

end
