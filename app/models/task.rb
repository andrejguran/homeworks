class Task < ActiveRecord::Base
  attr_accessible :description, :name, :language, :task_file, :package, :deadline

  belongs_to :user
  has_many :works

  has_attached_file :task_file, :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"

  VALID_LANGUAGES = %w(java xquery xslt)

  validates :name,        :presence => true
  validates :description, :presence => true
  validates_inclusion_of :language, :in => lambda { |i| i.valid_languages }

  def valid_languages
    Checker.languages.keys
  end

  def to_csv(options = {})
    CSV.generate do |csv|
      csv << ["id", "uco", "created_at", "status"]
      self.works.each do |work|
        csv << [work.id, work.user.uco, work.created_at, work.status]
      end
    end
  end

  def deadline_time
    self.deadline ? self.deadline.strftime("%d.%m.%Y %T") : '-'
  end

  def before_deadline
    unless self.deadline
      return true
    else
      return self.deadline >= Time.now.in_time_zone(Rails.application.config.time_zone)
    end
  end

end
