#!/bin/bash
Color='\033[1;36m'
Res='\033[0m'

Products_Path="../../Libs"
SDKs_Path="../../../SDKs"
dSYMs_iPhone="../../Libs/dSYMs_iPhone"
dSYMs_Simulator="../../Libs/dSYMs_Simulator"
Root_Path=`pwd`
SDK_Name=$1

rm -rf ${Products_Path}
mkdir ${Products_Path}

rm -rf ${dSYMs_iPhone}
mkdir ${dSYMs_iPhone}

rm -rf ${dSYMs_Simulator}
mkdir ${dSYMs_Simulator}

errorExit() {
    SDK_Name=$1
    Build_Result=$2

    if [ $Build_Result != 0 ]; then
        echo "SDK_Name: ${SDK_Name}"
        exit 1
    fi
    echo "build result: $Build_Result"
    echo "${SDK_Name} build success"
}

buildItem() {
    SDK_Name=$1
    
    echo "${Color} ======${SDK_Name} Start======== ${Res}"
    ./buildFramework.sh ${SDKs_Path}/AgoraBuilder ${SDK_Name} Release

    errorExit ${SDK_Name} $?
}

SDK_Name="AgoraProctorSDK"
buildItem ${SDK_Name}

Files=$(ls ${Products_Path})

for FileName in ${Files}
do
    if [[ ! ${FileName} =~ "framework" ]]
    then
        # 过滤 dsym
        continue
    elif [[ ${FileName} == "AgoraLog.framework" ]]
    then
        rm -fr ${Products_Path}/${FileName}
        rm -fr ${dSYMs_iPhone}/${FileName}.dSYM
        rm -fr ${dSYMs_Simulator}/${FileName}.dSYM
    elif [[ ! ${FileName} =~ "Agora" ]]
    then
        rm -fr ${Products_Path}/${FileName}
        rm -fr ${dSYMs_iPhone}/${FileName}.dSYM
        rm -fr ${dSYMs_Simulator}/${FileName}.dSYM
    elif [[ ${FileName} =~ "Pods" ]]
    then
        rm -fr ${Products_Path}/${FileName}
        rm -fr ${dSYMs_iPhone}/${FileName}.dSYM
        rm -fr ${dSYMs_Simulator}/${FileName}.dSYM
    fi
done

# delete useless framework
Delete_Frameworks=(AgoraEduContext AgoraUIBaseViews AgoraWidget)

for Framework in ${Delete_Frameworks[@]} 
do
    echo "rm framework: ${Framework}"
    rm -fr ${Products_Path}/${Framework}.framework
    rm -fr ${dSYMs_iPhone}/${Framework}.framework.dSYM
    rm -fr ${dSYMs_Simulator}/${Framework}.framework.dSYM
done
