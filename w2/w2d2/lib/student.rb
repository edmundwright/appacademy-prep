class Student
  attr_reader :first_name, :last_name, :courses

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
    @courses = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def enroll(new_course)
    return if courses.include?(new_course)

    courses.each do |existing_course|
      raise "Conflict!" if new_course.conflicts_with?(existing_course)
    end

    courses << new_course
    new_course.students << self
  end

  def course_load
    to_return = {}

    courses.each do |course|
      to_return[course.department] = 0 unless to_return.include?(course.department)
      to_return[course.department] += course.credits
    end

    to_return
  end
end
