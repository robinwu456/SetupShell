path=C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug
exeFile=Testing_Software_New.exe
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/Testing_Software_New.iss

setupFileName=Testing_Software_New_v"$appVersion"_Setup.exe
allVersion=$appVersion
arrayVersion=($(echo "$allVersion" | tr '_' '\n'))

if [[ ${#arrayVersion[@]} == 2 ]]; then
	setupFileName=Testing_Software_New_v"${arrayVersion[0]}"_Setup.exe
fi

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
        # 更新TC100 apollo
        rm -rf E:/Setup/Testing_Software_New/Testing_Software_New/TC100
        cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/TC100 E:/Setup/Testing_Software_New/Testing_Software_New

        # 更新XC100 apollo
        rm -rf E:/Setup/Testing_Software_New/Testing_Software_New/XC100
        cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/XC100 E:/Setup/Testing_Software_New/Testing_Software_New
	
	# 更新LC100 apollo
        rm -rf E:/Setup/Testing_Software_New/Testing_Software_New/LC100
        cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/LC100 E:/Setup/Testing_Software_New/Testing_Software_New

	# 更新SC100 apollo
        rm -rf E:/Setup/Testing_Software_New/Testing_Software_New/SC100
        cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/SC100 E:/Setup/Testing_Software_New/Testing_Software_New

	# 更新語言檔
	cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/zh-Hans E:/Setup/Testing_Software_New/Testing_Software_New
	cp -r C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/zh-Hant E:/Setup/Testing_Software_New/Testing_Software_New

	# 更新address
	cp C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/ADDRESS_WORD.csv E:/Setup/Testing_Software_New/Testing_Software_New/ADDRESS_WORD.csv

	# 更新電流平均
        cp C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/CURRENT_LIMIT.csv E:/Setup/Testing_Software_New/Testing_Software_New/CURRENT_LIMIT.csv

	# 更新dll
        cp C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/*.dll E:/Setup/Testing_Software_New/Testing_Software_New/

	# 更新exe
        cp C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/Testing_Software_New.exe E:/Setup/Testing_Software_New/Testing_Software_New/Testing_Software_New.exe

        # 包裝安裝檔
        cd E: && cd $innoCompilerPath
        ./ISCC.exe $issFileName

        # 複製版本履歷
        cp C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug/Testing_Software_New版本履歷.xlsx E:/Setup/Testing_Software_New/Testing_Software_New版本履歷.xlsx

         # 壓縮zip
        cd E:/Setup/Testing_Software_New
        zip -r -X $(date '+%y%m%d%H%M')_新版測試機_v"$appVersion".zip $setupFileName Testing_Software_New版本履歷.xlsx

        # 移除暫存檔
        rm ./Testing_Software_New版本履歷.xlsx
        rm $setupFileName

        explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
        cd C: && cd C:/Users/USER/source/repos/Testing_Software_New/Testing_Software_New/bin/Debug && explorer Testing_Software_New版本履歷.xlsx
        exit 1
fi
