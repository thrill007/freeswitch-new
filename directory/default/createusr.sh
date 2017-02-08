#! /bin/bash

YV_setUserCfg()
{
	read -p "要增加的账户名. [zhanglei]:" key_value
	touch $key_value.xml
	cp zhanglei.xml $key_value.xml
	sed -i 's/zhanglei/'$key_value'/g' $key_value.xml
}

#结束标志
end=0
#echo 模拟新设备开始
while [[ $end != 1 ]]
do
	YV_setUserCfg

done
	
