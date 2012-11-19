proc(_signGetAmount, @location,
	assign(@line2, get_sign_text(@location)[1])
	return(parse_args(@line2)[1])
)
proc(_signGetPrice, @location,
	assign(@line4, get_sign_text(@location)[3])
	return(parse_args(@line4)[0])
)
proc(_signGetData, @location,
	assign(@line3, get_sign_text(@location)[2])
	assign(@id, parse_args(@line3)[1])
	return(_parseData(@id))
)
proc(_signGetType, @location,
	assign(@line3, get_sign_text(@location)[2])
	assign(@id, parse_args(@line3)[1])
	return(_parseType(@id))
)
proc(_signGetArray, @location,
	assign(@array, array())
	assign(@array['amount'], _signGetAmount(@location))
	assign(@array['type'], _signGetType(@location))
	assign(@array['data'], _signGetData(@location))
	assign(@array['price'], _signGetPrice(@location))
	return(@array)
)
proc(_signSetArray, @array, @location, @toggle,
	assign(@amount, @array['amount'])
	assign(@id, concat(@array['type'], ':', @array['data']))
	if(is_null(data_name(@id))) { _signDie(@id 'is not a valid ID') }
	assign(@price, @array['price'])
	if(@toggle == 'enable') {
		_signSetText(@amount, @id, @price, @location, 'enable')
	} else if(@toggle == 'disable') {
		_signSetText(@amount, @id, @price, @location, 'disable')
	}
)
proc(_signModify, @type, @value, @location,
	assign(@array, _signGetArray(@location))
	assign(@array[@type], @value)
	_signSetArray(@array, @location, _signStatus(@location))
)
proc(_signSetText, @amount, @id, @price, @location, @toggle,
	include('../config.ms')
	if(@price > 1) {
		assign(@currency, @pluralcurrency)
	} else if(@price == 1) {
		assign(@currency, @singularcurrency)
	}
	if(@toggle == 'enable') {
		assign(@line1, @prefixenabled)
	} else if(@toggle == 'disable') {
		assign(@line1, @prefixdisabled)
	}
	assign(@line2, 'QTY:' @amount)
	assign(@line3, 'ID:' @id)
	assign(@line4, @price @currency)
	assign(@text, array(@line1, @line2, @line3, @line4))
	foreach(@text, @line) {
		if(length(@line) > 15) {
			_signDie('Line' array_index(@text, @line) + 1 'exceeds 15 characters')
		}
	}
	set_sign_text(@location, @text)
)
