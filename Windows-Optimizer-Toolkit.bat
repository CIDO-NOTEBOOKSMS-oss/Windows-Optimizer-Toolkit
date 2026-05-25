@echo off
:: ==============================================================================
:: Nome do Arquivo: Windows-Optimizer-Toolkit.bat
:: Desenvolvedor:   Notebooks MS
:: Descricao:       Automacao de otimizacao, reparo, limpeza e configuracao
::                  do Windows 10/11 para assistencia tecnica.
:: ==============================================================================

setlocal enabledelayedexpansion
chcp 65001 >nul
title Windows Optimizer Toolkit - Notebooks MS

:: ==================== CORES ANSI ====================
set "C_RESET=[0m"
set "C_VERDE=[92m"
set "C_AMARELO=[93m"
set "C_VERMELHO=[91m"
set "C_CIANO=[96m"
set "C_BRANCO=[97m"

:: ==================== ADMIN CHECK ====================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %C_VERMELHO%[ERRO] Este script requer privilegios de Administrador.%C_RESET%
    echo Execute com botao direito ^> Executar como Administrador.
    pause
    exit /b 1
)

:: ==================== LOG ====================
set "LOG_PATH=C:\Logs\Optimizer-Toolkit.log"
for /f "delims=" %%i in ("!LOG_PATH!") do set "LOG_DIR=%%~dpi"
if not exist "!LOG_DIR!" mkdir "!LOG_DIR!" >nul 2>&1

:: ==================== BATCH MODE FLAG ====================
set "BATCH_MODE=0"

:: ==================== ORIGINAL WINGET DATABASE ====================
set "ID1=RARLab.WinRAR"                   & set "NAME1=1. RARLab WinRAR"
set "ID2=CodecGuide.K-LiteCodecPack.Mega" & set "NAME2=2. K-Lite Codec Pack Mega"
set "ID3=VideoLAN.VLC"                    & set "NAME3=3. VLC Media Player"
set "ID4=Foxit.FoxitReader"               & set "NAME4=4. Foxit PDF Reader"
set "ID5=Google.Chrome"                   & set "NAME5=5. Google Chrome"
set "ID6=Mozilla.Firefox.pt-BR"            & set "NAME6=6. Mozilla Firefox (PT-BR)"
set "ID7=Oracle.JavaRuntimeEnvironment"    & set "NAME7=7. Java SE Runtime (Oracle)"

:: ============================================================================
::                              MENU PRINCIPAL
:: ============================================================================
:MenuPrincipal
cls
echo %C_CIANO%==============================================================================
echo    WINDOWS OPTIMIZER TOOLKIT ^| Notebooks MS
echo==============================================================================%C_RESET%
echo  Log: !LOG_PATH!
echo %C_CIANO%==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[A] INSTALACAO DE PROGRAMAS (WinGet)%C_RESET%
echo     %C_CIANO%[B] Verificacao e Reparo do Sistema%C_RESET%
echo     %C_CIANO%[C] Limpeza Profunda%C_RESET%
echo     %C_CIANO%[D] Otimizacao de Performance%C_RESET%
echo     %C_CIANO%[E] Privacidade e Telemetria%C_RESET%
echo     %C_CIANO%[F] Remocao de Bloatware%C_RESET%
echo     %C_CIANO%[G] Otimizacao de Rede%C_RESET%
echo     %C_CIANO%[H] Servicos Desnecessarios%C_RESET%
echo     %C_CIANO%[I] Ferramentas de Diagnostico%C_RESET%
echo     %C_AMARELO%[J] Ativacao Windows/Office (MAS)%C_RESET%
echo.
echo                                                    %C_VERMELHO%[X] SAIR%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo %C_BRANCO%Desenvolvido por Notebooks MS %C_CIANO^|%C_RESET% %C_AMARELO%https://notebooksms.com.br%C_RESET%
echo.

choice /c ABCDEFGHIJX /n /m "Escolha a opcao desejada (A-J ou X): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatA_Menu
if "%OPC%"=="2"  goto CatB_Menu
if "%OPC%"=="3"  goto CatC_Menu
if "%OPC%"=="4"  goto CatD_Menu
if "%OPC%"=="5"  goto CatE_Menu
if "%OPC%"=="6"  goto CatF_Menu
if "%OPC%"=="7"  goto CatG_Menu
if "%OPC%"=="8"  goto CatH_Menu
if "%OPC%"=="9"  goto CatI_Menu
if "%OPC%"=="10" goto CatJ_Menu
if "%OPC%"=="11" goto Sair
goto MenuPrincipal


:: ============================================================================
::                        CATEGORIA A - INSTALACAO (ORIGINAL)
:: ============================================================================
:CatA_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA A ^| Instalacao de Programas (WinGet)
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] Instalacao AUTOMATICA COMPLETA (1 a 7 sequencial)%C_RESET%
echo.
echo     --- SELECAO INDIVIDUAL ---
echo     !NAME1!
echo     !NAME2!
echo     !NAME3!
echo     !NAME4!
echo     !NAME5!
echo     !NAME6!
echo     !NAME7!
echo     8. Instalar uBlock Origin Lite (Chrome e Edge)
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                                %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatA_Todas
if "%OPC%"=="2"  set "IDX=1" & goto RunWinGet
if "%OPC%"=="3"  set "IDX=2" & goto RunWinGet
if "%OPC%"=="4"  set "IDX=3" & goto RunWinGet
if "%OPC%"=="5"  set "IDX=4" & goto RunWinGet
if "%OPC%"=="6"  set "IDX=5" & goto RunWinGet
if "%OPC%"=="7"  set "IDX=6" & goto RunWinGet
if "%OPC%"=="8"  set "IDX=7" & goto RunWinGet
if "%OPC%"=="9"  goto CatA_uBlock
if "%OPC%"=="10" goto MenuPrincipal
goto CatA_Menu

