#cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TestingReportAnalysis.exe E:/Setup/TestingReportAnalysis/TestingReportAnalysis/
#cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TestingReportAnalysis.exe.config E:/Setup/TestingReportAnalysis/TestingReportAnalysis/

#rm -rf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/TC100
#rm -rf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/XC100
#cp -r C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TC100 E:/Setup/TestingReportAnalysis/TestingReportAnalysis
#cp -r C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/XC100 E:/Setup/TestingReportAnalysis/TestingReportAnalysis

#cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/*.dll E:/Setup/TestingReportAnalysis/TestingReportAnalysis/
#cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/*.mdf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/
#cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/*.ldf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/

#cd E: && cd E:/Setup/TestingReportAnalysis && explorer .
#cd E: && cd E:/Setup/CompileFile && explorer TestingReportAnalysis.iss


path=C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug
exeFile=TestingReportAnalysis.exe
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/TestingReportAnalysis.iss
setupFileName=TestingReportAnalysis_v"$appVersion"_Setup.exe

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
        # 更新TC100 apollo
        rm -rf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/TC100
        cp -r C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TC100 E:/Setup/TestingReportAnalysis/TestingReportAnalysis

        # 更新XC100 apollo
        rm -rf E:/Setup/TestingReportAnalysis/TestingReportAnalysis/XC100
        cp -r C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/XC100 E:/Setup/TestingReportAnalysis/TestingReportAnalysis

	# 更新dll
	cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/*.dll E:/Setup/TestingReportAnalysis/TestingReportAnalysis/

        # 更新exe
        cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TestingReportAnalysis.exe E:/Setup/TestingReportAnalysis/TestingReportAnalysis/TestingReportAnalysis.exe
	cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TestingReportAnalysis.exe.config E:/Setup/TestingReportAnalysis/TestingReportAnalysis/

        # 包裝安裝檔
        cd E: && cd $innoCompilerPath
        ./ISCC.exe $issFileName

        # 複製版本履歷
        cp C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug/TestingReportAnalysis版本履歷.xlsx E:/Setup/TestingReportAnalysis/TestingReportAnalysis版本履歷.xlsx

         # 壓縮zip
        cd E:/Setup/TestingReportAnalysis
        zip -r -X $(date '+%y%m%d%H%M')_TestingReportAnalysis_v"$appVersion".zip $setupFileName TestingReportAnalysis版本履歷.xlsx

        # 移除暫存檔
        rm ./TestingReportAnalysis版本履歷.xlsx
        rm $setupFileName

        explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
        cd C: && cd C:/Users/USER/source/repos/TestingReportAnalysis/TestingReportAnalysis/bin/Debug && explorer TestingReportAnalysis版本履歷.xlsx
        exit 1
fi
