class Relationship < ApplicationRecord
  
  # フォローした人のidとUser.idを紐付ける
  belongs_to :follower, class_name: "User"
  # フォローされた人のidとUser.idを紐つける
  belongs_to :followed, class_name: "User"

end