:CatA_Todas
cls
echo %C_CIANO%==============================================================================
echo    Instalacao Automatica em Lote
echo==============================================================================%C_RESET%
echo %C_AMARELO%Instalando programas de 1 a 8 sequencialmente...%C_RESET%
echo.
for /l %%i in (1,1,6) do (
    echo [-] Instalando !NAME%%i!...
    echo [%date% %time%] [BATCH] Iniciando !NAME%%i! >> "!LOG_PATH!"
    winget install --id !ID%%i! -e --accept-package-agreements --accept-source-agreements
)
echo [-] Instalando Java Oracle...
echo [%date% %time%] [BATCH] Iniciando Java Oracle >> "!LOG_PATH!"
winget install --id !ID7! -e --accept-package-agreements --accept-source-agreements --silent --override "/s"
echo.
echo %C_VERDE%Instalacao concluida!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatA_Menu

:CatA_uBlock
cls
echo %C_CIANO%==============================================================================
echo    Instalando uBlock Origin Lite
echo==============================================================================%C_RESET%
echo.
reg add "HKLM\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://google.com" /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://google.com" /f >nul
echo %C_VERDE%[SUCESSO] uBlock Origin Lite configurado!%C_RESET%
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatA_Menu


:: ============================================================================
::                    CATEGORIA B - VERIFICACAO E REPARO
:: ============================================================================
:CatB_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA B ^| Verificacao e Reparo do Sistema
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS AS ACOES (sequencial)%C_RESET%
echo.
echo     [1] SFC /Scannow (reparar arquivos do sistema)
echo     [2] DISM /CheckHealth (verificar saude)
echo     [3] DISM /ScanHealth (escaneamento profundo)
echo     [4] DISM /RestoreHealth (restaurar imagem)
echo     [5] DISM /StartComponentCleanup (limpar componentes)
echo     [6] Chkdsk /f (verificar e corrigir erros)
echo     [7] Chkdsk /r (recuperar setores defeituosos)
echo     [8] Bootrec (reparar inicializacao MBR/BCD)
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatB_Todas
if "%OPC%"=="2"  goto CatB_1
if "%OPC%"=="3"  goto CatB_2
if "%OPC%"=="4"  goto CatB_3
if "%OPC%"=="5"  goto CatB_4
if "%OPC%"=="6"  goto CatB_5
if "%OPC%"=="7"  goto CatB_6
if "%OPC%"=="8"  goto CatB_7
if "%OPC%"=="9"  goto CatB_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatB_Menu

:CatB_Todas
set "BATCH_MODE=1"
call :CatB_1
call :CatB_2
call :CatB_3
call :CatB_4
call :CatB_5
call :CatB_6
call :CatB_7
call :CatB_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Todas as verificacoes concluidas!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_1
cls
echo %C_CIANO%==============================================================================
echo    SFC /Scannow - Reparar arquivos do sistema
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando sfc /scannow >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Uma nova janela sera aberta para acompanhar o progresso.%C_RESET%
echo %C_AMARELO%Aguardando o termino para continuar...%C_RESET%
echo.
start "SFC /Scannow" /wait cmd /c "sfc /scannow & echo. & echo Pressione qualquer tecla para fechar... & pause >nul"
echo.
echo %C_VERDE%[OK] SFC /Scannow finalizado.%C_RESET%
echo [%date% %time%] [INFO] SFC /Scannow executado >> "!LOG_PATH!"
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_2
cls
echo %C_CIANO%==============================================================================
echo    DISM /CheckHealth - Verificar saude da imagem
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando DISM CheckHealth >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Uma nova janela sera aberta para acompanhar o progresso.%C_RESET%
echo.
start "DISM CheckHealth" /wait cmd /c "DISM /Online /Cleanup-Image /CheckHealth & echo. & echo Pressione qualquer tecla para fechar... & pause >nul"
echo.
echo %C_VERDE%[OK] DISM CheckHealth finalizado.%C_RESET%
echo [%date% %time%] [INFO] DISM CheckHealth executado >> "!LOG_PATH!"
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_3
cls
echo %C_CIANO%==============================================================================
echo    DISM /ScanHealth - Escaneamento profundo
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando DISM ScanHealth >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Uma nova janela sera aberta para acompanhar o progresso.%C_RESET%
echo.
start "DISM ScanHealth" /wait cmd /c "DISM /Online /Cleanup-Image /ScanHealth & echo. & echo Pressione qualquer tecla para fechar... & pause >nul"
echo.
echo %C_VERDE%[OK] DISM ScanHealth finalizado.%C_RESET%
echo [%date% %time%] [INFO] DISM ScanHealth executado >> "!LOG_PATH!"
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_4
cls
echo %C_CIANO%==============================================================================
echo    DISM /RestoreHealth - Restaurar imagem do Windows
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando DISM RestoreHealth >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Uma nova janela sera aberta para acompanhar o progresso.%C_RESET%
echo.
start "DISM RestoreHealth" /wait cmd /c "DISM /Online /Cleanup-Image /RestoreHealth & echo. & echo Pressione qualquer tecla para fechar... & pause >nul"
echo.
echo %C_VERDE%[OK] DISM RestoreHealth finalizado.%C_RESET%
echo [%date% %time%] [INFO] DISM RestoreHealth executado >> "!LOG_PATH!"
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_5
cls
echo %C_CIANO%==============================================================================
echo    DISM /StartComponentCleanup - Limpar componentes corrompidos
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando DISM ComponentCleanup >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Uma nova janela sera aberta para acompanhar o progresso.%C_RESET%
echo.
start "DISM ComponentCleanup" /wait cmd /c "DISM /Online /Cleanup-Image /StartComponentCleanup & echo. & echo Pressione qualquer tecla para fechar... & pause >nul"
echo.
echo %C_VERDE%[OK] DISM ComponentCleanup finalizado.%C_RESET%
echo [%date% %time%] [INFO] DISM ComponentCleanup executado >> "!LOG_PATH!"
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_6
cls
echo %C_CIANO%==============================================================================
echo    Chkdsk /f - Verificar e corrigir erros do disco
echo==============================================================================%C_RESET%
echo %C_AMARELO%[AVISO] Isso agendara a verificacao na proxima reinicializacao.%C_RESET%
echo [%date% %time%] [INFO] Executando chkdsk /f >> "!LOG_PATH!"
chkdsk /f C:
echo %C_AMARELO%Agendado. Reinicie o PC para executar a verificacao.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_7
cls
echo %C_CIANO%==============================================================================
echo    Chkdsk /r - Recuperar setores defeituosos
echo==============================================================================%C_RESET%
echo %C_AMARELO%[AVISO] Isso agendara a verificacao completa na proxima reinicializacao.%C_RESET%
echo [%date% %time%] [INFO] Executando chkdsk /r >> "!LOG_PATH!"
chkdsk /r C:
echo %C_AMARELO%Agendado. Reinicie o PC para executar.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu

