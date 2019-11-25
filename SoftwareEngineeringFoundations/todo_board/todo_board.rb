require_relative './list.rb'

class TodoBoard

    def initialize
        # Each key is the List label, each value is the List instance.
        @lists = {}
    end

    def get_command
        print "Please enter a command: "
        cmd, list, *args = gets.chomp.split(" ")


        case cmd
        # mklist <List Name>
        when 'mklist'
            @lists[list] = List.new(list)
        # ls
        when 'ls'
            puts
            @lists.each_key do |label|
                puts label
            end
            puts
        # showall
        when 'showall'
            @lists.each_value do |list_inst|
                list_inst.print
            end

        # mktodo <List Name> <Todo title> <deadline YYYY-MM-DD> <optional note>
        when 'mktodo'
            @lists[list].add_item(*args)
        # up <List Name> <index of item> <optional amt of times to move>
        when 'up'
            args.map!(&:to_i)
            @lists[list].up(*args)
        # down <List name> <index of item> <optional amt of times to move>
        when 'down'
            args.map!(&:to_i)
            @lists[list].down(*args)
        # swap <List name> <index of item 1> <index of item 2>
        when 'swap'
            args.map!(&:to_i)
            @lists[list].swap(*args)
        # sort <List Name>
        when 'sort'
            @lists[list].sort_by_date!
        # priority <List Name>
        when 'priority'
            @lists[list].print_priority
        # print <List Name> <optional index>
        when 'print'
            if args.empty?
                @lists[list].print
            else
                args.map!(&:to_i)
                @lists[list].print_full_item(*args)
            end
        # toggle <List Name> <item index>
        when 'toggle'
            args.map!(&:to_i)
            @lists[list].toggle_item(*args)
        # rm <List Name> <item_index>
        when 'rm'
            args.map!(&:to_i)
            @lists[list].remove_item(*args)
        # purge
        when 'purge'
            @lists[list].purge
        # quit
        when 'quit'
            return false
        else
            puts "Sorry, that is not a command. Valid commands are: "
            puts "'mklist' 'ls' 'showall' 'mktodo' 'up' 'down' 'swap' 'sort' 'priority' 'print' 'toggle' 'rm' 'quit'"
        end
        true            
    end

    def run
        running = true
        while running
            running = self.get_command
        end
    end
end

board = TodoBoard.new

board.run