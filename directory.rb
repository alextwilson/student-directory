@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while true do
    if name.empty?
      break
    end
    puts "Please enter the cohort of the student"
    cohort = gets.chomp
    if cohort == ""
      cohort = "november"
    end
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  @students = students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

def print_begins_with
  puts "Which letter do you want to show names beginning with?"
  letter = gets.chomp
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

def interactive_menu
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      input_students
    when "2"
      print_header
      print(@students)
      print_footer(@students)
    when "9"
      exit
    else
      puts "I don't know what you meant, try another option"
    end
  end
end

interactive_menu

