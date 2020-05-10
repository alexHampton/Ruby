class Robot
    attr_accessor :equipped_weapon
    attr_reader :position, :items, :items_weight, :health
    def initialize
        @position = [0,0]
        @items = []
        @items_weight = 0
        @health = 100
        @equipped_weapon = nil
    end

    def move_left
        x, y = @position
        @position = [x-1, y]
    end

    def move_right
        x, y = @position
        @position = [x+1, y]
    end

    def move_up
        x, y = @position
        @position = [x, y+1]
    end

    def move_down
        x, y = @position
        @position = [x, y-1]
    end

    def pick_up(item)
        raise ArgumentError if @items_weight + item.weight > 250
        @items << item
        @items_weight += item.weight
        
    end

    def wound(dmg)
        @health -= dmg
        @health = 0 if @health < 0
    end

    def heal(amt)
        @health += amt
        @health = 100 if @health > 100
    end

    def attack(enemy)
        if @equipped_weapon.nil?
            enemy.wound(5)
        else
            @equipped_weapon.hit(enemy)
        end
    end


end

class Item
    attr_reader :name, :weight
    def initialize(name, weight)
        @name = name
        @weight = weight
    end

end

class Bolts < Item
    def initialize
        super(name = 'bolts', weight = 25)
    end

    def feed(robot)
        robot.heal(25)
    end

end

class Weapon < Item
    attr_reader :damage
    def initialize(name, weight, damage)
        super(name, weight)
        @damage = damage
    end

    def hit(robot)
        robot.wound(@damage)
    end

end

class Laser < Weapon
    def initialize
        super(name = 'laser', weight = 125, damage = 25)
    end

end

class PlasmaCannon < Weapon
    def initialize
        super(name = 'plasma_cannon', weight = 200, damage = 55)
    end
end