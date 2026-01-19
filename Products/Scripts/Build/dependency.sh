#!/bin/sh

# Difference
# Dependency libs
# EduCore
# UIBaseViews
# Widget
Artifactory_iOS_URL="https://artifactory.agoralab.co/artifactory/AD_repo/aPaaS/iOS"

Version="2.8.116"

AgoraEduCore_URL="${Artifactory_iOS_URL}/AgoraEduCore/release_${Version}/dev/AgoraEduCore_${Version}.zip"
AgoraUIBaseViews_URL="${Artifactory_iOS_URL}/AgoraUIBaseViews/release_${Version}/dev/AgoraUIBaseViews_${Version}.zip"
AgoraWidget_URL="${Artifactory_iOS_URL}/AgoraWidget/release_${Version}/dev/AgoraWidget_${Version}.zip"

Dep_Array_URL=("${AgoraEduCore_URL}"
               "${AgoraUIBaseViews_URL}"
               "${AgoraWidget_URL}")

Dep_Array=(AgoraEduCore
           AgoraUIBaseViews 
           AgoraWidget)

# cd this file path
cd $(dirname $0)
echo pwd: `pwd`

# parameters
Repo_Name=$1

# path
CICD_Repo_Path=../../../../apaas-cicd-ios
CICD_Products_Path=${CICD_Repo_Path}/Products
CICD_Scripts_Path=${CICD_Products_Path}/Scripts

${CICD_Scripts_Path}/SDK/Build/v1/dependency.sh "${Dep_Array_URL[*]}" "${Dep_Array[*]}" ${Repo_Name}