:CatB_8
cls
echo %C_CIANO%==============================================================================
echo    Bootrec - Reparar inicializacao (MBR/BCD)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando bootrec >> "!LOG_PATH!"
bootrec /fixmbr
bootrec /fixboot
bootrec /rebuildbcd
if "!BATCH_MODE!"=="1" goto :EOF
echo.
echo Pressione qualquer tecla...
pause >nul
goto CatB_Menu


:: ============================================================================
::                         CATEGORIA C - LIMPEZA PROFUNDA
:: ============================================================================
:CatC_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA C ^| Limpeza Profunda do Sistema
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS AS ACOES (sequencial)%C_RESET%
echo.
echo     [1] Limpar TEMP do Usuario
echo     [2] Limpar TEMP do Sistema
echo     [3] Limpar Prefetch
echo     [4] Limpar Cache de Atualizacoes (SoftwareDistribution)
echo     [5] Limpar Logs do Windows (Event Viewer)
echo     [6] Limpar Lixeira (Recycle Bin)
echo     [7] CleanMgr - Limpeza de disco automatizada
echo     [8] Desativar Hibernacao + limpar hiberfil.sys
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatC_Todas
if "%OPC%"=="2"  goto CatC_1
if "%OPC%"=="3"  goto CatC_2
if "%OPC%"=="4"  goto CatC_3
if "%OPC%"=="5"  goto CatC_4
if "%OPC%"=="6"  goto CatC_5
if "%OPC%"=="7"  goto CatC_6
if "%OPC%"=="8"  goto CatC_7
if "%OPC%"=="9"  goto CatC_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatC_Menu

:CatC_Todas
set "BATCH_MODE=1"
echo %C_AMARELO%[1/8] TEMP Usuario...%C_RESET% & call :CatC_1
echo %C_AMARELO%[2/8] TEMP Sistema...%C_RESET% & call :CatC_2
echo %C_AMARELO%[3/8] Prefetch...%C_RESET% & call :CatC_3
echo %C_AMARELO%[4/8] Cache Atualizacoes...%C_RESET% & call :CatC_4
echo %C_AMARELO%[5/8] Logs Windows...%C_RESET% & call :CatC_5
echo %C_AMARELO%[6/8] Lixeira...%C_RESET% & call :CatC_6
echo %C_AMARELO%[7/8] CleanMgr...%C_RESET% & call :CatC_7
echo %C_AMARELO%[8/8] Hibernacao...%C_RESET% & call :CatC_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Limpeza completa finalizada!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_1
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando TEMP do Usuario
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando %%TEMP%% >> "!LOG_PATH!"
del /q /f /s "%TEMP%\*" >nul 2>&1
for /d %%d in ("%TEMP%\*") do rmdir /s /q "%%d" >nul 2>&1
echo %C_VERDE%[OK] TEMP do usuario limpo.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_2
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando TEMP do Sistema
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando Windows\Temp >> "!LOG_PATH!"
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%d in ("C:\Windows\Temp\*") do rmdir /s /q "%%d" >nul 2>&1
echo %C_VERDE%[OK] TEMP do sistema limpo.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_3
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando Prefetch
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando Prefetch >> "!LOG_PATH!"
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
echo %C_VERDE%[OK] Prefetch limpo.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_4
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando Cache de Atualizacoes
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando SoftwareDistribution >> "!LOG_PATH!"
echo.
echo %C_AMARELO%[1/4] Parando servicos Windows Update...%C_RESET%
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
echo %C_VERDE%  Servicos parados.%C_RESET%
echo.
echo %C_AMARELO%[2/4] Excluindo arquivos de cache de atualizacao...%C_RESET%
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%d in ("C:\Windows\SoftwareDistribution\Download\*") do rmdir /s /q "%%d" >nul 2>&1
echo %C_VERDE%  Arquivos excluidos.%C_RESET%
echo.
echo %C_AMARELO%[3/4] Reiniciando servicos Windows Update...%C_RESET%
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo %C_VERDE%  Servicos reiniciados.%C_RESET%
echo.
echo %C_AMARELO%[4/4] Finalizado.%C_RESET%
echo %C_VERDE%[OK] Cache de atualizacoes limpo.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_5
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando Logs do Windows (Event Viewer)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando logs do Event Viewer >> "!LOG_PATH!"
PowerShell -Command "wevtutil el | ForEach-Object { try { wevtutil cl \"$_\" } catch {} }" >nul 2>&1
echo %C_VERDE%[OK] Logs do Windows limpos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_6
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Limpando Lixeira (Recycle Bin)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Limpando Recycle Bin >> "!LOG_PATH!"
PowerShell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Lixeira limpa.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_7
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    CleanMgr - Limpeza de disco automatizada
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Executando CleanMgr >> "!LOG_PATH!"
echo %C_AMARELO%Selecionando categorias de limpeza...%C_RESET%
PowerShell -Command "Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches' -ErrorAction SilentlyContinue | ForEach-Object { New-ItemProperty -Path $_.PSPath -Name StateFlags0001 -Value 2 -PropertyType DWORD -Force | Out-Null }"
echo %C_AMARELO%Executando CleanMgr...%C_RESET%
cleanmgr /sagerun:1 >nul 2>&1
echo %C_AMARELO%Limpando lixeira...%C_RESET%
PowerShell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] CleanMgr executado e lixeira limpa.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu

:CatC_8
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativar Hibernacao + Limpar hiberfil.sys
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando hibernacao >> "!LOG_PATH!"
powercfg /hibernate off
echo %C_VERDE%[OK] Hibernacao desativada. Espaco liberado: varios GB.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatC_Menu


