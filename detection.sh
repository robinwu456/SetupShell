path=C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug
exeFile=Toyo_Simple_Detection.exe
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/Toyo_Simple_Detection.iss
setupFileName=Toyo_Simple_Detection_v"$appVersion"_Setup.exe

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
	# 更新TC100 apollo
	rm -rf E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection/TC100
	cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug/TC100 E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection
	
	# 更新XC100 apollo
	rm -rf E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection/XC100
	cp -r C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug/XC100 E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection
	
	cp C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug/ADDRESS_WORD.csv E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection/ADDRESS_WORD.csv

	cp C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug/Toyo_Simple_Detection.exe E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection/Toyo_Simple_Detection.exe
	
	# 包裝安裝檔
        cd E: && cd $innoCompilerPath
        ./ISCC.exe $issFileName

	# 複製版本履歷
	cp C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug/Toyo_Simple_Detection版本履歷.xlsx E:/Setup/Toyo_Simple_Detection/Toyo_Simple_Detection版本履歷.xlsx

	 # 壓縮zip
        cd E:/Setup/Toyo_Simple_Detection
        zip -r -X $(date '+%y%m%d%H%M')_Toyo_Simple_Detection_v"$appVersion".zip $setupFileName Toyo_Simple_Detection版本履歷.xlsx

	# 移除暫存檔
        rm ./Toyo_Simple_Detection版本履歷.xlsx
        rm $setupFileName

	explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
	cd C: && cd C:/Users/USER/source/repos/Toyo_Simple_Detection/Toyo_Simple_Detection/bin/Debug && explorer Toyo_Simple_Detection版本履歷.xlsx
	exit 1
fi
