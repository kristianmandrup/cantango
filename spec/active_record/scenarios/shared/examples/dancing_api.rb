include Dancing::User
shared_examples_for 'Dancing API: user' do
  
  describe '#user_ability' do
    it 'should work' do
      user_ability(user).can? :read, Comment
    end
  end

  describe '#user_can?' do
    it 'should work' do
      user_can?(user, :read, Comment) 
    end
  end

  describe '#guest_can?' do
    it 'should work' do
      guest_can? :read, Comment
    end
  end

  describe '#user_account_scope' do
    it 'should work' do
      user_scope :guest do |user|
        user.can? :read, Comment
      end
    end
  end    
end

shared_examples_for 'Dancing API: user account' do
  describe '#user_ability' do
    it 'should work' do
      user_ability(user_account).can? :read, Comment
    end
  end

  describe '#user_can?' do
    it 'should work' do
      user_account_can?(user_account, :read, Comment) 
    end
  end

  describe '#guest_account_can?' do
    it 'should work' do
      guest_account_can? :read, Comment
    end
  end

  describe '#user_account_scope' do
    it 'should work' do
      user_account_scope :guest do |account|
        account.can? :read, Comment
      end
    end
  end  
end


