@echo off
:: ==============================================================================
:: Nome do Arquivo: Toolkit-Tech-PostFormat-Full.bat
:: Desenvolvedor:   Aparecido Alves | Notebooks MS
:: Link Oficial:    https://pages.pro.br
:: Descrição:       Automação unificada pós-formatação via Windows Package Manager.
:: ==============================================================================

setlocal enabledelayedexpansion
chcp 65001 >nul
title Toolkit Técnico - Notebooks MS (Aparecido Alves)

:: Definição de Cores ANSI
set "C_RESET=[0m"
set "C_VERDE=[92m"
set "C_AMARELO=[93m"
set "C_VERMELHO=[91m"
set "C_CIANO=[96m"
set "C_BRANCO=[97m"

:: Validação de Privilégios de Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %C_VERMELHO%[ERRO] Este script requer privilégios de Administrador.%C_RESET%
    echo Por favor, clique com o botão direito e selecione 'Executar como Administrador'.
    echo.
    pause
    exit /b 1
)

:: Validar presença do WinGet
where winget >nul 2>&1
if %errorLevel% neq 0 (
    echo %C_AMARELO%[AVISO] O WinGet não foi detectado neste sistema.%C_RESET%
    echo Abrindo a Microsoft Store para obter o App Installer...
    start ms-windows-store://pdp/?productid=9NBLGGH4NNS1
    echo.
    echo Instale o aplicativo na loja e execute este script novamente.
    pause
    exit /b 1
)

:: Definição de Pastas e Caminhos de Log
set "DL_DIR=%USERPROFILE%\Downloads"
if not exist "%DL_DIR%" set "DL_DIR=%SystemDrive%\Users\%USERNAME%\Downloads"
set "LOG_PATH=C:\Logs\Toolkit-Install.log"

:: Banco de dados de IDs Oficial do WinGet
set "ID1=RARLab.WinRAR"                   & set "NAME1=1. RARLab WinRAR"
set "ID2=CodecGuide.K-LiteCodecPack.Mega" & set "NAME2=2. K-Lite Codec Pack Mega"
set "ID3=VideoLAN.VLC"                    & set "NAME3=3. VLC Media Player"
set "ID4=Foxit.FoxitReader"               & set "NAME4=4. Foxit PDF Reader"
set "ID5=Google.Chrome"                   & set "NAME5=5. Google Chrome"
set "ID6=Mozilla.Firefox.pt-BR"            & set "NAME6=6. Mozilla Firefox (PT-BR Oficial)"
set "ID7=Oracle.JavaRuntimeEnvironment"    & set "NAME7=7. Java SE Runtime Environment (Oracle)"

:MenuPrincipal
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| Suporte Técnico Avançado ^| Contato: (67) 98443-6131
echo==============================================================================%C_RESET%
echo  Técnico Resp:  Aparecido Alves ^| Região: Aquidauana - MS
echo  Log de Saída:  !LOG_PATH!
echo %C_CIANO%==============================================================================%C_RESET%
echo.
echo     %C_VERDE%[A] INSTALAÇÃO AUTOMÁTICA COMPLETA (Opções de 1 a 8 Sequencial)%C_RESET%
echo.
echo     --- SELEÇÃO INDIVIDUAL ---
echo     !NAME1!
echo     !NAME2!
echo     !NAME3!
echo     !NAME4!
echo     !NAME5!
echo     !NAME6!
echo     !NAME7!
echo     8. Instalar Extensão uBlock Origin Lite (Chrome e Edge)
echo     9. Executar Ativação Digital do Windows/Office (MAS Script)
echo.
echo %C_CIANO%==============================================================================%C_RESET%
echo                                                    %C_VERMELHO%[X] FECHAR E SAIR%C_RESET%
echo %C_CIANO%==============================================================================%C_RESET%
echo.

choice /c A123456789X /n /m "Escolha a opção desejada (A, 1-9 ou X): "
set "OP=%errorlevel%"

:: Criar diretório do log se não existir
for /f "delims=" %%i in ("!LOG_PATH!") do set "LOG_DIR=%%~dpi"
if not exist "!LOG_DIR!" mkdir "!LOG_DIR!" >nul 2>&1

:: Mapeamento baseado no retorno exato da variável CHOICE
if "%OP%"=="1"  goto RunBatchInstall
if "%OP%"=="2"  set "IDX=1"  & goto RunWinGet
if "%OP%"=="3"  set "IDX=2"  & goto RunWinGet
if "%OP%"=="4"  set "IDX=3"  & goto RunWinGet
if "%OP%"=="5"  set "IDX=4"  & goto RunWinGet
if "%OP%"=="6"  set "IDX=5"  & goto RunWinGet
if "%OP%"=="7"  set "IDX=6"  & goto RunWinGet
if "%OP%"=="8"  set "IDX=7"  & goto RunWinGet
if "%OP%"=="9"  goto RunUblockChrome
if "%OP%"=="10" goto RunActivation
if "%OP%"=="11" goto RunExit
goto MenuPrincipal

:RunWinGet
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| Instalação de Ferramentas via WinGet
echo==============================================================================%C_RESET%
echo [-] Processando: !NAME%IDX%! (!ID%IDX%!)
echo Monitorando progresso de download e integridade do pacote...
echo ------------------------------------------------------------------------------
echo.

echo [%date% %time%] [INFO] Instalacao unificada disparada para !NAME%IDX%! >> "!LOG_PATH!"

if "!IDX!"=="7" (
    winget install --id !ID%IDX%! -e --accept-package-agreements --accept-source-agreements --silent --override "/s"
) else (
    winget install --id !ID%IDX%! -e --accept-package-agreements --accept-source-agreements
)
set "EC=!errorlevel!"

