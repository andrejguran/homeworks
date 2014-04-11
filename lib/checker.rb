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

end
