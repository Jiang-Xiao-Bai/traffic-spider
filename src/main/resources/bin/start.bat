@echo off & setlocal enabledelayedexpansion

set LIB_JARS=""
cd ..\lib
for %%i in (*) do set LIB_JARS=!LIB_JARS!;..\lib\%%i
cd ..\bin

if ""%1"" == ""debug"" goto debug
if ""%1"" == ""jmx"" goto jmx

java -Xms64m -Xmx256m -XX:MaxPermSize=64M -classpath ..\java;%LIB_JARS% com.siyu.nms.SpiderApplication
goto end

:debug
java -Xms64m -Xmx256m -XX:MaxPermSize=64M -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -classpath ..\java;%LIB_JARS% com.siyu.nms.SpiderApplication
goto end

:jmx
java -Xms64m -Xmx256m -XX:MaxPermSize=64M -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -classpath ..\java;%LIB_JARS% com.siyu.nms.SpiderApplication

:end
pause