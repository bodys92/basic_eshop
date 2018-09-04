### Users
User.create!(name: "Example User",
            email: "example@server.com",
            password: "password",
            password_confirmation: "password",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |id|
    name = Faker::Name.name
    email = "example-#{id+1}@server.com"
    password = "password"
    User.create!(name: name,
                email: email,
                password: password,
                password_confirmation: password,
                activated: true,
                activated_at: Time.zone.now)
end

### Microposts
users = User.order(:created_at).take(6)

50.times do
    content = Faker::Lorem.sentence(5)
    users.each do |user|
        user.microposts.create!(content: content)
    end
end

### Following relationship
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed)}
followers.each { |follower| follower.follow(user)}

### Categories 
Category.create!(title: "Obývací pokoj",
                url: "obyvaci-pokoj",
                order_no: 1,
                hidden: false,
                category_id: nil)

array = (2..10).to_a.shuffle.to_a

9.times do |i|
    title = Faker::Commerce.unique.department(1)
    url = title.downcase
    order_no = array[i-1]
    hidden = false

    Category.create!(title: title, 
                    url: url,
                    order_no: order_no, 
                    hidden: hidden, 
                    category_id: nil)
end

### Products
200.times do
    code = Faker::Commerce.promotion_code
    title = Faker::Commerce.product_name
    url = title.downcase.split.join("-")
    short_description = Faker::Lorem.sentence(4)
    description = Faker::Lorem.sentence(20)
    price = Faker::Commerce.price(range = 0..100.00)
    ratings = rand(5..10)
    r = 0
        ratings.times do
            r = r + rand(1..5)
        end
    stock = rand(0..30)
    images_count = rand(0..5)
    hidden = [true, false].sample

    Product.create!(code: code, 
        url: url,
        title: title, 
        short_description: short_description, 
        description: description,
        price: price, 
        old_price: price + 10, 
        ratings: ratings, 
        rating_sum: r, 
        stock: stock, 
        images_count: images_count, 
        hidden: hidden)
end

### ProductCategory
50.times do
    p = Product.all.sample[:id]
    c = Category.all.sample[:id]
    query = ProductCategory.new(product_id: p,
                            category_id: c)
    all = ProductCategory.all
    unless all.empty?
        all.each do |i|
            unless i[:product_id] == query[:product_id] && i[:category_id] == query[:category_id] 
                query.save
            end
        end
    end
    query.save
end



