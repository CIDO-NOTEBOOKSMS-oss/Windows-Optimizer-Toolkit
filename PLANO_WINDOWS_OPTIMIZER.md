# Plano: Script Multi-Categoria para Assistência Técnica

## Objetivo
Expandir o script existente (`EXEMPLO KIT TOOLS.bat`) adicionando categorias de otimização, reparo, limpeza, privacidade, remoção de bloatware e diagnóstico para Windows 10/11.

---

## Formato Escolhido
- **Batch (.bat)** com **PowerShell inline** (mesmo formato do script atual)
- **Todas as 9 categorias** implementadas de uma vez

---

## Estrutura do Script

```
=== MENU PRINCIPAL ===
[A] Instalação de Programas (WinGet)   → já existe, mantido do original
[B] Verificação e Reparo do Sistema    → NOVO
[C] Limpeza Profunda                   → NOVO
[D] Otimização de Performance          → NOVO
[E] Privacidade e Telemetria           → NOVO
[F] Remoção de Bloatware               → NOVO
[G] Otimização de Rede                 → NOVO
[H] Serviços Desnecessários            → NOVO
[I] Ferramentas de Diagnóstico         → NOVO
[J] Ativação Windows/Office            → já existe, mantido do original
[X] Sair
```

Cada categoria (B até I) terá um **sub-menu** com:
- Ações individuais numeradas
- Opção "[T] Executar Todas" no início
- Opção "[V] Voltar ao Menu Principal"

---

## CATEGORIA B — Verificação e Reparo do Sistema

### Comandos individuais:
1. **Verificação rápida** — `sfc /verifyonly`
2. **Reparo de arquivos do sistema** — `sfc /scannow`
3. **Verificar saúde do DISM** — `DISM /Online /Cleanup-Image /CheckHealth`
4. **Escaneamento profundo DISM** — `DISM /Online /Cleanup-Image /ScanHealth`
5. **Restaurar imagem do Windows** — `DISM /Online /Cleanup-Image /RestoreHealth`
6. **Limpar componente corrompido** — `DISM /Online /Cleanup-Image /StartComponentCleanup`
7. **Reset de component store** — `DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase`
8. **Verificar disco (agendar)** — `chkdsk /f /r C:`
9. **Verificar erros de disco** — `chkdsk C:`
10. **Reparo de inicialização** — `bootrec /fixmbr`, `bootrec /fixboot`, `bootrec /rebuildbcd`

---

## CATEGORIA C — Limpeza Profunda

### Comandos individuais:
1. **Limpeza de disco rápida** — `cleanmgr /verylowdisk`
2. **Limpeza de disco personalizada** — `cleanmgr /sagerun:1` (precisa configurar `/sageset:1` antes)
3. **Limpar TEMP do usuário** — `del /q /f /s %TEMP%\*`
4. **Limpar TEMP do sistema** — `del /q /f /s C:\Windows\Temp\*`
5. **Limpar Prefetch** — `del /q /f /s C:\Windows\Prefetch\*`
6. **Limpar cache de atualizações** — `del /q /f /s C:\Windows\SoftwareDistribution\Download\*`
7. **Limpar logs do Windows** — `wevtutil el | foreach { wevtutil cl "$_" }`
8. **Limpar Recycle Bin** — `PowerShell Clear-RecycleBin -Force`
9. **Limpar cache DNS** — `ipconfig /flushdns`
10. **Limpar cache da loja** — `wsreset.exe`
11. **Limpar Windows.old** — `dism /online /Cleanup-Image /StartComponentCleanup /Defer`
12. **Excluir arquivos de hibernação** — `powercfg /hibernate off`

---

## CATEGORIA D — Otimização de Performance

### Comandos individuais:
1. **Plano de Energia: Alto Desempenho** — `powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c`
2. **Plano de Energia: Desempenho Máximo** — `powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61` + ativar
3. **Desativar SysMain (Superfetch)** — `sc config SysMain start=disabled` + `sc stop SysMain`
4. **Desativar Windows Search** — `sc config WSearch start=disabled` + `sc stop WSearch`
5. **Desativar animações visuais** — `SystemPropertiesPerformance` ou via registro
6. **Acelerar menus** — `reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f`
7. **Desativar sombras do mouse** — registro `HKCU\...\Performance`
8. **Desativar transparência** — registro
9. **Desativar GameDVR** — `reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f`
10. **Desativar notificações de fundo** — registro
11. **Desativar efeitos de janela** — `SystemParametersInfo`
12. **Desativar Nagle TCP** — registro de rede (reduz latency)
13. **Desativar indexação de disco** — `fsutil behavior set disablelastaccess 1`

---

## CATEGORIA E — Privacidade e Telemetria

### Comandos individuais:
1. **Desativar Telemetria** — `reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f`
2. **Desativar Serviço DiagTrack** — `sc config DiagTrack start=disabled` + `sc stop DiagTrack`
3. **Desativar dmwappushservice** — `sc config dmwappushservice start=disabled`
4. **Desativar sugestões no início** — registro `ContentDeliveryManager`
5. **Desativar anúncios no Windows** — registro
6. **Desativar Cortana** — `reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f`
7. **Desativar Bing na busca** — registro
8. **Desativar rastreamento de local** — registro
9. **Desativar feedback** — registro `DoNotShowFeedbackNotifications`
10. **Desativar Wi-Fi Sense** — registro
11. **Desativar compartilhamento de telemetria** — registro
12. **Desativar coleta de logs de diagnóstico** — registro

---

## CATEGORIA F — Remoção de Bloatware (PowerShell)

