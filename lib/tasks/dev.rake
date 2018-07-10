namespace :dev do
  task fake_user: :environment do
    User.destroy_all

    20.times do
      User.create!(
        name:  FFaker::Name.first_name,
        email: FFaker::Internet.unique.email,
        password: '12345678'
      )
    end
    puts 'have created fake users'
    puts "now you have #{User.count} users data"
  end

  task fake_posts: :environment do
    Post.destroy_all
    10.times do
      Post.create!(
        title: FFaker::Lorem.sentence,
        content: FFaker::Lorem.paragraph,
        user_id: User.all.sample.id
      )
    end
    puts 'have created fake posts'
    puts "now you have #{Post.count} posts data"
  end
end