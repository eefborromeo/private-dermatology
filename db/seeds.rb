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