:: ============================================================================
::                     CATEGORIA D - OTIMIZACAO PERFORMANCE
:: ============================================================================
:CatD_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA D ^| Otimizacao de Performance
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS AS ACOES (sequencial)%C_RESET%
echo.
echo     [1] Plano de Energia: Alto Desempenho
echo     [2] Plano de Energia: Desempenho Maximo
echo     [3] Desativar SysMain (Superfetch)
echo     [4] Desativar Windows Search (Indexacao)
echo     [5] Acelerar Menus (MenuShowDelay=0)
echo     [6] Desativar Animacoes Visuais
echo     [7] Desativar GameDVR / Game Bar
echo     [8] Desativar Nagle Algorithm (menos latencia)
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatD_Todas
if "%OPC%"=="2"  goto CatD_1
if "%OPC%"=="3"  goto CatD_2
if "%OPC%"=="4"  goto CatD_3
if "%OPC%"=="5"  goto CatD_4
if "%OPC%"=="6"  goto CatD_5
if "%OPC%"=="7"  goto CatD_6
if "%OPC%"=="8"  goto CatD_7
if "%OPC%"=="9"  goto CatD_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatD_Menu

:CatD_Todas
set "BATCH_MODE=1"
echo %C_AMARELO%[1/8] Plano Alto Desempenho...%C_RESET% & call :CatD_1
echo %C_AMARELO%[2/8] Plano Desempenho Maximo...%C_RESET% & call :CatD_2
echo %C_AMARELO%[3/8] SysMain...%C_RESET% & call :CatD_3
echo %C_AMARELO%[4/8] Windows Search...%C_RESET% & call :CatD_4
echo %C_AMARELO%[5/8] MenuShowDelay...%C_RESET% & call :CatD_5
echo %C_AMARELO%[6/8] Animacoes...%C_RESET% & call :CatD_6
echo %C_AMARELO%[7/8] GameDVR...%C_RESET% & call :CatD_7
echo %C_AMARELO%[8/8] Nagle Algorithm...%C_RESET% & call :CatD_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Todas as otimizacoes de performance aplicadas!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_1
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Ativando Plano de Energia: Alto Desempenho
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Ativando Alto Desempenho >> "!LOG_PATH!"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c >nul 2>&1
echo %C_VERDE%[OK] Plano Alto Desempenho ativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_2
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Ativando Plano de Energia: Desempenho Maximo
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Ativando Desempenho Maximo >> "!LOG_PATH!"
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
echo %C_VERDE%[OK] Plano Desempenho Maximo ativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_3
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando SysMain (Superfetch)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando SysMain >> "!LOG_PATH!"
sc config SysMain start=disabled >nul 2>&1
sc stop SysMain >nul 2>&1
echo %C_VERDE%[OK] SysMain desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_4
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Windows Search (Indexacao)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Windows Search >> "!LOG_PATH!"
sc config WSearch start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1
echo %C_VERDE%[OK] Windows Search desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_5
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Acelerando Menus (MenuShowDelay=0)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Acelerando menus >> "!LOG_PATH!"
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] Menus acelerados (delay = 0).%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_6
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Animacoes Visuais
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando animacoes >> "!LOG_PATH!"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9032078010000000 /f >nul 2>&1
echo %C_VERDE%[OK] Animacoes desativadas.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_7
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando GameDVR / Game Bar
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando GameDVR >> "!LOG_PATH!"
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] GameDVR desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu

:CatD_8
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Nagle Algorithm (reduz latencia)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Nagle >> "!LOG_PATH!"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableTaskOffload /t REG_DWORD /d 1 /f >nul 2>&1
echo %C_VERDE%[OK] Nagle desativado (menos latencia).%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatD_Menu


:: ============================================================================
::                      CATEGORIA E - PRIVACIDADE E TELEMETRIA
:: ============================================================================
:CatE_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA E ^| Privacidade e Telemetria
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS AS ACOES (sequencial)%C_RESET%
echo.
echo     [1] Desativar Telemetria (AllowTelemetry=0)
echo     [2] Desativar Servico DiagTrack
echo     [3] Desativar Servico dmwappushservice
echo     [4] Desativar Cortana
echo     [5] Desativar Bing na Busca do Windows
echo     [6] Desativar Sugestoes e Anuncios
echo     [7] Desativar Feedback e Diagnosticos
echo     [8] Desativar Rastreamento de Localizacao
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatE_Todas
if "%OPC%"=="2"  goto CatE_1
if "%OPC%"=="3"  goto CatE_2
if "%OPC%"=="4"  goto CatE_3
if "%OPC%"=="5"  goto CatE_4
if "%OPC%"=="6"  goto CatE_5
if "%OPC%"=="7"  goto CatE_6
if "%OPC%"=="8"  goto CatE_7
if "%OPC%"=="9"  goto CatE_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatE_Menu

:CatE_Todas
set "BATCH_MODE=1"
echo %C_AMARELO%[1/8] Telemetria...%C_RESET% & call :CatE_1
echo %C_AMARELO%[2/8] DiagTrack...%C_RESET% & call :CatE_2
echo %C_AMARELO%[3/8] dmwappushservice...%C_RESET% & call :CatE_3
echo %C_AMARELO%[4/8] Cortana...%C_RESET% & call :CatE_4
echo %C_AMARELO%[5/8] Bing na Busca...%C_RESET% & call :CatE_5
echo %C_AMARELO%[6/8] Sugestoes...%C_RESET% & call :CatE_6
echo %C_AMARELO%[7/8] Feedback...%C_RESET% & call :CatE_7
echo %C_AMARELO%[8/8] Localizacao...%C_RESET% & call :CatE_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Todas as configuracoes de privacidade aplicadas!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_1
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Telemetria (AllowTelemetry=0)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando telemetria >> "!LOG_PATH!"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] Telemetria desativada.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_2
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Servico DiagTrack
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando DiagTrack >> "!LOG_PATH!"
sc config DiagTrack start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
echo %C_VERDE%[OK] DiagTrack desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_3
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Servico dmwappushservice
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando dmwappushservice >> "!LOG_PATH!"
sc config dmwappushservice start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
echo %C_VERDE%[OK] dmwappushservice desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_4
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Cortana
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Cortana >> "!LOG_PATH!"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] Cortana desativada.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_5
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Bing na Busca do Windows
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Bing na busca >> "!LOG_PATH!"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v BingSearchEnabled /t REG_DWORD /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] Bing na busca desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_6
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Sugestoes e Anuncios
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando sugestoes >> "!LOG_PATH!"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul 2>&1
echo %C_VERDE%[OK] Sugestoes e anuncios desativados.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_7
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Feedback e Diagnosticos
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando feedback >> "!LOG_PATH!"
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDiagnosticLogCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v LimitDumpCollection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v AITEnable /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul 2>&1
echo %C_VERDE%[OK] Feedback e diagnosticos desativados.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu

