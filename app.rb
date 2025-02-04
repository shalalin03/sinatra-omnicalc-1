require "sinatra"
require "sinatra/reloader"

helpers do
  def format_currency(value)
    "$#{'%.2f' % value}"
  end
end

get("/howdy") do
    erb(:hello)
end

get("/goodbye") do
  erb(:bye)
end

get("/square/new") do
  erb(:new_square_calc)
end

get("/square/results") do
  @the_num = params.fetch("user_number").to_f
  @the_result = @the_num ** 2
  erb(:square_results)
end

get("/square_root/results") do
  @the_num = params.fetch("user_number").to_f
  @the_result = Math.sqrt(@the_num)
  erb(:square_root_results)
end

get("/square_root/new") do
  erb(:new_square_root)
end

get("/square_root/results") do
  @the_num = params.fetch("user_number").to_f
  @the_result = Math.sqrt(@the_num)
  erb(:square_root_results)
end

get("/") do
  erb(:home)
end

get("/payment/new") do
  erb(:new_payment)
end

get("/payment/results") do
  @principal = params.fetch("principal", "0").to_f
  @apr = params.fetch("apr", "0").to_f
  @years = params.fetch("years", "0").to_i

  @monthly_rate = @apr / 100 / 12
  @months = @years * 12

  if @monthly_rate.zero?
    @monthly_payment = @months.zero? ? 0 : @principal / @months # Avoid division by zero
  else
    @monthly_payment = (@monthly_rate * @principal) / (1 - (1 + @monthly_rate)**-@months)
  end

  erb(:payment_results)
end

get("/random/new") do
  erb(:new_random)
end

get("/random/results") do
  @min = params.fetch("min").to_i
  @max = params.fetch("max").to_i

  if @min <= @max
    @random_number = rand(@min..@max)
  else
    @random_number = "Invalid range: Minimum must be less than or equal to Maximum"
  end

  erb(:random_results)
end
