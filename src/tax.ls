Price = (opt = {}) ->
  if opt.price? => @price = opt.price
  else if opt.total? => @total = opt.total
  @

Price.prototype = Object.create(Object.prototype) <<< do
  init: ->
    if @price? =>
      @tax = Price.get-tax(@price)
      @total = @tax + Math.round(@price)
    else if @total? =>
      @price = @total * 100 / 105
      @tax = Price.get-tax(@price)
    else @ <<< {price: 0, tax: 0, total: 0}
  get: -> @init!; return {tax: @tax, total: @total, price: Math.round(@price)}

Price.get-tax = (price) ->
  tax = price * 5
  tax = Math.floor(tax / 100) + (if (tax % 100) >= 50 => 1 else 0)
  return tax
Price.from = (opt = {}) -> 
  p = new Price(opt)
  return p.get!

module.exports = Price
