require "csv"

@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Show students whose names begin with a certain letter"
  puts "4. Show students with short names only"
  puts "5. Save the list of students"
  puts "6. Load a list of students"
  puts "7. View source code"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    print_begins_with
  when "4"
    print_short_names
  when "5"
    puts "What would you like to call this file?"
    filename = STDIN.gets.chomp
    save_students(filename)
  when "6"
    puts "What file would you like to load?"
    filename = STDIN.gets.chomp
    load_students(filename)
  when "7"
    view_source_code
  when "9"
    exit
  else
    puts "I don't know what you meant, try another option"
  end
end

def populate_students(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while true do
    if name.empty?
      break
    end
    puts "Please enter the cohort of the student"
    cohort = STDIN.gets.chomp
    if cohort == ""
      cohort = "november"
    end
    populate_students(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  @students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def print_begins_with
  puts "Which letter do you want to show names beginning with?"
  letter = STDIN.gets.chomp
  puts "Here are the students whose names begin with #{letter.upcase}:"
  @students.each do |student|
    if student[:name].slice(0).upcase == letter.upcase
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_short_names
  puts "Here are the students with short names:"
  @students.each do |student|
    if student[:name].length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def save_students(filename)
  CSV.open(filename, "w") do |row|
    @students.each { |student| row << [student[:name], student[:cohort]] }
  end
  puts "Students saved to #{filename}"
end

def load_students(filename)
  CSV.foreach(filename) { |name, cohort| populate_students(name, cohort) }
  puts "Students loaded from #{filename}"
end

def try_load_students
  filename = ARGV.first
  if filename.nil?
    if File.exists?("students.csv")
      load_students("students.csv")
      return
    else
      return
    end
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def view_source_code
  File.open(__FILE__).each do |line|
    puts line
  end
  puts "\n"
end

try_load_students
interactive_menu
