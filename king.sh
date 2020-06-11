SourceFilePath=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug
SourceExeFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.exe
SourceDllFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.dll
SourceDllCommentFile=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope.xml
SourceLC100File=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/LC100

path=C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug
exeFile=Oscilloscope.exe
dllFile=Oscilloscope.dll
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/Oscilloscope.iss
setupFileName=Oscilloscope_v"$appVersion"_Setup.exe

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r
echo    # (optional) move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
	# 判斷打包exe or dll
	if [ "${1}" == "winform" ]; then
		# 判斷是否存在.exe
        	if [ ! -f "$SourceExeFile" ]; then
                	echo "\"$SourceExeFile\" does not exist"
	                exit 1
        	fi

		# 更新LC100 lang
		rm -rf E:/Setup/Oscilloscope/Oscilloscope/LC100
		cp -r $path/LC100 E:/Setup/Oscilloscope/Oscilloscope/LC100

		# 更新.exe
	        cp $SourceExeFile E:/Setup/Oscilloscope/Oscilloscope/Oscilloscope.exe

		#cd E: && cd E:/Setup/CompileFile && explorer Oscilloscope.iss

		# 包裝安裝檔
        	cd E: && cd $innoCompilerPath
	        ./ISCC.exe $issFileName

        	# 複製版本履歷
	        cp C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope版本履歷.xlsx E:/Setup/Oscilloscope/Oscilloscope版本履歷.xlsx

	        # 壓縮zip
	        cd E:/Setup/Oscilloscope
        	zip -r -X $(date '+%y%m%d%H%M')_Oscilloscope_v"$appVersion".zip $setupFileName Oscilloscope版本履歷.xlsx

	        # 移除暫存檔
	        rm ./Oscilloscope版本履歷.xlsx
	        rm $setupFileName

	        explorer .

	elif [ "${1}" == "dll" ]; then
		# 判斷是否存在.dll
        	if [ ! -f "$SourceDllFile" ]; then
                	echo "\"$SourceDllFile\" does not exist"
	                exit 1
	        fi

		# 複製版本履歷
	        cp C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug/Oscilloscope版本履歷.xlsx E:/Setup/Oscilloscope/Oscilloscope版本履歷.xlsx

		# 壓縮zip
		cd C: && cd $path && zip -r -X Oscilloscope.dll.zip LC100 Oscilloscope.dll Oscilloscope.xml Oscilloscope版本履歷.xlsx

		# 改檔名
		mv $path/Oscilloscope.dll.zip E:/Setup/Oscilloscope/$(date '+%y%m%d%H%M')_Oscilloscope_v$(sigcheck -nobanner -n $SourceDllFile).dll.zip
	else
        	echo "Wrong param [winform | dll]"
	        exit 1
	fi

	cd E: && cd E:/Setup/Oscilloscope && explorer .

elif [[ $REPLY =~ ^[Nn]$ ]]; then
        cd C: && cd C:/Users/USER/source/repos/Oscilloscope/Oscilloscope/bin/Debug && explorer Oscilloscope版本履歷.xlsx
        exit 1
fi

