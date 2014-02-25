# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "fileutils"

u = User.new
u.email = 'admin@muni.cz'
u.password = '123456'
u.password_confirmation = '123456'
u.admin = true
u.uco = 111111
u.save


t = Task.new
t.name = 'Calculator'
t.description = 'create a calculator'
t.language = 'java'
t.package = 'calculator'
t.user_id = u.id
t.task_file = File.open('examples/tests/CalculatorTest.java')
t.save

new_file_path = File.join(ENV['OPENSHIFT_DATA_DIR'] ||= Rails.root, "homework/src/tests", t.package, t.task_file_file_name)
FileUtils.mkdir_p(File.dirname(new_file_path))
FileUtils.cp t.task_file.path, new_file_path

t = Task.new
t.name = 'Geometry'
t.description = 'create a geometry class'
t.language = 'java'
t.package = 'geometry'
t.user_id = u.id
t.task_file = File.open('examples/tests/GeometryTest.java')
t.save

new_file_path = File.join(ENV['OPENSHIFT_DATA_DIR'] ||= Rails.root, "homework/src/tests", t.package, t.task_file_file_name)
FileUtils.mkdir_p(File.dirname(new_file_path))
FileUtils.cp t.task_file.path, new_file_path

t = Task.new
t.name = 'Products'
t.description = 'Create xslt, that transforms xml into html page. Homework will be manualy checked by teacher'
t.language = 'xslt'
t.package = 'products'
t.user_id = u.id
t.task_file = File.open('examples/tests/products.xml')
t.save

new_file_path = File.join(ENV['OPENSHIFT_DATA_DIR'] ||= Rails.root, "homework/src/tests", t.package, t.task_file_file_name)
FileUtils.mkdir_p(File.dirname(new_file_path))
FileUtils.cp t.task_file.path, new_file_path

t = Task.new
t.name = 'Books'
t.description = 'Create xquery, that transforms xml. Homework will be manualy checked by teacher'
t.language = 'xquery'
t.package = 'books'
t.user_id = u.id
t.task_file = File.open('examples/tests/books.xml')
t.save

new_file_path = File.join(ENV['OPENSHIFT_DATA_DIR'] ||= Rails.root, "homework/src/tests", t.package, t.task_file_file_name)
FileUtils.mkdir_p(File.dirname(new_file_path))
FileUtils.cp t.task_file.path, new_file_path