class Customer
    @@no_of_customers = 0
    def initialize(id, name)
        @id=id
        @name=name
    end

    def hello
        @id=@id+1
        puts "Hello Ruby! #@id"
     end
end

c1= Customer.new(1,"zxk")
c2= Customer.new(2,"zhuxin")

c1.hello
c2.hello
c1.id=22