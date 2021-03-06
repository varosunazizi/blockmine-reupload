

local ac = {nodes={}}

function ac.load(data)
	if data then
		ac.nodes=data.nodes
	end
end
function ac.save()
	return {nodes = ac.nodes}
end

function ac.after_place_node(pos, player)
	local meta=minetest.get_meta(pos)
	meta:set_string("formspec", ac.getform(pos, meta))
	meta:set_string("infotext", "LuaAutomation component, unconfigured.")
	local ph=minetest.pos_to_string(pos)
	--just get first available key!
	for en,_ in pairs(atlatc.envs) do
		ac.nodes[ph]={env=en}
		return
	end
end
function ac.getform(pos, meta_p)
	local meta = meta_p or minetest.get_meta(pos)
	local envs_asvalues={}
	
	local ph=minetest.pos_to_string(pos)
	local nodetbl = ac.nodes[ph]
	local env, code, err = nil, "", ""
	if nodetbl then
		code=nodetbl.code or ""
		err=nodetbl.err or ""
		env=nodetbl.env or ""
	end
	local sel = 1
	for n,_ in pairs(atlatc.envs) do
		envs_asvalues[#envs_asvalues+1]=minetest.formspec_escape(n)
		if n==env then
			sel=#envs_asvalues
		end
	end
	local form = "size[10,10]dropdown[0,0;3;env;"..table.concat(envs_asvalues, ",")..";"..sel.."]"
		.."button[4,0;2,1;save;Save]button[7,0;2,1;cle;Clear local env] textarea[0.2,1;10,10;code;Code;"..minetest.formspec_escape(code).."]"
		.."label[0,9.8;"..err.."]"
	return form
end

function ac.after_dig_node(pos, node, player)
	advtrains.invalidate_all_paths(pos)
	advtrains.ndb.clear(pos)
	local ph=minetest.pos_to_string(pos)
	ac.nodes[ph]=nil
end

function ac.on_receive_fields(pos, formname, fields, player)
	if not minetest.check_player_privs(player:get_player_name(), {atlatc=true}) then
		minetest.chat_send_player(player:get_player_name(), "Missing privilege: atlatc - Operation cancelled!")
		return
	end
	
	local meta=minetest.get_meta(pos)
	local ph=minetest.pos_to_string(pos)
	local nodetbl = ac.nodes[ph] or {}
	--if fields.quit then return end
	if fields.env then
		nodetbl.env=fields.env
	end
	if fields.code then
		nodetbl.code=fields.code
	end
	if fields.save then
		-- reset certain things
		nodetbl.err=nil
		if advtrains.lines and advtrains.lines.sched then
			-- discard all schedules for this node
			advtrains.lines.sched.discard_all(advtrains.encode_pos(pos))
		end
	end
	if fields.cle then
		nodetbl.data={}
	end
	
	ac.nodes[ph]=nodetbl
	
	meta:set_string("formspec", ac.getform(pos, meta))
	if nodetbl.env then
		meta:set_string("infotext", "LuaAutomation component, assigned to environment '"..nodetbl.env.."'")
	else
		meta:set_string("infotext", "LuaAutomation component, invalid enviroment set!")
	end
end

function ac.run_in_env(pos, evtdata, customfct_p)
	local ph=minetest.pos_to_string(pos)
	local nodetbl = ac.nodes[ph]
	if not nodetbl then
		atwarn("LuaAutomation component at",ph,": Data not in memory! Please visit component and click 'Save'!")
		return
	end
	
	local meta
	if minetest.get_node_or_nil(pos) then
		meta=minetest.get_meta(pos)
	end
	
	if not nodetbl.env or not atlatc.envs[nodetbl.env] then
		atwarn("LuaAutomation component at",ph,": Not an existing environment: "..(nodetbl.env or "<nil>"))
		return false
	end
	if not nodetbl.code or nodetbl.code=="" then
		atwarn("LuaAutomation component at",ph,": No code to run! (insert -- to suppress warning)")
		return false
	end
	
	local customfct=customfct_p or {}
	-- add interrupt function
	customfct.interrupt=function(t, imesg)
		assertt(t, "number")
		assert(t >= 0)
		atlatc.interrupt.add(t, pos, {type="int", int=true, message=imesg, msg=imesg}) --Compatiblity "message" field.
	end
	-- add digiline_send function, if digiline is loaded
	if minetest.global_exists("digiline") then
		customfct.digiline_send=function(channel, msg)
			assertt(channel, "string")
			digiline:receptor_send(pos, digiline.rules.default, channel, msg)
		end
	end
	-- add lines scheduler if enabled
	if advtrains.lines and advtrains.lines.sched then
		customfct.schedule = function(rwtime, msg)
			return advtrains.lines.sched.enqueue(rwtime, "atlatc_env", {pos=pos, msg=msg}, advtrains.encode_pos(pos), 1)
		end
		customfct.schedule_in = function(rwtime, msg)
			return advtrains.lines.sched.enqueue_in(rwtime, "atlatc_env", {pos=pos, msg=msg}, advtrains.encode_pos(pos), 1)
		end
	end
	
	local datain=nodetbl.data or {}
	local succ, dataout = atlatc.envs[nodetbl.env]:execute_code(datain, nodetbl.code, evtdata, customfct)
	if succ then
		atlatc.active.nodes[ph].data=atlatc.remove_invalid_data(dataout)
	else
		atlatc.active.nodes[ph].err=dataout
		atwarn("LuaAutomation ATC interface rail at",ph,": LUA Error:",dataout)
		if meta then
			meta:set_string("infotext", "LuaAutomation ATC interface rail, ERROR:"..dataout)
		end
	end
	if meta then
		meta:set_string("formspec", ac.getform(pos, meta))
	end
end

function ac.on_digiline_receive(pos, node, channel, msg)
	atlatc.interrupt.add(0, pos, {type="digiline", digiline=true, channel = channel, msg = msg})
end

if advtrains.lines and advtrains.lines.sched then
	advtrains.lines.sched.register_callback("atlatc_env", function(data)
		-- This adds another interrupt to the atlatc queue... there might be a better way
		atlatc.interrupt.add(0, data.pos, {type="schedule",schedule=true, msg=data.msg})
	end)
end

atlatc.active=ac
