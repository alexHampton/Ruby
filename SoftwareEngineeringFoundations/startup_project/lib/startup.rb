require "byebug"
require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(another_startup)
        self.funding > another_startup.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            name = Employee.new(employee_name, title)
            @employees << name
        else
            raise "That title doesn't exist. Employee was not added."
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        pay = @salaries[employee.title]
        if @funding >= pay
            employee.pay(pay)
            @funding -= pay
        else
            raise "Insufficient funds. #{employee.name} was not paid."
        end
    end

    def payday
        @employees.each do |emp|
            self.pay_employee(emp)
        end
    end

    def average_salary
        sum = 0
        @employees.each { |emp| sum += @salaries[emp.title] }
        (sum * 1.0) / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(other_startup)
        # add funding
        @funding += other_startup.funding
        # merging salaries
        other_startup.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.has_key?(title)
        end
        # hire employees
        @employees += other_startup.employees
        # This code didn't work because the object id's changed.
        # other_startup.employees.each { |emp| self.hire(emp.name, emp.title)}
        other_startup.close
    end


end
