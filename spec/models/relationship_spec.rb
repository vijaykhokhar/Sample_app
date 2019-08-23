require 'rails_helper'

describe Relationship do

  let(:follower) { create(:user) }
  let(:followed) { create(:user) }
  let(:relationship) { follower.passive_relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { should be_valid }
end