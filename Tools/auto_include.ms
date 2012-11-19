proc(_isSellShopEnabled, @location,
	include('../config.ms')
	if(!is_sign_at(@location)) { return(false) }
	assign(@line1, get_sign_text(@location)[0])
	return(@line1 == @prefixenabled)
)
proc(_isSellShopDisabled, @location,
	include('../config.ms')
	if(!is_sign_at(@location)) { return(false) }
	assign(@line1, get_sign_text(@location)[0])
	return(@line1 == @prefixdisabled)
)
proc(_isSellShop, @location,
	if(!is_sign_at(@location)) { return(false) }
	return(_isSellShopEnabled(@location) || _isSellShopDisabled(@location))
)
proc(_signStatus, @location,
	include('../config.ms')
	assign(@line1, get_sign_text(@location)[0])
	if(@line1 == @prefixenabled) { return('enable') }
	if(@line1 == @prefixdisabled) { return('disable') }
)
proc(_parseType, @id,
	if(reg_count(':', @id) == 0) {
		assign(@type, @id)
	} else {
		assign(@type, split(':', @id)[0])
	}
	return(@type)
)
proc(_parseData, @id,
	if(reg_count(':', @id) == 0) {
		assign(@data, 0)
	} else {
		assign(@data, split(':', @id)[1])
	}
	return(@data)
)
