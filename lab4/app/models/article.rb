class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  before_save :check_report_threshold

  private
    def check_report_threshold
      logger.debug "update"
      puts "update"
      self.reports_count ||= 0
      if self.reports_count >= 3
        self.archived = true
      end
    end
end
