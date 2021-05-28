class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    validates :name,  presence: true, uniqueness: true, length: {minimum: 2, maximum: 20 }
    validates :email, presence: true
    validates :introduction, length: {maximum: 50}

    has_many :books,    dependent: :destroy
    has_many :comments,  dependent: :destroy
    has_many :favorites, dependent: :destroy

    # フォローしてる側からみたルーティング
    has_many :active_relationships, class_name: "Relationship",
                                   foreign_key: "follower_id",
                                     dependent: :destroy
    # フォローしてる@user.followingでその人がフォローしてるユーザーを取得
    has_many :following, through: :active_relationships, source: :followed
    # フォローされてる側から見たルーティング
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                      dependent: :destroy
    #フォローされてる@user.followersでその人をフォローしてるユーザーを取得
    has_many :followers, through: :passive_relationships, source: :follower

    attachment :profile_image

    # 以下、便利メソッド
    #ユーザーをフォローする
    def follow(other_user)
      following << other_user
    end

    # ユーザーをフォロー解除する
    def unfollow(other_user)
      active_relationships.find_by(followed_id: other_user.id).destroy
    end

    # 現在のユーザーがフォローしてたらtrueを返す
    def following?(other_user)
      following.include?(other_user)
    end

end