:CatE_8
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Rastreamento de Localizacao
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando localizacao >> "!LOG_PATH!"
sc config lfsvc start=disabled >nul 2>&1
sc stop lfsvc >nul 2>&1
sc config MapsBroker start=disabled >nul 2>&1
sc stop MapsBroker >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v DisableLocation /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f >nul 2>&1
echo %C_VERDE%[OK] Rastreamento de localizacao desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatE_Menu


:: ============================================================================
::                       CATEGORIA F - REMOCAO DE BLOATWARE
:: ============================================================================
:CatF_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA F ^| Remocao de Bloatware (Apps Pre-instalados)
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] REMOVER TODOS OS BLOATWARE (sequencial)%C_RESET%
echo.
echo     [1] Remover Apps Xbox (Game Bar, Console, etc)
echo     [2] Remover Skype
echo     [3] Remover Apps Bing (News, Weather, Sports)
echo     [4] Remover Zune (Music, Video)
echo     [5] Remover Office Hub
echo     [6] Remover Solitaire, People, LinkedIn
echo     [7] Remover TikTok, Instagram, Facebook (Links)
echo     [8] Remover Apps PRE-INSTALADAS para todos os usuarios
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatF_Todas
if "%OPC%"=="2"  goto CatF_1
if "%OPC%"=="3"  goto CatF_2
if "%OPC%"=="4"  goto CatF_3
if "%OPC%"=="5"  goto CatF_4
if "%OPC%"=="6"  goto CatF_5
if "%OPC%"=="7"  goto CatF_6
if "%OPC%"=="8"  goto CatF_7
if "%OPC%"=="9"  goto CatF_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatF_Menu

:CatF_Todas
set "BATCH_MODE=1"
echo %C_AMARELO%[1/8] Xbox Apps...%C_RESET% & call :CatF_1
echo %C_AMARELO%[2/8] Skype...%C_RESET% & call :CatF_2
echo %C_AMARELO%[3/8] Bing Apps...%C_RESET% & call :CatF_3
echo %C_AMARELO%[4/8] Zune Music/Video...%C_RESET% & call :CatF_4
echo %C_AMARELO%[5/8] Office Hub...%C_RESET% & call :CatF_5
echo %C_AMARELO%[6/8] Solitaire, People, LinkedIn...%C_RESET% & call :CatF_6
echo %C_AMARELO%[7/8] TikTok, Instagram, Facebook...%C_RESET% & call :CatF_7
echo %C_AMARELO%[8/8] Apps Pre-Instaladas...%C_RESET% & call :CatF_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Remocao de bloatware concluida!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_1
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Apps Xbox
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Xbox apps >> "!LOG_PATH!"
PowerShell -Command "Get-AppxPackage -AllUsers *xbox* | Remove-AppxPackage -ErrorAction SilentlyContinue; Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like '*xbox*' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Apps Xbox removidos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_2
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Skype
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Skype >> "!LOG_PATH!"
PowerShell -Command "Get-AppxPackage -AllUsers *skype* | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Skype removido.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_3
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Apps Bing (News, Weather, Sports)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Bing apps >> "!LOG_PATH!"
PowerShell -Command "Get-AppxPackage -AllUsers *bing* | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Apps Bing removidos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_4
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Zune (Music, Video)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Zune apps >> "!LOG_PATH!"
PowerShell -Command "Get-AppxPackage -AllUsers *zune* | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Zune Music e Video removidos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_5
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Office Hub
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Office Hub >> "!LOG_PATH!"
PowerShell -Command "Get-AppxPackage -AllUsers *officehub* | Remove-AppxPackage -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Office Hub removido.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_6
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Solitaire, People, LinkedIn
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo Solitaire, People, LinkedIn >> "!LOG_PATH!"
PowerShell -Command "@('solitaire','people','linkedin') | ForEach-Object { Get-AppxPackage -AllUsers *$_* | Remove-AppxPackage -ErrorAction SilentlyContinue }" >nul 2>&1
echo %C_VERDE%[OK] Apps removidos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_7
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo TikTok, Instagram, Facebook
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo social media links >> "!LOG_PATH!"
PowerShell -Command "@('tiktok','instagram','facebook') | ForEach-Object { Get-AppxPackage -AllUsers *$_* | Remove-AppxPackage -ErrorAction SilentlyContinue }" >nul 2>&1
echo %C_VERDE%[OK] Social media links removidos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu

:CatF_8
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Removendo Apps Pre-Instaladas (Todos os Usuarios)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Removendo provisionadas >> "!LOG_PATH!"
PowerShell -Command "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -match 'xbox|bing|zune|officehub|skype|solitaire|people|linkedin|spotify|tiktok|instagram|facebook|mixedreality|windowscommunicationsapps' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue" >nul 2>&1
echo %C_VERDE%[OK] Apps provisionadas removidas (nao voltam em novos usuarios).%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatF_Menu


:: ============================================================================
::                       CATEGORIA G - OTIMIZACAO DE REDE
:: ============================================================================
:CatG_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA G ^| Otimizacao de Rede
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS AS ACOES (sequencial)%C_RESET%
echo.
echo     [1] Flush DNS (limpar cache DNS)
echo     [2] Reset TCP/IP Stack
echo     [3] Reset Winsock
echo     [4] Reset Firewall do Windows
echo     [5] Renovar IP (release / renew)
echo     [6] Desativar TCP Auto-Tuning
echo     [7] Aumentar MaxUserPort (65534 portas)
echo     [8] Ativar TCP NoDelay + Reduzir Latencia
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatG_Todas
if "%OPC%"=="2"  goto CatG_1
if "%OPC%"=="3"  goto CatG_2
if "%OPC%"=="4"  goto CatG_3
if "%OPC%"=="5"  goto CatG_4
if "%OPC%"=="6"  goto CatG_5
if "%OPC%"=="7"  goto CatG_6
if "%OPC%"=="8"  goto CatG_7
if "%OPC%"=="9"  goto CatG_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatG_Menu

