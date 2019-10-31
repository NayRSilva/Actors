class Car
    @@color 
    def initialize (teste = "Azul")
            @@color = teste
    end

    def get
        self.set('red')
    end
    def set(value)
        @@color = value
    end

end


class Bike
    attr_accessor :test
    def initialize(color)
        @@color = color
        @@cars = Queue.new
        @@cars << self
    end

    def get
        @test = 'azul'
        @@cars.pop
    end
    def printf 
        puts "entrou aqui"
    end

    def getColor
        @@color
    end
end

a = Bike.new("verde")
puts a.get.test



a = {'a' => 10, 'b' => 11, 'c' => 14}
h = a.sort_by{|k,v| v}.reverse.to_h

puts h


# unless a.include? 'd'
#     a['d'] = 15 
#     puts a['d']
# end

# a=0
# puts a += 1 


# queue = Queue.new
# 3.times do |i|
#     queue << i
# end

# 3.times do |i|
#     print "size:  #{queue.size} element: "
#     print queue.pop; 
#     print "size:  #{queue.size}"
#     puts
# end