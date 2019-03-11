import requests

from .config_param import config_param


def construct_endpoint_url(endpoint):
	return '{0}/{1}/{2}/{3}'.format(get_bluebird_url(), config_param('api_path'), config_param('api_version'), endpoint)


def get_bluebird_url():
	return 'http://{}:{}'.format(config_param('host'), config_param('port'))


def ping_bluebird():
	endpoint = config_param('endpoint_aircraft_position')

	url = construct_endpoint_url(endpoint)
	print('ping bluebird on {}'.format(url))

	# /pos endpoint only supports GET requests, this should return an error if BlueBird is running
	# on the specified host
	try:
		resp = requests.post(url)
	except requests.exceptions.ConnectionError as e:
		print(e)
		return False

	if resp.status_code == 405:
		return True
	return False


def _check_latitude(lat):
	return abs(lat) <= 90


def _check_longitude(lon):
	return -180 <= lon < 180


def _check_heading(hdg):
	return 0 <= hdg < 360


def _check_speed(spd):
	return spd >= 0


def _check_string_input(input):
    """Check that input is a non-empty string"""
    if type(input) == str:
        return len(input) >= 1
    return False


def _check_altitude(alt):
	return 0 <= alt <= config_param('feet_altitude_upper_limit')


def _check_flight_level(fl):
	return fl >= config_param('flight_level_lower_limit')


def parse_alt(alt, fl):
	if alt is not None:
		assert _check_altitude(alt), 'Invalid value {} for altitude'.format(alt)
		alt = str(alt)
	else:
		assert fl is not None, 'Must specify a valid altitude or a flight level'
		assert _check_flight_level(fl), 'Invalid value {} for flight_level'.format(fl)
		alt = "FL{}".format(fl)
	return alt


def _check_id_list(aircraft_id):
    return bool(aircraft_id) and all(isinstance(elem, str) and len(elem) >= 1 for elem in aircraft_id)
