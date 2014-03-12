require 'spec_helper'

describe User, '#can_delete_songs?' do
  it 'returns true if user is an admin' do
    admin_user = create(:user, admin: true)

    expect(admin_user.can_delete_songs?).to be_true
  end

  it 'returns false if user is not an admin' do
    non_admin_user = create :user

    expect(non_admin_user.can_delete_songs?).to be_false
  end
end

describe User, '#admin?' do
  it 'is explicitly false by default' do
    non_admin_user = create :user

    expect(non_admin_user.admin?).to be_false
    expect(non_admin_user.admin).not_to be_nil
  end
end
