class Upload < ApplicationRecord
  require 'smarter_csv'
  # include Rails.application.routes.url_helpers
  
  # Callbacks
  after_create_commit :create_data

  # Relations
  belongs_to :user
  has_one_attached :csv_file


  def create_data
    data = SmarterCSV.process(ActiveStorage::Blob.service.path_for(self.csv_file.key), {col_sep: ','})
  end

end
