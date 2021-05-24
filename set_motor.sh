SourceFilePath=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug
SourceExeFile=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/SetLinearMotor.exe
SourceDllFile=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/SetLinearMotor.dll
SourceDllCommentFile=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/SetLinearMotor.xml
SourceLC100File=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/LC100

path=C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug
exeFile=SetLinearMotor.exe
dllFile=SetLinearMotor.dll
appVersion=$(sigcheck -nobanner -n $path/$exeFile)
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
issFileName=E:/Setup/CompileFile/SetLinearMotor.iss
setupFileName=SetLinearMotor_v"$appVersion"_Setup.exe

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

                # 更新.exe
                cp $SourceExeFile E:/Setup/SetLinearMotor/SetLinearMotor/SetLinearMotor.exe

                # 包裝安裝檔
                cd E: && cd $innoCompilerPath
                ./ISCC.exe $issFileName

                # 複製版本履歷
                cp C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/SetLinearMotor版本履歷.xlsx E:/Setup/SetLinearMotor/SetLinearMotor版本履歷.xlsx

                # 壓縮zip
                cd E:/Setup/SetLinearMotor
                zip -r -X $(date '+%y%m%d%H%M')_磁極檢測UI_v"$appVersion".zip $setupFileName SetLinearMotor版本履歷.xlsx

                # 移除暫存檔
                rm ./SetLinearMotor版本履歷.xlsx
                rm $setupFileName

                #explorer .

        elif [ "${1}" == "dll" ]; then
                # 判斷是否存在.dll
                if [ ! -f "$SourceDllFile" ]; then
                        echo "\"$SourceDllFile\" does not exist"
                        exit 1
                fi

                # 複製版本履歷
                cp C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug/SetLinearMotor版本履歷.xlsx E:/Setup/SetLinearMotor/SetLinearMotor版本履歷.xlsx

                # 壓縮zip
                cd C: && cd $path && zip -r -X 磁極檢測.dll.zip SetLinearMotor.dll SetLinearMotor.xml SetLinearMotor版本履歷.xlsx

                # 改檔名
                mv $path/磁極檢測.dll.zip E:/Setup/SetLinearMotor/$(date '+%y%m%d%H%M')_磁極檢測Dll_v$(sigcheck -nobanner -n $SourceDllFile).zip
        else
                echo "Wrong param [winform | dll]"
                exit 1
        fi

        cd E: && cd E:/Setup/SetLinearMotor && explorer .

elif [[ $REPLY =~ ^[Nn]$ ]]; then
        cd C: && cd C:/Users/USER/source/repos/SetLinearMotor/SetLinearMotor/bin/Debug && explorer SetLinearMotor版本履歷.xlsx
        exit 1
fi
