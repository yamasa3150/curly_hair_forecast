class User < ApplicationRecord
  has_one :push_setting

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture

end
