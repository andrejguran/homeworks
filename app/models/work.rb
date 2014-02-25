class Work < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  attr_accessible :status, :homework, :message

  has_attached_file :homework

  VALID_STATUSES = %w(pending success fail)

  validates_inclusion_of :status, :in => VALID_STATUSES

  def valid_languages
    VALID_STATUSES
  end
end
