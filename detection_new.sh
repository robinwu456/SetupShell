path=C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug
exeFile=荷重軟體.exe
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/Toyo_Simple_Detection_New.iss
setupFileName=Toyo_Simple_Detection_v"$appVersion"_Setup.exe

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
	# 更新TC100 apollo
	rm -rf E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/TC100
	cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/TC100 E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New
	
	# 更新XC100 apollo
	rm -rf E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/XC100
	cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/XC100 E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New

	# 更新LC100 apollo
        rm -rf E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/LC100
        cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/LC100 E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New
	
        # 更新語言檔
        cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/zh-TW E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New
        cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/en-US E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New

	# 更新dll
        cp C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/*.dll E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/

	cp C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/ADDRESS_WORD.csv E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/ADDRESS_WORD.csv

	cp C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/荷重軟體.exe E:/Setup/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/荷重軟體.exe
	
	# 包裝安裝檔
        cd E: && cd $innoCompilerPath
        ./ISCC.exe $issFileName

	# 複製版本履歷
	cp C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug/荷重軟體版本履歷.xlsx E:/Setup/Toyo_Simple_Detection_New/荷重軟體版本履歷.xlsx

	 # 壓縮zip
        cd E:/Setup/Toyo_Simple_Detection_New
        zip -r -X $(date '+%y%m%d%H%M')_荷重軟體_v"$appVersion".zip $setupFileName 荷重軟體版本履歷.xlsx

	# 移除暫存檔
        rm ./荷重軟體版本履歷.xlsx
        rm $setupFileName

	explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
	cd C: && cd C:/Users/USER/source/repos/Toyo_Simple_Detection_New/Toyo_Simple_Detection_New/bin/Debug && explorer 荷重軟體版本履歷.xlsx
	exit 1
fi
