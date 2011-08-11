shared_examples_for "Guest account" do
  it 'should allow :read of all Articles' do
    user_account.should be_allowed_to(:read, article)
  end

  it 'should allow :read of all Posts' do
    user_account.should be_allowed_to(:read, post)
  end

  it 'should allow :read of all Comments' do
    user_account.should be_allowed_to(:read, comment)
  end
end

shared_examples_for "User account" do
  it_should_behave_like "Guest role" do
  end

  it 'should allow :management of own Articles' do
    user_account.should be_allowed_to(:manage, own_article)
  end

  it 'should allow :management of own Posts' do
    user_account.should be_allowed_to(:manage, own_post)
  end

  it 'should allow :management of own Comments' do
    user_account.should be_allowed_to(:manage, own_comment)
  end
end

shared_examples_for "Admin account" do
  it_should_behave_like "User account" do
  end

  it 'should allow :management of all Articles' do
    user_account.should be_allowed_to(:manage, article)
  end

  it 'should allow :management of all Posts' do
    user_account.should be_allowed_to(:manage, post)
  end

  it 'should allow :management of all Comments' do
    user_account.should be_allowed_to(:manage, comment)
  end
end
