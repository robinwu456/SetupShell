SourceFilePath=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug
SourceExeFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.exe
SourceDllFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.dll
SourceDllCommentFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.xml
SourceLC100File=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/LC100

# 判斷打包exe or dll
if [ "${1}" == "winform" ]; then
        if [ ! -f "$SourceExeFile" ]; then
                echo "\"$SourceExeFile\" does not exist"
                exit 1
        fi
	rm -rf E:/Setup/Oscilloscope/Oscilloscope/LC100
	cp -r $SourceFilePath/LC100 E:/Setup/Oscilloscope/Oscilloscope/LC100
        cp $SourceExeFile E:/Setup/Oscilloscope/Oscilloscope/Oscilloscope.exe
	cd E: && cd E:/Setup/CompileFile && explorer Oscilloscope.iss
elif [ "${1}" == "dll" ]; then
        if [ ! -f "$SourceDllFile" ]; then
                echo "\"$SourceDllFile\" does not exist"
                exit 1
        fi
	cd C: && cd $SourceFilePath && zip -r -X Oscilloscope.dll.zip LC100 Oscilloscope.dll Oscilloscope.xml
	mv $SourceFilePath/Oscilloscope.dll.zip E:/Setup/Oscilloscope/$(date '+%y%m%d%H%M')_Oscilloscope_v$(sigcheck -nobanner -n $SourceDllFile).dll.zip
else
        echo "Wrong param [winform | dll]"
        exit 1
fi

cd E: && cd E:/Setup/Oscilloscope && explorer .
