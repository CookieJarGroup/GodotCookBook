# * Php mysql connector - PMSC PLUGIN to server connections with godot
# * revised version on 30/11/2017 | date of next version 01/01/2018
# * written by jonas wesley, Version 1.7
# * 
# * "Everything can connect, everything can be connected."
# * 
# * Copyright (C) 2017  Lights On
# *
# * This program is free software; you can redistribute it and/or modify
# * it under the terms of the GNU General Public License as published by
# * the Free Software Foundation; either version 2 of the License or other latest 
# * version.
# *
# * This program is distributed in the hope that it will be useful,
# * but WITHOUT ANY WARRANTY; without even the implied warranty of
# * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# * GNU General Public License for more details.


tool
extends Node

const POST = "post"
const GET = "get"
const DELAY = 100

var _host
var _dbusername
var _dbusepass
var _dbname
var _connection_method
var _httpcl
var _opt = "direct_query"
var is_connected = false
var debug = false
var server_path = "/front-pmsc-api.php"

func _init():
	print("PMSConnector ON Version 1.7")

func pmsc_connect(host, dbusername, dbuserpass, dbname, connection_method):
	if (connection_method==POST):
		var err=0
		var http = HTTPClient.new() 
		err = http.connect(host,80)
		assert(err==OK)
		while(http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING):
			http.poll()
			print("requesting...")
			OS.delay_msec(DELAY)

		assert(http.get_status()==HTTPClient.STATUS_CONNECTED)
		if(http.get_status()==HTTPClient.STATUS_CONNECTED):
			print("connected.")
			is_connected = true
			_httpcl = http
		else:
			print("error, not connected.")
			is_connected = false
			pass
		pass
	elif (connection_method==GET):
		var err=0
		var http = HTTPClient.new() 
		err = http.connect(host,80)
		assert(err==OK)
		while(http.get_status()==HTTPClient.STATUS_CONNECTING or http.get_status()==HTTPClient.STATUS_RESOLVING):
			http.poll()
			print("requesting...")
			OS.delay_msec(DELAY)

		assert(http.get_status()==HTTPClient.STATUS_CONNECTED)
		if(http.get_status()==HTTPClient.STATUS_CONNECTED):
			print("connected.")
			is_connected = true
			_httpcl = http
		else:
			print("error, not connected.")
			is_connected = false
			pass
		pass

	if (is_connected):
		_host = host
		_dbusername = dbusername
		_dbusepass = dbuserpass
		_dbname = dbname
		_connection_method = connection_method
		return _httpcl
	else:
		print("pmscon_connect_error")

func pmsc_query(query):
	if(is_connected):
		if(_connection_method==POST):
			var fields = {"query" : "" + query, "opt" : "" + _opt, "dbusername" : ""+ _dbusername, "dbname": ""+ _dbname, "dbuserpass": ""+ _dbusepass}
			var queryString = _httpcl.query_string_from_dict(fields)
			var headers = ["Content-Type: application/x-www-form-urlencoded", "Content-Length: " + str(queryString.length())]
			var conn = _httpcl.request(HTTPClient.METHOD_POST,server_path,headers,queryString)
			assert(conn == OK)
			while(_httpcl.get_status()==HTTPClient.STATUS_REQUESTING):
				_httpcl.poll()
				print("pmsc_query_requesting...")
				OS.delay_msec(DELAY)
				pass
			if debug:
				print("response? ", _httpcl.has_response())
			if(_httpcl.has_response()):
				var headers_server = _httpcl.get_response_headers_as_dictionary()
				if debug:
					print("codes: ", _httpcl.get_response_code())
					print("headers-server: ", headers_server)
					if(_httpcl.is_response_chunked()):
						print("response is...")
					else:
						var bl = _httpcl.get_response_body_length()
						print("response-lenght: ",bl)
						pass
				var rb = RawArray()
				while(_httpcl.get_status() == HTTPClient.STATUS_BODY):
					_httpcl.poll()
					var chunk = _httpcl.read_response_body_chunk()
					if(chunk.size()==0):
						OS.delay_msec(DELAY)
					else:
						rb = rb + chunk
						pass
					pass
				if debug:
					print("Bytes got: ", rb.size())
				var text = rb.get_string_from_ascii()
				if text == null:
					text = "{\"consult\": { \"rows\": \"0\"}}"
					print("Foi por pouco!")
				if debug:
					print(text)
				var dic = Dictionary()
				dic.parse_json(text)
				return dic
				pass

		elif (_connection_method==GET):
			var fields = {"query" : ""+query, "opt" : "" + _opt, "dbuserpass" : "" + _dbusepass, "dbusername" : "" + _dbusername, "dbname" : "" + _dbname}
			var queryString = _httpcl.query_string_from_dict(fields)
			print("fields: ", str(fields))
			var headers=[
			"User-Agent: Pirulo/1.0 (Godot)",
			"Accept:*/*"
			]
			var URL = ""+ server_path + "?" + str(queryString)
			var conn = _httpcl.request(HTTPClient.METHOD_GET,URL,headers)
			assert(conn == OK)
			while(_httpcl.get_status()==HTTPClient.STATUS_REQUESTING):
				_httpcl.poll()
				print("pmsc_query_requesting...")
				OS.delay_msec(DELAY)
				pass
			assert( _httpcl.get_status()==HTTPClient.STATUS_BODY or _httpcl.get_status()==HTTPClient.STATUS_CONNECTED)
			if debug:
				print("response? ", _httpcl.has_response())
			if(_httpcl.has_response()):
				var headers_server = _httpcl.get_response_headers_as_dictionary()
				if debug:
					print("codes: ", _httpcl.get_response_code())
					print("headers-serve: ", headers_server)
				if(_httpcl.is_response_chunked()):
					if debug:
						print("response is chunked")
				else:
					var bl = _httpcl.get_response_body_length()
					if debug:
						print("response-lenght: ",bl)
					pass
				var rb = RawArray()
				while(_httpcl.get_status() == HTTPClient.STATUS_BODY):
					_httpcl.poll()
					var chunk = _httpcl.read_response_body_chunk()
					if(chunk.size()==0):
						OS.delay_msec(DELAY)
					else:
						rb = rb + chunk
						pass
					pass
				var text = rb.get_string_from_ascii()
				if debug:
					print("Bytes got: ", rb.size())
					print("Text: ",text)
				var dic = Dictionary();
				dic.parse_json(text)
				return dic
				pass
			pass

		pass
	else:
		print("pmscon_query_error [NOT_CONNECTED]")
	pass

func pmsc_server_info(info):
	_opt = "server_info"
	var r = pmsc_query(info)
	return r

