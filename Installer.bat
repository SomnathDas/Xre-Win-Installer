@echo off
CLS
color F0
echo                                     __                               ___                          
echo \  X  / ( _   _  _)_ _ _   _   _     )_)  _  _)_ _)_ _    (/  _ _      )  _   _ _)_ _   ) )  _   _ 
echo  \/ \/   ) ) (_( (_ ( (_( )_) )_)   /__) (_) (_  (_ (_)   /) ) )_)   _(_ ) ) (  (_ (_( ( (  )_) )  
echo                     _)   (   (                                (_             _)            (_    
echo Press "Enter" to start the installation process!                                                 
pause
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "6.1" (START CMD /C "color 04 && ECHO !!! INSTALL POWERSHELL VERSION 3.0 or above !!! && PAUSE")
cls
color 0b
if exist C:\XreBotto (
    echo [ OK ] Directory Already Exists
) else (
    mkdir C:\XreBotto && echo [ OK ] Created XreBotto Directory in C:\ Drive
) 
if exist C:\XreBotto\TempExecutables (
    echo [ OK ] TempExecutables Directory Already Exists
) else (
    mkdir C:\XreBotto\TempExecutables && echo [ OK ] Created TempExecutables Directory in C:\XreBotto
)
cd C:\XreBotto
echo ------------INSTALLING PRE-REQUISITES------------
:preq
where node>nul 2>&1 && echo [ OK ] NodeJS Already Installed, Moving on... || echo Nodejs not installed! && (echo `Downloading and Installing NodeJS` && GOTO :nodeinstall )
where 7z> nul 2>&1 && echo [ OK ] 7-zip Already Installed, Moving on... || echo 7-zip is not installed! && (echo `Downloading and Installing 7zip` && GOTO :installsevzip)
where git>nul 2>&1 && echo [ OK ] Git Already Installed, Moving on... || echo git not installed! && (echo `Downloading and Installing Git` && GOTO :gitinstall)
where mogrify>nul 2>&1 && echo [ OK ] ImageMagick Already Installed, Moving on... || (echo `Downloading and Installing ImageMagick` && GOTO :installmagick)
where ffmpeg>nul 2>&1 && echo [ OK ] ffmpeg Already Installed, Moving on... || (echo `Downloading and Installing ffmpeg` && GOTO :ffmpeginstall)
echo:
:botinstall
echo ------------INSTALLING BOT------------
if exist Whatsapp-Botto-Xre (
    echo [ OK ] Already Clonned the Repo!
) else (
    echo [ GIT ] Clonning the repository!
    git clone https://github.com/SomnathDas/Whatsapp-Botto-Xre
)
echo: 
echo ------------DEPENDENCIES TIME------------
cd Whatsapp-Botto-Xre
if exist ./node_modules (
    echo [ OK ] NODE_MODULES ALREADY EXISTS, Moving on...
) else (
    echo ------------Installing Required Node Modules For Xre------------
    npm i && npm i -D || color 04 goto :error
    echo ------------SUCCESSFULLY INSTALLED NODEJS DEPENDENCIES------------
    echo:
    goto endgame
)

:endgame
if exist ./dist (
    echo [ ALREADY ] EXISTS COMPILED TYPESCRIPT
    pause
) else (
    echo ------------COMPILING TYPESCRIPT INTO JAVASCRIPT------------
    npm run build
)
echo:
echo ------------Do you want to remove useless executable files?------------
cd C:\XreBotto
rmdir /s C:\XreBotto\TempExecutables
echo ------------[ SUCCESS ]Whatsapp Botto Xre Successfully Installed------------
echo:
color 09
echo ------------[ WARNING! ] Make sure to set-up MongoDB/Database before starting the bot------------
pause
color 0b
echo ------------[ SETTING UP] MONGO ATLAST DB------------
cd C:\XreBotto\Whatsapp-Botto-Xre
echo Enter your Cluster URI received from Mongo Atlast!
set /p your_cluster_uri=""
(echo MONGO_URI=%your_cluster_uri% 
echo EIF=https://express-is-fun.herokuapp.com/ 
echo ADMINS='') > .env
echo ------------[ COMPLETED ] MONGO ATLAST DB SETUP------------
echo: 
echo ------------[ NOTE ] You can start bot by opening command prompt in the bot directory and typing 'npm start'------------
pause

:error
echo Failed due to #%errorlevel%.
exit /b %errorlevel%
:nodeinstall
powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v14.16.0/node-v14.16.0-x64.msi -OutFile  C:\XreBotto\TempExecutables\node-v14.16.0-x64.msi"
cd C:\XreBotto\TempExecutables
node-v14.16.0-x64.msi
cd C:\XreBotto
GOTO :preq
:gitinstall
powershell -Command "Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.31.1.windows.1/Git-2.31.1-64-bit.exe -OutFile  C:\XreBotto\TempExecutables\Git-2.31.1-64-bit.exe"
cd C:\XreBotto\TempExecutables
Git-2.31.1-64-bit.exe
echo ------Setting Up Git in PATHS------
setx /m path "C:\Program Files\Git\bin;%PATH%"
call RefreshEnv.cmd
cd C:\XreBotto
GOTO :preq
:installsevzip
powershell -Command "Invoke-WebRequest https://www.7-zip.org/a/7z1900-x64.exe -OutFile C:\XreBotto\TempExecutables\7z1900-x64.exe"
cd C:\XreBotto\TempExecutables
7z1900-x64.exe
echo ------Setting Up 7z in PATHS------
setx /m path "C:\Program Files\7-Zip\;%PATH%"
call RefreshEnv.cmd
cd C:\XreBotto
GOTO :preq
:installwebp
powershell -Command "Invoke-WebRequest https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-1.2.0-windows-x64.zip -OutFile  C:\XreBotto\TempExecutables\libwebp-1.2.0-windows-x64.zip"
cd C:\XreBotto\TempExecutables
7z x libwebp-1.2.0-windows-x64.zip -oC:\
cd C:\
ren libwebp-1.2.0-windows-x64 libwebp
setx /m path "C:\libwebp\bin;%PATH%"
call RefreshEnv.cmd
cd C:\XreBotto
GOTO :preq
:installmagick
powershell -Command "Invoke-WebRequest https://download.imagemagick.org/ImageMagick/download/binaries/ImageMagick-6.9.12-6-Q16-HDRI-x64-dll.exe -OutFile  C:\XreBotto\TempExecutables\magicksetup.exe"
cd C:\XreBotto\TempExecutables
magicksetup.exe
setx /m path "C:\Program Files\ImageMagick-6.9.12-Q16-HDRI\;%PATH%"
call RefreshEnv.cmd
GOTO :preq
:ffmpeginstall
powershell -Command "Invoke-WebRequest https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z -OutFile  C:\XreBotto\TempExecutables\ffmpeg-git-full.7z"
cd  C:\XreBotto\TempExecutables
7z x ffmpeg-git-full.7z -oC:\
cd C:\
ren ffmpeg-git-full.7z ffmpeg
setx /m path "C:\ffmpeg\bin;%PATH%"
call RefreshEnv.cmd
goto :botinstall
