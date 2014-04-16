class Task < ActiveRecord::Base
  attr_accessible :description, :name, :language, :task_file, :package

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

end
