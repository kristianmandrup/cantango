shared_examples_for "Guest role" do

  it 'should allow :read of all Articles' do
    user.should be_allowed_to(:read, Article)
  end

  it 'should allow :read of all Posts' do
    user.should be_allowed_to(:read, Post)
  end

  it 'should allow :read of all Comments' do
    user.should be_allowed_to(:read, Comment)
  end
end

shared_examples_for "User role" do
  it_should_behave_like "Guest role" do
  end

  it 'should allow :management of own Articles' do
    user.should be_allowed_to(:manage, own_article)
  end

  it 'should allow :management of own Posts' do
    user.should be_allowed_to(:manage, own_post)
  end

  it 'should allow :management of own Comments' do
    user.should be_allowed_to(:manage, own_comment)
  end

  it 'should not allow :management not-own Articles' do
    user.should_not be_allowed_to(:manage, Article.create!)
  end

  it 'should allow :write of not-own Articles' do
    user.should be_allowed_to(:write, Article.create!)
  end
end

shared_examples_for "Editor role" do
  it_should_behave_like "Guest role" do
  end

  it 'should allow :write of Comments' do
    user.should be_allowed_to(:write, Comment)
  end

  it 'should allow :write of Article' do
    user.should be_allowed_to(:write, Article)
  end

  it 'should allow :write of Post' do
    user.should be_allowed_to(:write, Post)
  end
end


shared_examples_for "User + Editor roles" do
  it_should_behave_like "User role" do
  end

  it_should_behave_like "Editor role" do
  end
end

shared_examples_for "Admin role" do

  it 'should allow :management of everything' do
    user.should be_allowed_to(:manage, :all)
  end

  it 'should allow :management of all Articles' do
    user.should be_allowed_to(:manage, Article)
  end

  it 'should allow :management of all Posts' do
    user.should be_allowed_to(:manage, Post)
  end

  it 'should allow :management of all Comments' do
    user.should be_allowed_to(:manage, Comment)
  end
end

