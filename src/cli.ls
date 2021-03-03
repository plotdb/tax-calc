require! <[fs path yargs]>

lib = path.dirname fs.realpathSync __filename

console.log lib
tax = require "#lib/tax"

argv = yargs
  .option \price, do
    alias: \p
    description: "price ( untaxed )"
    type: \number
  .option \total, do
    alias: \t
    description: "total amount (tax included)"
    type: \number

  .help \help
  .alias \help, \h
  .check (argv, options) ->
    if !(argv.price? or argv.total) => return new Error("need either price or total amount")
    return true
  .argv


price = argv.price
total = argv.total

ret = tax.from(if price => {price} else {total})
console.log "未  稅: #{ret.price} 元"
console.log "營業稅: #{ret.tax} 元"
console.log "含  稅: #{ret.total} 元"

