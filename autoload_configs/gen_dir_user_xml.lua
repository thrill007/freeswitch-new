local req_domain = params:getHeader("domain");
local req_key    = params:getHeader("key");
local req_user   = params:getHeader("user");
local dbh        = freeswitch.Dbh("mysql", "root", "123456");
if dbh.connected() == false then
    freeswitch.consoleLog("notice", "gen_dir_user_xml.lua connot connect to database" ..dsn.. "\n");
    return;
end
XML_STRING=
[[<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type=" freeswitch/xml">
    <section name="directory">
        <domain name="]]..req_domain..[[">
            <user id="]]...req_user ..[["
                <params>
                    <param name="password" value="ysyhL9T"/>
                    <param name="dial-string" value="{sip_invite_domain=${dialed_domain},
                        presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}"/>
                </params>
                <variables>
                    <variable name="user_context" value="default"/>
                </variables>
            </user>
        </domain>
    </section>
</document>]]
local my_query=string.format("select password from userinfo where username='%s' limit 1",req_user)
assert.dbh:query(my_query,function(u)--there will be only 0 or 1 iteration(limit 1)
XML_STRING=
[[<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type=" freeswitch/xml">
    <section name="directory">
        <domain name="]]..req_domain..[[">
            <user id="]]..req_user ..[[">
                <params>
                    <param name="password" value="]]..u.password..[["/>
                    <param name="dial-string" value={sip_invite_domain=${dialed_domain},
                        presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}"/>
                </params>
                <variables>
                    <variable name="user_context" value="default"/>
                </variable>
            </user>
        </domain>
    </section>
</document>]]
end))