:CatG_Todas
set "BATCH_MODE=1"
call :CatG_1
call :CatG_2
call :CatG_3
call :CatG_4
call :CatG_5
call :CatG_6
call :CatG_7
call :CatG_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Otimizacao de rede concluida! Pode ser necessario reiniciar.%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_1
cls
echo %C_CIANO%==============================================================================
echo    Flush DNS - Limpando Cache DNS
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Flush DNS >> "!LOG_PATH!"
ipconfig /flushdns
echo %C_VERDE%[OK] Cache DNS limpo.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_2
cls
echo %C_CIANO%==============================================================================
echo    Reset TCP/IP Stack
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Reset TCP/IP >> "!LOG_PATH!"
netsh int ip reset
echo %C_VERDE%[OK] TCP/IP resetado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_3
cls
echo %C_CIANO%==============================================================================
echo    Reset Winsock
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Reset Winsock >> "!LOG_PATH!"
netsh winsock reset
echo %C_VERDE%[OK] Winsock resetado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_4
cls
echo %C_CIANO%==============================================================================
echo    Reset Firewall do Windows
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Reset Firewall >> "!LOG_PATH!"
netsh advfirewall reset
echo %C_VERDE%[OK] Firewall resetado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_5
cls
echo %C_CIANO%==============================================================================
echo    Renovar IP (Release / Renew)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Renovando IP >> "!LOG_PATH!"
ipconfig /release
ipconfig /renew
echo %C_VERDE%[OK] IP renovado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_6
cls
echo %C_CIANO%==============================================================================
echo    Desativando TCP Auto-Tuning
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando TCP Auto-Tuning >> "!LOG_PATH!"
netsh int tcp set global autotuninglevel=disabled
echo %C_VERDE%[OK] TCP Auto-Tuning desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_7
cls
echo %C_CIANO%==============================================================================
echo    Aumentando MaxUserPort para 65534
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Aumentando MaxUserPort >> "!LOG_PATH!"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v MaxUserPort /t REG_DWORD /d 65534 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TcpTimedWaitDelay /t REG_DWORD /d 30 /f >nul 2>&1
echo %C_VERDE%[OK] MaxUserPort=65534, TcpTimedWaitDelay=30 segundos.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu

:CatG_8
cls
echo %C_CIANO%==============================================================================
echo    Ativando TCP NoDelay e Reduzindo Latencia
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Aplicando NoDelay >> "!LOG_PATH!"
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces" /v TCPNoDelay /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v DisableLargeMTU /t REG_DWORD /d 1 /f >nul 2>&1
echo %C_VERDE%[OK] Configuracoes de baixa latencia aplicadas.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatG_Menu


:: ============================================================================
::                     CATEGORIA H - SERVICOS DESNECESSARIOS
:: ============================================================================
:CatH_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA H ^| Servicos Desnecessarios
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] DESATIVAR TODOS OS SERVICOS (sequencial)%C_RESET%
echo.
echo     [1] SysMain (Superfetch)
echo     [2] Xbox Services (Auth, Networking, Game Bar)
echo     [3] DiagTrack (Telemetria)
echo     [4] dmwappushservice (WAP Push)
echo     [5] WMP Network Sharing
echo     [6] TabletInputService (Entrada Tablet/Caneta)
echo     [7] Fax, Phone, Wallet
echo     [8] Windows Search (Indexacao)
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T12345678V /n /m "Escolha (T, 1-8 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatH_Todas
if "%OPC%"=="2"  goto CatH_1
if "%OPC%"=="3"  goto CatH_2
if "%OPC%"=="4"  goto CatH_3
if "%OPC%"=="5"  goto CatH_4
if "%OPC%"=="6"  goto CatH_5
if "%OPC%"=="7"  goto CatH_6
if "%OPC%"=="8"  goto CatH_7
if "%OPC%"=="9"  goto CatH_8
if "%OPC%"=="10" goto MenuPrincipal
goto CatH_Menu

:CatH_Todas
set "BATCH_MODE=1"
echo %C_AMARELO%[1/8] SysMain...%C_RESET% & call :CatH_1
echo %C_AMARELO%[2/8] Xbox Services...%C_RESET% & call :CatH_2
echo %C_AMARELO%[3/8] DiagTrack...%C_RESET% & call :CatH_3
echo %C_AMARELO%[4/8] dmwappushservice...%C_RESET% & call :CatH_4
echo %C_AMARELO%[5/8] WMP Network...%C_RESET% & call :CatH_5
echo %C_AMARELO%[6/8] TabletInputService...%C_RESET% & call :CatH_6
echo %C_AMARELO%[7/8] Fax, Phone, Wallet...%C_RESET% & call :CatH_7
echo %C_AMARELO%[8/8] Windows Search...%C_RESET% & call :CatH_8
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Todos os servicos foram desativados!%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_1
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando SysMain (Superfetch)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando SysMain >> "!LOG_PATH!"
sc config SysMain start=disabled >nul 2>&1
sc stop SysMain >nul 2>&1
echo %C_VERDE%[OK] SysMain desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_2
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Xbox Services (Auth, Networking)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Xbox servicos >> "!LOG_PATH!"
sc config XblAuthManager start=disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1
sc config XboxNetApiSvc start=disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XboxGipSvc start=disabled >nul 2>&1
sc stop XboxGipSvc >nul 2>&1
echo %C_VERDE%[OK] Servicos Xbox desativados.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_3
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando DiagTrack (Telemetria)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando DiagTrack >> "!LOG_PATH!"
sc config DiagTrack start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
echo %C_VERDE%[OK] DiagTrack desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_4
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando dmwappushservice (WAP Push)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando dmwappushservice >> "!LOG_PATH!"
sc config dmwappushservice start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
echo %C_VERDE%[OK] dmwappushservice desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_5
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando WMP Network Sharing
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando WMP Network >> "!LOG_PATH!"
sc config WMPNetworkSvc start=disabled >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1
echo %C_VERDE%[OK] WMP Network Sharing desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_6
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando TabletInputService
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando TabletInput >> "!LOG_PATH!"
sc config TabletInputService start=disabled >nul 2>&1
sc stop TabletInputService >nul 2>&1
echo %C_VERDE%[OK] TabletInputService desativado (se nao usar touch/pen).%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_7
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Fax, Phone, Wallet
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Fax/Phone/Wallet >> "!LOG_PATH!"
sc config Fax start=disabled >nul 2>&1
sc stop Fax >nul 2>&1
sc config PhoneSvc start=disabled >nul 2>&1
sc stop PhoneSvc >nul 2>&1
sc config WalletService start=disabled >nul 2>&1
sc stop WalletService >nul 2>&1
echo %C_VERDE%[OK] Fax, Phone e Wallet desativados.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu

