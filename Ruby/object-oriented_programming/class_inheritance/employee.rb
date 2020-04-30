require 'byebug'

class Employee
    attr_reader :name, :title, :salary
    def initialize(name, title, salary, boss)
        @name, @title, @salary = 
        name, title, salary
        self.boss = boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end

    def boss
        @boss.name
    end

    def boss=(boss)
        @boss = boss
        boss.add_sub_employee(self) unless boss.nil?
    end
end

# Manager inherits from Employee
class Manager < Employee
    attr_reader :sub_employees
    def initialize(name, title, salary, boss = nil)
        # Manager is initialized the same way as Employee by using `super`
        super
        @sub_employees = []
    end

    def add_sub_employee(employee)
        @sub_employees << employee
    end

    # `bonus` method is overridden in Manager class
    def bonus(multiplier)
        self.total_subsalary * multiplier
    end

    protected

    def total_subsalary
        total_subsalary = 0
        self.sub_employees.each do |employee|
            total_subsalary += employee.salary
            if employee.is_a?(Manager)                
                total_subsalary += employee.total_subsalary
            end
        end
        total_subsalary
    end
end

Ned = Manager.new("Ned", "Founder", 1000000, nil)
Darren = Manager.new("Darren", "TA Manager", 78000, Ned)
Shawna = Employee.new("Shawna", "TA", 12000, Darren)
David = Employee.new("David", "TA", 10000, Darren)




puts Ned.bonus(5)
puts Darren.bonus(4)
puts David.bonus(3)