echo.
echo ------------------------------------------------------------------------------
if "!EC!"=="0" (
    echo %C_VERDE%[SUCESSO] !NAME%IDX%! foi instalado com êxito!%C_RESET%
    echo [%date% %time%] [SUCCESS] !NAME%IDX%! concluido !EC! >> "!LOG_PATH!"
) else if "!EC!"=="2316632124" (
    echo %C_AMARELO%[AVISO] O programa !NAME%IDX%! já se encontra presente no sistema.%C_RESET%
    echo [%date% %time%] [ALREADY_PRESENT] !NAME%IDX%! ja verificado !EC! >> "!LOG_PATH!"
) else if "!EC!"=="-1978335189" (
    echo %C_VERDE%[ATUALIZADO] !NAME%IDX%! já está na versão mais recente disponível.%C_RESET%
    echo [%date% %time%] [UP_TO_DATE] !NAME%IDX%! sem atualizacoes !EC! >> "!LOG_PATH!"
) else (
    echo %C_VERMELHO%[FALHA] Ocorreu um desvio ao processar o pacote. Código de retorno: !EC!%C_RESET%
    echo [%date% %time%] [ERROR] Falha em !NAME%IDX%!. Retorno: !EC! >> "!LOG_PATH!"
)
echo.
echo Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal

:RunUblockChrome
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| Configuração de Extensões de Segurança
echo==============================================================================%C_RESET%
echo [-] Injetando as diretivas do uBlock Origin Lite nos navegadores...
echo ------------------------------------------------------------------------------
echo.

echo [%date% %time%] [INFO] Aplicando diretivas do uBlock Lite via Registro >> "!LOG_PATH!"

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://google.com" /f >nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist" /v "1" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://google.com" /f >nul

echo ------------------------------------------------------------------------------
echo %C_VERDE%[SUCESSO] Extensão uBlock Origin Lite configurada!%C_RESET%
echo           (Ela aparecerá ativa ao abrir o Chrome ou o Edge).
echo [%date% %time%] [SUCCESS] uBlock Lite injetado com exito no registro. >> "!LOG_PATH!"
echo.
echo Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal

:RunBatchInstall
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| Modo de Instalação Automatizada em Lote
echo==============================================================================%C_RESET%
echo %C_AMARELO%O script instalará as opções de 1 a 8 sequencialmente. Por favor, aguarde.%C_RESET%
echo ------------------------------------------------------------------------------
echo.

:: Loop para instalar de 1 a 6
for /l %%i in (1,1,6) do (
    echo [-] Instalando pacote %%i de 7...
    echo [%date% %time%] [BATCH] Iniciando !NAME%%i! >> "!LOG_PATH!"
    winget install --id !ID%%i! -e --accept-package-agreements --accept-source-agreements
    echo.
)

:: Instalação do Java (Opção 7)
echo [-] Instalando pacote 7 de 7 (Java Oracle)...
echo [%date% %time%] [BATCH] Iniciando Java Oracle >> "!LOG_PATH!"
winget install --id !ID7! -e --accept-package-agreements --accept-source-agreements --silent --override "/s"
echo.

:: Aplicação do uBlock Origin Lite (Opção 8):: Aplicação do uBlock Origin Lite (Opção 8)
:RunUblockChrome
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| ConfiguraÃ§Ã£o de ExtensÃµes de SeguranÃ§a
echo==============================================================================%C_RESET%
echo [-] Injetando as diretivas do uBlock Origin Lite no Google Chrome...
echo ------------------------------------------------------------------------------
echo.

echo [%date% %time%] [INFO] Aplicando diretivas do uBlock Lite via Registro (Chrome) >> "!LOG_PATH!"

:: Vincula o ID oficial fornecido diretamente ao servidor de download silencioso do Chrome (CRX)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome\ExtensionInstallForcelist" /v "100" /t REG_SZ /d "ddkjiahejlhfcafbddmgiahcphecmpfh;https://google.com" /f >nul

echo ------------------------------------------------------------------------------
echo %C_VERDE%[SUCESSO] ExtensÃ£o uBlock Origin Lite configurada!%C_RESET%
echo           (Ela baixarÃ¡ e aparecerÃ¡ ativa ao abrir ou reiniciar o Google Chrome).
echo.
echo Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal


echo ------------------------------------------------------------------------------
echo %C_VERDE%[SUCESSO] ExtensÃ£o uBlock Origin Lite configurada!%C_RESET%
echo           (Ela aparecerÃ¡ ativa automaticamente ao abrir o Google Chrome).
echo.
echo Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal

echo ------------------------------------------------------------------------------
echo %C_VERDE%[SUCESSO] Instalação em lote concluída com êxito!%C_RESET%
echo.
echo Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal

:RunActivation
cls
echo %C_CIANO%==============================================================================
echo    NOTEBOOKS MS ^| Central de Ativação Digital Corporativa
echo==============================================================================%C_RESET%
echo [-] Ignorando bloqueios de rede ISP usando DNS Seguro da Cloudflare...
echo ------------------------------------------------------------------------------
echo.
echo [%date% %time%] [INFO] Executando comando MAS Script via PowerShell >> "!LOG_PATH!"

:: Chamada oficial online do MAS Script corrigida
powershell -Command "irm https://get.activated.win | iex"
echo.
echo ------------------------------------------------------------------------------
echo Processo concluÃ­do. Pressione qualquer tecla para retornar ao menu inicial...
pause >nul
goto MenuPrincipal
echo ------------------------------------------------------------------------------
echo %C_AMARELO%[AVISO] Processo finalizado. Retornando ao painel técnico...%C_RESET%
echo.
