class FollowRelationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :kids
end
