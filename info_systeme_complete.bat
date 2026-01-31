@echo off
setlocal enabledelayedexpansion
title Informations Systeme Completes
color 0A

:: Définir le nom du fichier de sortie
set "fichier_sortie=informations_systeme_%COMPUTERNAME%_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%.txt"
set "fichier_sortie=%fichier_sortie: =0%"

echo ===============================================================
echo           COLLECTE DES INFORMATIONS SYSTEME                     
echo ===============================================================
echo.

:: ===== DEMANDE DU MOT DE PASSE =====
echo ---------------------------------------------------------------
echo  SAISIE DU MOT DE PASSE
echo ---------------------------------------------------------------
echo.
set /p password=Entrez votre mot de passe: 
echo.
echo Mot de passe enregistre !
echo.

:: Début de l'enregistrement dans le fichier
echo =============================================================== > "%fichier_sortie%"
echo           INFORMATIONS SYSTEME DETAILLEES                      >> "%fichier_sortie%"
echo =============================================================== >> "%fichier_sortie%"
echo. >> "%fichier_sortie%"
echo Date de collecte: %date% %time% >> "%fichier_sortie%"
echo. >> "%fichier_sortie%"

:: ===== MOT DE PASSE =====
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  MOT DE PASSE COLLECTE >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo Mot de passe: %password% >> "%fichier_sortie%"
echo. >> "%fichier_sortie%"

