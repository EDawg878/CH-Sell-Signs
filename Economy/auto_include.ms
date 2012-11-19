proc(_signInteractRight, @location,
	include('../config.ms')
	assign(@array, _signGetArray(@location))
	assign(@ratio, @array['price'] / @array['amount'])
	assign(@id, concat(@array['type'], ':', @array['data']))
	if(@array['price'] == 1) {
		assign(@currency, @singularcurrency)
	} else {
		assign(@currency, @pluralcurrency)
	}
	if(phas_item(@id)) {
		assign(@inv, phas_item(@id))
	} else {
		assign(@inv, 0)
	}
	_signMsg('Sell' @array['amount'] data_name(@id) 'for' @array['price'] @currency.'?')
	_signMsg('Rate:' @ratio @currency 'per' data_name(@id))
	if(@inv == 1) {
		assign(@currency, @singularcurrency)
	} else {
		assign(@currency, @pluralcurrency)
	}
	_signMsg('You have' @inv data_name(@id) 'in your inventory worth' @inv * @ratio @currency)
	_signMsg('Left Click Sign to Proceed')
)
proc(_signInteractLeft, @location,
	include('../config.ms')
	assign(@array, _signGetArray(@location))
	if(@array['price'] > 1) {
		assign(@currency, @pluralcurrency)
	} else if(@array['price'] == 1) {
		assign(@currency, @singularcurrency)
	}
	assign(@id, concat(@array['type'], ':', @array['data']))
	if(!phas_item(@id)) { _signDie('You do not have any' data_name(@id) 'to sell') }
	assign(@inv, phas_item(@id))
	if(@inv < @array['amount']) { _signDie('You need' @array['amount'] - @inv 'more' data_name(@id)) }
	try(acc_add(player(), @array['price']), @exception, _signDie('Economy plugin is not hooked into Vault'))
	ptake_item(@id, @array['amount'])
	_signMsg('You sold' @array['amount'] data_name(@id) 'for' @price @currency)
	assign(@balance, acc_balance(player()))
	if(@balance == 1) {
		assign(@currency, @singularcurrency)
	} else {
		assign(@currency, @pluralcurrency)
	}
	assign(@inv, phas_item(@id))
	_signMsg('Your balance is now' acc_balance(player()) @currency)
	_signMsg('You have' @inv data_name(@id) 'left')
)