:CatH_8
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%==============================================================================
echo    Desativando Windows Search (Indexacao)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Desativando Windows Search >> "!LOG_PATH!"
sc config WSearch start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1
echo %C_VERDE%[OK] Windows Search desativado.%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatH_Menu


:: ============================================================================
::                    CATEGORIA I - FERRAMENTAS DE DIAGNOSTICO
:: ============================================================================
:CatI_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA I ^| Ferramentas de Diagnostico
echo==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[T] EXECUTAR TODAS (sequencial)%C_RESET%
echo.
echo     [1] Informacoes do Sistema (OS, RAM, Tipo)
echo     [2] Espaco em Disco (todas as unidades)
echo     [3] Integridade da Bateria (Relatorio HTML)
echo     [4] Erros Criticos do Sistema (Event Viewer)
echo     [5] Tempo de Atividade do Sistema
echo     [6] Lista de Drivers Instalados
echo     [7] Top 10 Processos por Memoria
echo     [8] Relatorio Completo (salva em .txt)
echo     %C_AMARELO%[9] Analisar Tamanho das Pastas do Usuario (Desktop, Docs, etc)%C_RESET%
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                              %C_AMARELO%[V] Voltar ao Menu%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c T123456789V /n /m "Escolha (T, 1-9 ou V): "
set "OPC=%errorlevel%"

if "%OPC%"=="1"  goto CatI_Todas
if "%OPC%"=="2"  goto CatI_1
if "%OPC%"=="3"  goto CatI_2
if "%OPC%"=="4"  goto CatI_3
if "%OPC%"=="5"  goto CatI_4
if "%OPC%"=="6"  goto CatI_5
if "%OPC%"=="7"  goto CatI_6
if "%OPC%"=="8"  goto CatI_7
if "%OPC%"=="9"  goto CatI_8
if "%OPC%"=="10" goto CatI_9
if "%OPC%"=="11" goto MenuPrincipal
goto CatI_Menu

:CatI_Todas
set "BATCH_MODE=1"
call :CatI_1
call :CatI_2
call :CatI_3
call :CatI_4
call :CatI_5
call :CatI_6
call :CatI_7
call :CatI_8
call :CatI_9
set "BATCH_MODE=0"
echo.
echo %C_VERDE%Diagnostico completo! Verifique as informacoes acima.%C_RESET%
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_1
cls
echo %C_CIANO%==============================================================================
echo    Informacoes do Sistema
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Coletando info do sistema >> "!LOG_PATH!"
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"
echo.
echo %C_AMARELO%Windows Version:%C_RESET%
wmic os get Caption,Version /format:table 2>nul
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_2
cls
echo %C_CIANO%==============================================================================
echo    Espaco em Disco
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Coletando espaco em disco >> "!LOG_PATH!"
echo.
wmic logicaldisk get size,freespace,caption /format:table
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_3
cls
echo %C_CIANO%==============================================================================
echo    Relatorio de Integridade da Bateria
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Gerando relatorio de bateria >> "!LOG_PATH!"
echo.
powercfg /batteryreport /output "%USERPROFILE%\Desktop\battery_report.html"
echo %C_VERDE%[OK] Relatorio salvo em: %USERPROFILE%\Desktop\battery_report.html%C_RESET%
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_4
cls
echo %C_CIANO%==============================================================================
echo    Erros Criticos do Sistema (Event Viewer)
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Coletando erros criticos >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Ultimos 10 erros criticos:%C_RESET%
wevtutil qe System /c:10 /f:text /q:"*[System[Level=2]]" 2>nul
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_5
cls
echo %C_CIANO%==============================================================================
echo    Tempo de Atividade do Sistema
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Verificando uptime >> "!LOG_PATH!"
echo.
net stats workstation | find "Statistics since"
echo.
wmic path Win32_OperatingSystem get LastBootUpTime 2>nul
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_6
cls
echo %C_CIANO%==============================================================================
echo    Lista de Drivers Instalados
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Listando drivers >> "!LOG_PATH!"
echo.
driverquery /v /fo table | findstr /B /C:"Display" /C:"Module Name" /C:"Driver"
echo.
echo %C_AMARELO%Total de drivers instalados:%C_RESET%
driverquery | find /c /v ""
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_7
cls
echo %C_CIANO%==============================================================================
echo    Top 10 Processos por Consumo de Memoria
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Listando processos >> "!LOG_PATH!"
echo.
PowerShell -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Name, @{N='MB';E={[math]::Round($_.WorkingSet64/1MB)}}, Description | Format-Table -AutoSize"
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_8
cls
echo %C_CIANO%==============================================================================
echo    Relatorio Completo do Sistema
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Gerando relatorio completo >> "!LOG_PATH!"
set "REPORT=%USERPROFILE%\Desktop\Relatorio_Sistema_%date:~-4,4%%date:~-10,2%%date:~-7,2%.txt"
echo.
echo Gerando relatorio, aguarde...
(
    echo ========================================
    echo   RELATORIO COMPLETO DO SISTEMA
    echo   Gerado em: %date% %time%
    echo ========================================
    echo.
    echo ----- INFORMACOES DO SISTEMA -----
    systeminfo
    echo.
    echo ----- ESPACO EM DISCO -----
    wmic logicaldisk get size,freespace,caption
    echo.
    echo ----- TAMANHO DAS PASTAS DO USUARIO -----
    PowerShell -Command "$u=$env:USERPROFILE; $nomes='Desktop','Downloads','Documents','Pictures','Videos','Music'; $total=0; foreach($n in $nomes){$c=$u+'\'+$n; if(Test-Path $c){$t=(Get-ChildItem $c -Recurse -File -ErrorAction SilentlyContinue|Measure-Object Length -Sum).Sum; $gb=[math]::Round($t/1GB,2); $total+=$t; Write-Host ('  {0,-12} {1,8:F2} GB'-f($n+':'),$gb)}else{Write-Host ('  {0,-12} {1,8}'-f($n+':'),'---')}}; Write-Host ('  TOTAL GERAL:{0,8:F2} GB'-f[math]::Round($total/1GB,2))"
    echo.
    echo ----- PROCESSOS TOP 10 MEMORIA -----
    PowerShell -Command "Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 10 Name, @{N='MB';E={[math]::Round($_.WorkingSet64/1MB)}} | Format-Table -AutoSize"
    echo.
    echo ----- DRIVERS -----
    driverquery /v
    echo.
    echo ----- ULTIMOS 10 ERROS CRITICOS -----
    wevtutil qe System /c:10 /f:text /q:"*[System[Level=2]]"
) > "%REPORT%"
echo %C_VERDE%[OK] Relatorio salvo em: %REPORT%%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu

