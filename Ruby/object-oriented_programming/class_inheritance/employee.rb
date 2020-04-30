class Employee
    attr_reader :name, :title, :salary
    def initialize(name, title, salary, boss)
        @name, @title, @salary, @boss = 
        name, title, salary, boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end

    def boss
        @boss.name
    end
end

# Manager inherits from Employee
class Manager < Employee
    attr_reader :sub_employees
    def initialize(name, title, salary, boss)
        # Manager is initialized the same way as Employee by using `super`
        super
        @sub_employees = []
    end

    def add_sub_employee(employee)
        @sub_employees << employee
    end

    # `bonus` method is overridden in Manager class
    def bonus(multiplier)
        sub_employee_salaries = @sub_employees.map do |emp|
            emp.salary
        end
        total_of_salaries = sub_employee_salaries.sum
        total_of_salaries * multiplier

    end
end

Ned = Manager.new("Ned", "Founder", 1000000, nil)
Darren = Manager.new("Darren", "TA Manager", 78000, Ned)
Shawna = Employee.new("Shawna", "TA", 12000, Darren)
David = Employee.new("David", "TA", 10000, Darren)

Ned.add_sub_employee(Darren)
Ned.add_sub_employee(Shawna)
Ned.add_sub_employee(David)

Darren.add_sub_employee(Shawna)
Darren.add_sub_employee(David)



puts Ned.bonus(5)
puts Darren.bonus(4)
puts David.bonus(3)