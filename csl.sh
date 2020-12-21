path='C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug'
innoCompilerPath=E:/Setup/InnoSetupPortableUnicode/App/InnoSetup
appVersion=$(sigcheck -nobanner -n 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/ToyoSingle-CSL Software.exe')

#詢問是否更新版本履歷
read -p "是否已更新版本履歷？[Y/N]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
        # 取代新的exe
        cp 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/ToyoSingle-CSL Software.exe' 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software/ToyoSingle-CSL Software.exe'

        # 更新dll
        cp 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug'/*.dll 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software/'

	# 更新語言包(ENG)
        cp -r 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/en-US' 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software'

	# 更新語言包(JP)
        cp -r 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/ja-JP' 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software'

	# 更新語言包(TW)
        cp -r 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/zh-TW' 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software'

        # 包裝安裝檔
        cd E: && cd $innoCompilerPath
        ./ISCC.exe 'E:/Setup/CompileFile/ToyoSingle-CSL Software.iss'

        # 複製版本履歷
        cp 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug/ToyoSingle-CSL Software版本履歷.xlsx' 'E:/Setup/ToyoSingle-CSL Software/ToyoSingle-CSL Software版本履歷.xlsx'

        # 壓縮zip
        cd 'E:/Setup/ToyoSingle-CSL Software'
        zip -r -X $(date '+%y%m%d%H%M')_'ToyoSingle-CSL Software'_v"$appVersion".zip 'ToyoSingle-CSL Software_v'"$appVersion"_Setup.exe 'ToyoSingle-CSL Software版本履歷.xlsx'

        # 移除暫存檔
        rm './ToyoSingle-CSL Software版本履歷.xlsx'
        rm 'ToyoSingle-CSL Software_v'"$appVersion"_Setup.exe

        # 開啟包裝檔路徑
        explorer .
elif [[ $REPLY =~ ^[Nn]$ ]]; then
        # 開啟版本履歷Excel
        cd C: && cd 'C:/Users/USER/source/repos/ToyoSingle-CSL Software/ToyoSingle-CSL Software/bin/Debug' && explorer 'ToyoSingle-CSL Software版本履歷.xlsx'
        exit 1
fi
