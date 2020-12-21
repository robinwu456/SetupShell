path=C:/Users/USER/source/repos/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware/bin/Debug
prxFile=PRX
exeFile=LinearMotorSelectionSoftware.exe
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/LinearMotorSelectionSoftware.iss
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
setupFileName=LinearMotorSelectionSoftware_v"$appVersion"_Setup.exe

#打包zip
#cd C: && cd $path
#rm ./$prxFile/Apollo.log
#zip -r -X $(date '+%y%m%d%H%M')_LinearMotorSelection_v$(sigcheck -nobanner -n $exeFile).zip $prxFile $exeFile
#explorer .

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
	# 刪除Log
	rm $path/$prxFile/Apollo.log

	# 移除目標PRX
	rm -rf E:/Setup/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware/PRX

	# 複製新的PRX
	cp -r $path/PRX E:/Setup/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware

	# 取代新的exe
	cp $path/LinearMotorSelectionSoftware.exe E:/Setup/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware.exe

	# 包裝安裝檔
	cd E: && cd $innoCompilerPath
	./ISCC.exe $issFileName

	# 複製版本履歷
	cp $path/LinearMotorSelectionSoftware版本履歷.xlsx E:/Setup/LinearMotorSelectionSoftware/LinearMotorSelectionSoftware版本履歷.xlsx

	# 壓縮zip
	cd E:/Setup/LinearMotorSelectionSoftware
	zip -r -X $(date '+%y%m%d%H%M')_線馬選型軟體_v"$appVersion".zip $setupFileName LinearMotorSelectionSoftware版本履歷.xlsx

	# 移除暫存檔
	rm ./LinearMotorSelectionSoftware版本履歷.xlsx
	rm $setupFileName

	# 開啟包裝檔路徑
	explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
	# 開啟版本履歷Excel
	cd C: && cd $path && explorer LinearMotorSelectionSoftware版本履歷.xlsx
	exit 1
fi
