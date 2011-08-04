puts "Create musician and composer users"
musician = User.create! :name => 'musician', :role_groups => 'musicians', :email => 'musician@mail.ru', :password => 'secret123'
composer = Admin.create! :name => 'composer', :role_groups => 'composers', :email => 'stanislaw@mail.ru', :password => 'admin123'


