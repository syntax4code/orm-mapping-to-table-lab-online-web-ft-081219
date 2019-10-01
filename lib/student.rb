class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize (name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end
  def self.create_table
      sql = <<-SQL
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY,
          name TEXT,
          grade INTEGER
          )
      SQL
        DB[:conn].execute(sql)
    end


    def self.drop_table
      sql = <<-SQL
        DROP TABLE students
      SQL

      DB[:conn].execute(sql)
    end


  def self.count_all_students_in_grade_9
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = 9
      SQL

      DB[:conn].execute(sql).map do |row|
        self.new_from_db(row)
      end
  end

  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade IS NOT 12
      SQL

      DB[:conn].execute(sql).map do |row|
        self.new_from_db(row)
      end
  end

  def self.first_x_students_in_grade_10(num)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = 10
      LIMIT ?
      SQL

      DB[:conn].execute(sql, num).map do |row|
        self.new_from_db(row)
      end
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = 10
      LIMIT 1
      SQL

      DB[:conn].execute(sql).map do |row|
        self.new_from_db(row)
      end.first
  end

  def self.all_students_in_grade_x(grade)
    sql = <<-SQL
      SELECT * FROM students
      WHERE grade = ?
      SQL

      DB[:conn].execute(sql, grade).map do |row|
        self.new_from_db(row)
      end
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
