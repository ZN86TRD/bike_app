class Group < ApplicationRecord
    
    belongs_to :genre
    belongs_to :owner, class_name: 'User'
    has_many :group_users, dependent: :destroy
    has_many :users, through: :group_users

    validates :name, presence: true
    validates :description, presence: true
end
