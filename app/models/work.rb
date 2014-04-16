class Work < ActiveRecord::Base

  include ApplicationHelper

  belongs_to :task
  belongs_to :user
  attr_accessible :status, :homework, :message

  has_attached_file :homework

  VALID_STATUSES = %w(pending success fail)

  validates_inclusion_of :status, :in => VALID_STATUSES

  def valid_languages
    VALID_STATUSES
  end

  def checker
    return Checker.languages[self.task.language]
  end

  def generate
    return checker['class'].generate self
  end

  def compilable?
    return checker['class'].compilable? self
  end

  def data
    file_name = File.join(upload_dir, "homework/src", self.user.uco.to_s, self.id.to_s, self.task.package.tr(".", "/"), self.homework_file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close
    return data
  end

  def render
    return CodeRay.scan(self.data, checker['formating']).div
  end

  def destroy
    super
    checker['class'].destroy self
  end

  def compile
    checker['class'].compile self
  end
end
