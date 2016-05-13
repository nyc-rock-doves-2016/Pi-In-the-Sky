class ApiData < DataObject
  has_many :favorites, foreign_key: :api_data_id
  has_many :users, through: :favorites
end
