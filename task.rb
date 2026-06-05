require 'json'
db_path = "db"
options = {
  0 => "- exit",
	1 => "- List books",
	2 => "- Add new book",
	3 => "- Remove book by ISBN",
	4 => "- Sort Using ISBN",
	5 => "- Search",
}

option = -1
books = JSON.parse(File.read(db_path))

class Book
  attr_accessor :title, :author, :isbn
  def initialize(title, author, isbn)
    @title = title
    @author = author
    @isbn = isbn
  end
  def to_h
    {'title' => @title, 'author' => @author, 'ISBN' => @isbn}
  end
end

def add_new_book (books, db_path)
  puts "Adding a New Book"
  print("Type the title: ")
  title = gets
  print("Type the author: ")
  author = gets
  print("Type the ISBN: ")
  isbn = gets
  isbn = isbn.to_i
  new_book = Book.new(title.strip, author.strip, isbn)
  books.append(new_book.to_h)
  File.write(db_path, JSON.generate(books))
  print "\n------------Book #{new_book.to_h['title']} Saved-------------\n"
end

def list_books (books)
  books.each do |book|
    print ("* Book: #{book['title']}, Written By: #{book['author']}, With ISBN: #{book['ISBN']}\n")
  end
  print "\n------------End Of List-------------\n"
end

def remove_by_isbn (books, db_path)
  print("Type the ISBN: ")
  isbn = gets.to_i
  books.filter! {|book| !book['ISBN'].eql?(isbn)}
  File.write(db_path, JSON.generate(books))
  print "\n------------Done-------------\n"

end

# BONUS
def sort_by_isbn (books, db_path)
  books.sort! do |x, y|
    x['ISBN'] <=> y['ISBN']
  end
  File.write(db_path, JSON.generate(books))
  print "\n------------Sorting Done-------------\n"
end

# BONUS
def search_books (books)
  print "Enter The Searching key: "
  search_by = gets
  search_books = books.filter {|book| (book['ISBN'].eql?(search_by.to_i) ||book['title'].include?(search_by.strip) ||  book['author'].include?(search_by.strip))}

  list_books search_books
  print "\n------------Searching Done-------------\n"
end

while !option.to_i.eql?(0)
puts "Choose Option"
options.each do |k, v|
  puts "#{k} => #{v}"
end
option = gets

case option.to_i
when 1
  puts "------------------------------------"
  list_books books
when 2
  puts "------------------------------------"
  add_new_book books, db_path
when 3
  puts "------------------------------------"
  remove_by_isbn books, db_path
when 4
  puts "------------------------------------"
  sort_by_isbn books, db_path
when 5
  puts "------------------------------------"
  search_books books
when 0
  puts "------------------------------------"
  print "Good Bye\n"
else
  "Invalid Option"
end

end