:: ===== IDENTIFIANT DU PC =====
echo ---------------------------------------------------------------
echo  IDENTIFIANT DU PC
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  IDENTIFIANT DU PC >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo Nom de l'ordinateur : %COMPUTERNAME%
echo Nom de l'ordinateur : %COMPUTERNAME% >> "%fichier_sortie%"
echo Nom d'utilisateur   : %USERNAME%
echo Nom d'utilisateur   : %USERNAME% >> "%fichier_sortie%"
echo Nom du serveur      : %LOGONSERVER%
echo Nom du serveur      : %LOGONSERVER% >> "%fichier_sortie%"
for /f "tokens=2 delims==" %%a in ('wmic computersystem get domain /value 2^>nul') do (
    echo Domaine             : %%a
    echo Domaine             : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get manufacturer /value 2^>nul') do (
    echo Fabricant           : %%a
    echo Fabricant           : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get model /value 2^>nul') do (
    echo Modele              : %%a
    echo Modele              : %%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"

:: ===== INFORMATIONS DE SECURITE =====
echo ---------------------------------------------------------------
echo  INFORMATIONS DE SECURITE
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  INFORMATIONS DE SECURITE >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo. >> "%fichier_sortie%"
echo Informations du compte %USERNAME% : >> "%fichier_sortie%"
net user %USERNAME% 2>nul | findstr /C:"Dernier" /C:"Expire" /C:"Password" /C:"Account active" >> "%fichier_sortie%"
echo. >> "%fichier_sortie%"
echo Politique de mot de passe du systeme : >> "%fichier_sortie%"
net accounts 2>nul | findstr /C:"Longueur" /C:"age" /C:"Historique" /C:"Verrouillage" /C:"Force length" /C:"Minimum password age" /C:"Maximum password age" /C:"history" >> "%fichier_sortie%"
echo.
echo. >> "%fichier_sortie%"

:: ===== ADRESSE IP ET MAC =====
echo ---------------------------------------------------------------
echo  ADRESSES RESEAU
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  ADRESSES RESEAU >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
    echo Adresse IPv4       :%%a
    echo Adresse IPv4       :%%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"
echo Adresse(s) MAC : >> "%fichier_sortie%"
echo Adresse(s) MAC :
for /f "tokens=2 delims=:" %%a in ('getmac /v /fo list ^| findstr /c:"Adresse physique"') do (
    echo                    :%%a
    echo                    :%%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"
echo Passerelle par defaut : >> "%fichier_sortie%"
echo Passerelle par defaut :
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"Passerelle" /c:"Gateway"') do (
    echo                    :%%a
    echo                    :%%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"

:: ===== PROCESSEUR =====
echo ---------------------------------------------------------------
echo  PROCESSEUR
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  PROCESSEUR >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "tokens=2 delims==" %%a in ('wmic cpu get name /value 2^>nul') do (
    echo Nom                 : %%a
    echo Nom                 : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfCores /value 2^>nul') do (
    echo Nombre de coeurs    : %%a
    echo Nombre de coeurs    : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic cpu get NumberOfLogicalProcessors /value 2^>nul') do (
    echo Processeurs logiques: %%a
    echo Processeurs logiques: %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic cpu get MaxClockSpeed /value 2^>nul') do (
    echo Frequence max       : %%a MHz
    echo Frequence max       : %%a MHz >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"

:: ===== MEMOIRE RAM =====
echo ---------------------------------------------------------------
echo  MEMOIRE RAM
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  MEMOIRE RAM >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value 2^>nul') do (
    set ram_bytes=%%a
    set /a ram_gb=%%a/1073741824
    echo RAM Totale installee : !ram_gb! GB
    echo RAM Totale installee : !ram_gb! GB >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value 2^>nul') do (
    set ram_libre_kb=%%a
    set /a ram_libre_gb=%%a/1048576
    echo RAM Libre             : !ram_libre_gb! GB
    echo RAM Libre             : !ram_libre_gb! GB >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic memphysical get MaxCapacity /value 2^>nul') do (
    set ram_max_kb=%%a
    if not "!ram_max_kb!"=="" (
        set /a ram_max_gb=!ram_max_kb!/1048576
        echo RAM Maximum supportee : !ram_max_gb! GB
        echo RAM Maximum supportee : !ram_max_gb! GB >> "%fichier_sortie%"
    )
)
echo.
echo. >> "%fichier_sortie%"
echo Details des barrettes RAM :
echo Details des barrettes RAM : >> "%fichier_sortie%"
wmic memorychip get Capacity,Speed,Manufacturer /format:table 2>nul >> "%fichier_sortie%"
echo.
echo. >> "%fichier_sortie%"

:: ===== CARTE GRAPHIQUE =====
echo ---------------------------------------------------------------
echo  CARTE^(S^) GRAPHIQUE^(S^)
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  CARTE(S) GRAPHIQUE(S) >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get name /value 2^>nul') do (
    echo Nom                 : %%a
    echo Nom                 : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get AdapterRAM /value 2^>nul') do (
    if not "%%a"=="" (
        set vram_bytes=%%a
        set /a vram_mb=%%a/1048576
        if !vram_mb! GTR 0 (
            echo Memoire video       : !vram_mb! MB
            echo Memoire video       : !vram_mb! MB >> "%fichier_sortie%"
        )
    )
)
for /f "tokens=2 delims==" %%a in ('wmic path win32_videocontroller get DriverVersion /value 2^>nul') do (
    echo Version pilote      : %%a
    echo Version pilote      : %%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"

:: ===== ETAT DU DISQUE =====
echo ---------------------------------------------------------------
echo  ETAT DES DISQUES
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  ETAT DES DISQUES >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "skip=1 tokens=1,2,3,4" %%a in ('wmic logicaldisk get DeviceID^,Size^,FreeSpace^,FileSystem 2^>nul') do (
    if not "%%a"=="" (
        if not "%%b"=="" (
            set /a taille_gb=%%b/1073741824
            set /a libre_gb=%%c/1073741824
            set /a utilise_gb=!taille_gb!-!libre_gb!
            if !taille_gb! GTR 0 (
                set /a pourcentage=!utilise_gb!*100/!taille_gb!
                echo.
                echo. >> "%fichier_sortie%"
                echo Lecteur             : %%a
                echo Lecteur             : %%a >> "%fichier_sortie%"
                echo Systeme de fichiers : %%d
                echo Systeme de fichiers : %%d >> "%fichier_sortie%"
                echo Taille totale       : !taille_gb! GB
                echo Taille totale       : !taille_gb! GB >> "%fichier_sortie%"
                echo Espace utilise      : !utilise_gb! GB
                echo Espace utilise      : !utilise_gb! GB >> "%fichier_sortie%"
                echo Espace libre        : !libre_gb! GB
                echo Espace libre        : !libre_gb! GB >> "%fichier_sortie%"
                echo Utilisation         : !pourcentage!%%
                echo Utilisation         : !pourcentage!%% >> "%fichier_sortie%"
            )
        )
    )
)
echo.
echo. >> "%fichier_sortie%"

:: ===== PERFORMANCES =====
echo ---------------------------------------------------------------
echo  PERFORMANCES SYSTEME
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  PERFORMANCES SYSTEME >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo Chargement des informations de performance...
for /f "tokens=2 delims==" %%a in ('wmic cpu get LoadPercentage /value 2^>nul') do (
    echo Charge CPU actuelle : %%a%%
    echo Charge CPU actuelle : %%a%% >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value 2^>nul') do (
    set ram_libre=%%a
)
for /f "tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value 2^>nul') do (
    set /a ram_totale=%%a/1024
    set /a ram_utilisee=!ram_totale!-!ram_libre!
    set /a pourcent_ram=!ram_utilisee!*100/!ram_totale!
    echo Utilisation RAM     : !pourcent_ram!%%
    echo Utilisation RAM     : !pourcent_ram!%% >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"
echo Temps de fonctionnement : >> "%fichier_sortie%"
systeminfo | findstr /C:"System Boot Time" 2>nul >> "%fichier_sortie%"
echo.
echo. >> "%fichier_sortie%"

:: ===== SYSTEME D'EXPLOITATION =====
echo ---------------------------------------------------------------
echo  SYSTEME D'EXPLOITATION
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  SYSTEME D'EXPLOITATION >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
for /f "tokens=2 delims==" %%a in ('wmic os get Caption /value 2^>nul') do (
    echo OS                  : %%a
    echo OS                  : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic os get Version /value 2^>nul') do (
    echo Version             : %%a
    echo Version             : %%a >> "%fichier_sortie%"
)
for /f "tokens=2 delims==" %%a in ('wmic os get OSArchitecture /value 2^>nul') do (
    echo Architecture        : %%a
    echo Architecture        : %%a >> "%fichier_sortie%"
)
echo.
echo. >> "%fichier_sortie%"

:: ===== TOUS LES COMPTES UTILISATEURS =====
echo ---------------------------------------------------------------
echo  COMPTES UTILISATEURS DU SYSTEME
echo ---------------------------------------------------------------
echo --------------------------------------------------------------- >> "%fichier_sortie%"
echo  COMPTES UTILISATEURS DU SYSTEME >> "%fichier_sortie%"
echo --------------------------------------------------------------- >> "%fichier_sortie%"
net user 2>nul >> "%fichier_sortie%"
echo.
echo. >> "%fichier_sortie%"

echo =============================================================== >> "%fichier_sortie%"
echo               Analyse terminee !                               >> "%fichier_sortie%"
echo =============================================================== >> "%fichier_sortie%"

echo ===============================================================
echo               Analyse terminee !                              
echo ===============================================================
echo.
echo Toutes les informations ont ete enregistrees dans :
echo %fichier_sortie%
echo.
echo AVERTISSEMENT DE SECURITE :
echo Ce fichier contient votre mot de passe en clair !
echo Protegez-le ou supprimez-le apres utilisation.
echo.
pause