:CatI_9
cls
echo %C_CIANO%==============================================================================
echo    Analisar Tamanho das Pastas do Usuario
echo==============================================================================%C_RESET%
echo [%date% %time%] [INFO] Analisando pastas do usuario >> "!LOG_PATH!"
echo.
echo %C_AMARELO%Calculando...%C_RESET%
echo.
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Desktop -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Desktop: '+[math]::Round($t/1GB,2)+' GB')"
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Downloads -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Downloads: '+[math]::Round($t/1GB,2)+' GB')"
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Documents -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Documentos: '+[math]::Round($t/1GB,2)+' GB')"
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Pictures -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Imagens: '+[math]::Round($t/1GB,2)+' GB')"
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Videos -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Videos: '+[math]::Round($t/1GB,2)+' GB')"
PowerShell -NoProfile -Command "$t=0; Get-ChildItem $env:USERPROFILE\Music -Recurse -File -ErrorAction 0|ForEach-Object{$t+=$_.Length}; Write-Host ('  Musicas: '+[math]::Round($t/1GB,2)+' GB')"
echo.
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatI_Menu


:: ============================================================================
::                   CATEGORIA J - ATIVACAO (ORIGINAL)
:: ============================================================================
:CatJ_Menu
cls
echo %C_CIANO%==============================================================================
echo    CATEGORIA J ^| Ativacao Windows/Office (MAS Script)
echo==============================================================================%C_RESET%
echo.
echo %C_AMARELO%[AVISO] Isso abrira o script de ativacao online da Microsoft.%C_RESET%
echo.
echo Deseja continuar?
echo.
echo     [1] Sim, executar ativacao
echo     [V] Voltar ao menu principal
echo.
choice /c 1V /n /m "Escolha: "
set "OPC=%errorlevel%"
if "%OPC%"=="1" goto RunActivation
if "%OPC%"=="2" goto MenuPrincipal
goto CatJ_Menu


:: ============================================================================
::                         FUNCOES ORIGINAIS (WINGET)
:: ============================================================================
:RunWinGet
cls
echo %C_CIANO%==============================================================================
echo    Instalacao via WinGet
echo==============================================================================%C_RESET%
echo [-] Processando: !NAME%IDX%! (!ID%IDX%!)
echo.
echo [%date% %time%] [INFO] Instalando !NAME%IDX%! >> "!LOG_PATH!"

if "!IDX!"=="7" (
    winget install --id !ID%IDX%! -e --accept-package-agreements --accept-source-agreements --silent --override "/s"
) else (
    winget install --id !ID%IDX%! -e --accept-package-agreements --accept-source-agreements
)
set "EC=!errorlevel!"

echo.
if "!EC!"=="0" (
    echo %C_VERDE%[SUCESSO] !NAME%IDX%! instalado com exito!%C_RESET%
    echo [%date% %time%] [SUCCESS] !NAME%IDX%! concluido !EC! >> "!LOG_PATH!"
) else if "!EC!"=="2316632124" (
    echo %C_AMARELO%[AVISO] !NAME%IDX%! ja se encontra presente no sistema.%C_RESET%
    echo [%date% %time%] [ALREADY_PRESENT] !NAME%IDX%! ja instalado !EC! >> "!LOG_PATH!"
) else if "!EC!"=="-1978335189" (
    echo %C_VERDE%[ATUALIZADO] !NAME%IDX%! ja esta na versao mais recente.%C_RESET%
    echo [%date% %time%] [UP_TO_DATE] !NAME%IDX%! sem atualizacoes !EC! >> "!LOG_PATH!"
) else (
    echo %C_VERMELHO%[FALHA] Erro ao processar pacote. Codigo: !EC!%C_RESET%
    echo [%date% %time%] [ERROR] Falha em !NAME%IDX%!. Retorno: !EC! >> "!LOG_PATH!"
)
echo.
echo Pressione qualquer tecla para voltar...
pause >nul
goto CatA_Menu


:: ============================================================================
::                         FUNCOES ORIGINAIS (ATIVACAO)
:: ============================================================================
:RunActivation
cls
echo %C_CIANO%==============================================================================
echo    Central de Ativacao Digital
echo==============================================================================%C_RESET%
echo [-] Executando MAS Script via PowerShell...
echo.
echo [%date% %time%] [INFO] Executando MAS Script >> "!LOG_PATH!"
echo %C_AMARELO%Siga as instrucoes na janela que abrir.%C_RESET%
echo.
PowerShell -Command "irm https://get.activated.win | iex"
echo.
echo %C_VERDE%[OK] Processo de ativacao concluido.%C_RESET%
echo.
echo Pressione qualquer tecla para voltar...
pause >nul
goto MenuPrincipal


:: ============================================================================
::                                   SAIR
:: ============================================================================
:Sair
cls
echo %C_CIANO%==============================================================================
echo    Windows Optimizer Toolkit - Notebooks MS
echo==============================================================================%C_RESET%
echo.
echo %C_VERDE%Obrigado por utilizar!%C_RESET%
echo.
echo %C_AMARELO%Log salvo em: %LOG_PATH%%C_RESET%
echo.
echo %C_BRANCO%Desenvolvido por Notebooks MS %C_RESET%
echo.
echo Pressione qualquer tecla para fechar...
pause >nul
exit /b 0