### Lista de apps removidos (PowerShell inline):
```powershell
# Xbox
Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxProvisionedPackage -Online | Where DisplayName -like "*xbox*" | Remove-AppxProvisionedPackage -Online

# Skype
Get-AppxPackage *skype* | Remove-AppxPackage

# OneDrive (via registro + desinstalador)
# Bing apps
Get-AppxPackage *bing* | Remove-AppxPackage

# Zune (Music, Video)
Get-AppxPackage *zune* | Remove-AppxPackage

# Office Hub
Get-AppxPackage *officehub* | Remove-AppxPackage

# News, Weather, Money, Sports
Get-AppxPackage *bingnews*, *bingsports*, *bingweather*, *biginfo* | Remove-AppxPackage

# People
Get-AppxPackage *people* | Remove-AppxPackage

# Solitaire
Get-AppxPackage *solitaire* | Remove-AppxPackage

# Mixed Reality
Get-AppxPackage *mixedreality* | Remove-AppxPackage

# Xbox Game Bar (opcional)
Get-AppxPackage *xboxgamingoverlay* | Remove-AppxPackage

# Cortana (remover do registro)
# LinkedIn
Get-AppxPackage *linkedin* | Remove-AppxPackage

# Spotify
Get-AppxPackage *spotify* | Remove-AppxPackage

# TikTok, Instagram, Facebook
Get-AppxPackage *tiktok*, *instagram*, *facebook* | Remove-AppxPackage
```

---

## CATEGORIA G — Otimização de Rede

### Comandos individuais:
1. **Flush DNS** — `ipconfig /flushdns`
2. **Reset TCP/IP Stack** — `netsh int ip reset`
3. **Reset Winsock** — `netsh winsock reset`
4. **Reset Firewall** — `netsh advfirewall reset`
5. **Renovar IP** — `ipconfig /release` + `ipconfig /renew`
6. **Desativar TCP Auto-Tuning** — `netsh int tcp set global autotuninglevel=disabled`
7. **Ativar TCP Auto-Tuning (normal)** — `netsh int tcp set global autotuninglevel=normal`
8. **Desativar Nagle Algorithm** — registro `TCPNoDelay`
9. **Aumentar MaxUserPort** — registro `MaxUserPort=65534`
10. **Aumentar TcpTimedWaitDelay** — registro

---

## CATEGORIA H — Serviços Desnecessários

### Serviços para desativar:
```batch
sc config SysMain start=disabled        & sc stop SysMain
sc config WSearch start=disabled        & sc stop WSearch
sc config XblAuthManager start=disabled  & sc stop XblAuthManager
sc config XboxNetApiSvc start=disabled   & sc stop XboxNetApiSvc
sc config XboxGipSvc start=disabled      & sc stop XboxGipSvc
sc config DiagTrack start=disabled       & sc stop DiagTrack
sc config dmwappushservice start=disabled
sc config WMPNetworkSvc start=disabled   & sc stop WMPNetworkSvc
sc config TabletInputService start=disabled
sc config Fax start=disabled
sc config PhoneSvc start=disabled        & sc stop PhoneSvc
sc config PcaSvc start=disabled          & sc stop PcaSvc
sc config RetailDemo start=disabled
sc config TroubleshootingSvc start=disabled
sc config WalletService start=disabled
sc config MessagingService start=disabled
sc config lfsvc start=disabled           (serviço de localização)
sc config MapsBroker start=disabled
```

---

## CATEGORIA I — Ferramentas de Diagnóstico

### Comandos individuais:
1. **Informações do sistema** — `systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory"`
2. **Relatório de saúde do Windows** — `PowerShell Get-WindowsHealthReport` (ou via DISM)
3. **Espaço em disco** — `wmic logicaldisk get size,freespace,caption`
4. **Verificar erros no Event Viewer** — `wevtutil qe System /c:5 /f:text /q:"*[System[Level=2]]"`
5. **Tempo de atividade** — `net stats workstation | find "Statistics since"`
6. **Versão do Windows** — `winver` (abre janela) ou `wmic os get Caption,Version`
7. **Integridade da bateria** — `powercfg /batteryreport`
8. **Drivers instalados** — `driverquery /v /fo table`
9. **Processos em execução** — `tasklist /v`
10. **Conexões de rede** — `netstat -an`

---

## Lista de Projetos de Referência

| Projeto | Link |
|---------|------|
| **Win11Debloat** | github.com/Raphire/Win11Debloat |
| **WinScript** | github.com/flick9000/winscript |
| **ChrisTitusTech win10script** | github.com/ChrisTitusTech/win10script |
| **Sophia Script** | github.com/farag2/Sophia-Script-for-Windows |
| **script-otimizador-windows** (PT-BR) | github.com/CelmarPA/script-otimizador-windows |
| **Ghost-Optimizer** | github.com/louzkk/Ghost-Optimizer |
| **Windows-Optimize-Harden-Debloat** | github.com/simeononsecurity/Windows-Optimize-Harden-Debloat |
| **Optimizer-BAT** | github.com/Roo0722/Optimizer-BAT |
| **WindowsRescue** | github.com/tboy1337/WindowsRescue |

---

## Próximos Passos

Assim que você **confirmar** que leu e entendeu o plano, eu gerei o script completo `Windows-Optimizer-Toolkit.bat` unificando:

1. ✅ Seu script original (instalação WinGet + ativação)
2. ✅ Categorias B a I com sub-menus
3. ✅ Mesmo padrão de cores, logs, admin check
4. ✅ Estilo visual consistente com o seu original
