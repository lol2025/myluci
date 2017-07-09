--[[
openwrt-dist-luci: ChinaDNS
]]--

local m, s, o

if luci.sys.call("pidof chinadns >/dev/null") == 0 then
	m = Map("chinadns", translate("ChinaDNS"), translate("状态 - <font color=\"green\">运行中</font>"))
else
	m = Map("chinadns", translate("ChinaDNS"), translate("状态 - <font color=\"red\">未运行</font>"))
end

s = m:section(TypedSection, "chinadns", translate("General Setting"))
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty = false

o = s:option(Flag, "bidirectional",
	translate("Enable Bidirectional Filter"),
	translate("Also filter results inside China from foreign DNS servers"))
o.rmempty = false

o = s:option(Flag, "apnt_en",
	translate("Enable DNS compression pointer"),
	translate("Use DNS compression pointer mutation."))
o.rmempty = false

o = s:option(Value, "port", translate("Local Port"))
o.placeholder = 5353
o.default = 5353
o.datatype = "port"
o.rmempty = false

o = s:option(Value, "chnroute", translate("CHNRoute File"))
o.placeholder = "/etc/chinadns_chnroute.txt"
o.default = "/etc/chinadns_chnroute.txt"
o.datatype = "file"
o.rmempty = false

o = s:option(Value, "server",
	translate("Upstream Servers"),
	translate("Use commas to separate multiple ip address"))
o.placeholder = "114.114.114.114,208.67.222.222:443,8.8.8.8"
o.default = "114.114.114.114,208.67.222.222:443,8.8.8.8"
o.rmempty = false

o=s:option(Flag, "set_dnsmasq", translate("自动修改dnsmasq全局配置"),translate("自动修改【网络】-【DHCP】中的【DNS转发】"))
o.rmempty=false
o.default = true

return m
