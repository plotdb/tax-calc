var Price;
Price = function(opt){
  opt == null && (opt = {});
  if (opt.price != null) {
    this.price = opt.price;
  } else if (opt.total != null) {
    this.total = opt.total;
  }
  return this;
};
Price.prototype = import$(Object.create(Object.prototype), {
  init: function(){
    if (this.price != null) {
      this.tax = Price.getTax(this.price);
      return this.total = this.tax + Math.round(this.price);
    } else if (this.total != null) {
      this.price = this.total * 100 / 105;
      return this.tax = Price.getTax(this.price);
    } else {
      return this.price = 0, this.tax = 0, this.total = 0, this;
    }
  },
  get: function(){
    this.init();
    return {
      tax: this.tax,
      total: this.total,
      price: Math.round(this.price)
    };
  }
});
Price.getTax = function(price){
  var tax;
  tax = price * 5;
  tax = Math.floor(tax / 100) + (tax % 100 >= 50 ? 1 : 0);
  return tax;
};
Price.from = function(opt){
  var p;
  opt == null && (opt = {});
  p = new Price(opt);
  return p.get();
};
module.exports = Price;
function import$(obj, src){
  var own = {}.hasOwnProperty;
  for (var key in src) if (own.call(src, key)) obj[key] = src[key];
  return obj;
}
