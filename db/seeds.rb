# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(
    email: 'admin@privatedermatology.com',
    password: 'admin123',
    password_confirmation: "admin123",
    full_name: 'Admin',
    gender: "Female",
    dob: '2022-08-01 00:00:00', 
    contact_no: '+63 123 456 7890',
    address: 'Cebu City, Cebu',
    admin: true,
)

admin.skip_confirmation!
admin.save

slot = Slot.create(
    availability: true,
    interaction: 0,
    date: Date.tomorrow,
    time: Time.now
)

patient = User.create(
    email: 'patient@privatedermatology.com',
    password: 'patient123',
    password_confirmation: "patient123",
    full_name: 'Patient User',
    gender: 'Female',
    dob: '2022-08-01 00:00:00', 
    contact_no: '+63 123 456 7890',
    address: 'Cebu City, Cebu',
    admin: false,
)

patient.skip_confirmation!
patient.save

patient2 = User.create(
    email: 'patient2@privatedermatology.com',
    password: 'patient123',
    password_confirmation: "patient123",
    full_name: 'Patient User',
    gender: 'Female',
    dob: '2022-08-01 00:00:00', 
    contact_no: '+63 123 456 7890',
    address: 'Cebu City, Cebu',
    admin: false,
)

patient2.skip_confirmation!
patient2.save

product1 = Product.create(
    product_name: "Acne cream",
    product_desc: "This product can heal your acne. Best for angsty teens.",
    price: 420,
    stocks: 69
)

product2 = Product.create(
    product_name: "Tortillos",
    product_desc: "Junk food, but glorious!",
    price: 32,
    stocks: 69
)

product1.product_image.attach(io: File.open('app/assets/images/acnecream.png'), filename: 'acnecream.png', content_type: 'image/png')
product2.product_image.attach(io: File.open('app/assets/images/acnecream.png'), filename: 'acnecream.png', content_type: 'image/png')

product1.save
product2.save