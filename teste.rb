class Car
    @@color = Queue.new
    def initialize (teste = "Azul")
            @@color << teste
    end

    def get
        @@color.pop
    end
    def set(value)
        @@color << value 
    end

end

a = Car.new
a.set("verde")
p a.get
p a.get
p a.get





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