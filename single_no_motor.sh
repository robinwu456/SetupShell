path=C:/Users/USER/source/repos/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware/bin/Debug
prxFile=PRX
exeFile=不帶電選型軟體.exe
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/SingleAxis_NoMotor_SelectionSoftware.iss
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
setupFileName=SingleAxis_NoMotor_SelectionSoftware_v"$appVersion"_Setup.exe

#打包zip
#cd C: && cd $path
#rm ./$prxFile/Apollo.log
#zip -r -X $(date '+%y%m%d%H%M')_LinearMotorSelection_v$(sigcheck -nobanner -n $exeFile).zip $prxFile $exeFile
#explorer .

#詢問是否更新版本履歷
#read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

#if [[ $REPLY =~ ^[Yy]$ ]]; then
	# 刪除Log
	#rm $path/$prxFile/Apollo.log

	# 移除目標PRX
	rm -rf E:/Setup/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware/PRX

	# 複製新的PRX
	cp -r $path/PRX E:/Setup/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware

	# 取代新的exe
	cp $path/不帶電選型軟體.exe E:/Setup/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware/不帶電選型軟體.exe

	# 更新dll
        cp $path/*.dll E:/Setup/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware/

	# 包裝安裝檔
	cd E: && cd $innoCompilerPath
	./ISCC.exe $issFileName

	# 複製版本履歷
	cp $path/SingleAxis_NoMotor_SelectionSoftware版本履歷.xlsx E:/Setup/SingleAxis_NoMotor_SelectionSoftware/SingleAxis_NoMotor_SelectionSoftware版本履歷.xlsx

	# 壓縮zip
	cd E:/Setup/SingleAxis_NoMotor_SelectionSoftware
	zip -r -X $(date '+%y%m%d%H%M')_不帶電_v"$appVersion".zip $setupFileName SingleAxis_NoMotor_SelectionSoftware版本履歷.xlsx

	# 移除暫存檔
	rm ./SingleAxis_NoMotor_SelectionSoftware版本履歷.xlsx
	rm $setupFileName

	# 開啟包裝檔路徑
	explorer .
#elif [[ $REPLY =~ ^[Nn]$ ]]; then
	# 開啟版本履歷Excel
#	cd C: && cd $path && explorer SingleAxis_NoMotor_SelectionSoftware版本履歷.xlsx
#	exit 1
#fi
