class Car
    @@color 
    def initialize (teste = "Azul")
            @@color = teste
    end

    def get
        @@color
    end
    def set(value)
        @@color = value
    end

end


class Bike
    attr_accessor :test
    def initialize(color)
        @@cars = Queue.new
        @@cars << color 
        @@cars << color 
        @@cars << color 
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

    def start
        while !@@cars.empty?
            puts "#{self.get.get} car #{@@cars.size}"
        end
    end
end

b = Car.new()
a = Bike.new(b)
b = Thread.new do
        c = Cars.new
        a.start
    end
puts "#{c.get} valor de c"
b.join






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