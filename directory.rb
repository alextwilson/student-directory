def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  students
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

@students = input_students
print_header
print(@students)
print_footer(@students)
print_begins_with

