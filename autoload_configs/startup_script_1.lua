api = freeswitch.API();
reply = api:executeString("/usr/local/src/freeswitch/libs/esl/testclient");
freeswitch.consoleLog("INFO", "Got reply:\n\n" ..reply .. "\n");
