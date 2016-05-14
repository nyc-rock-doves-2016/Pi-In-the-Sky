class PiData < DataObject
  has_many :favorites, foreign_key: :pi_data_id
  has_many :users, through: :favorites
end
