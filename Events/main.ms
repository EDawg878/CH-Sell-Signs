bind(sign_changed, null, array(1: '/.*[SELL].*/'), @event,
	include('../config.ms')
	cancel()
	if(has_permission(@adminpermission) || pisop()) {
		assign(@array, array())
		assign(@id, @event['text'][2])
		assign(@array['type'], _parseType(@id))
		assign(@array['data'], _parseData(@id))
		assign(@array['amount'], @event['text'][1])
		assign(@array['price'], @event['text'][3])
		assign(@location, array(@event['location']['X'], @event['location']['Y'], @event['location']['Z'], @event['location']['world']))
		_signSetArray(@array, @location, 'enable')
	} else {
		_signDie('No permission')
	}
)
bind(player_interact, null, array(block:68), @event,
	if(_isSellShopEnabled(@event['location'])) {
		include('../config.ms')
		cancel()
		if(!has_permission(@adminpermission) && !has_permission(@usepermission) && !pisop()) {
			_signDie('No permission')
		}
		switch(@event['action']) {
			'right_click_block',
				_signInteractRight(@event['location']),
			'left_click_block',
				_signInteractLeft(@event['location'])
		}
	}
)
bind(player_interact, null, array(block:63), @event,
	if(_isSellShopEnabled(@event['location'])) {
		cancel()
		include('../config.ms')
		if(!has_permission(@adminpermission) && !has_permission(@usepermission) && !pisop()) {
			_signDie('No permission')
		}
		switch(@event['action']) {
			'right_click_block',
				_signInteractRight(@event['location']),
			'left_click_block',
				_signInteractLeft(@event['location'])
		}
	}
)
