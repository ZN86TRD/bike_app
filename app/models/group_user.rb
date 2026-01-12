class GroupUser < ApplicationRecord
    belongs_to :user
    belongs_to :group

    #グループ参加可否('0'=申請中、'1'=承認)
    enum status: { pending: 0, approved: 1 }
end
