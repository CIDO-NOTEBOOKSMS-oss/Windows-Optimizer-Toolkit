# AGENTS.md — Windows Optimizer Toolkit

## Repo structure

- `Windows-Optimizer-Toolkit.bat` (1759 lines) — **the only file to edit**
- `EXEMPLO KIT TOOLS.bat` — original legacy (248 lines), **do not modify**
- `Analise usuario.md` — user feedback log; check before UX changes
- `PLANO_WINDOWS_OPTIMIZER.md` — planning reference only
- `.git/` — single commit (v2.0), no branching

## Patterns you MUST follow

### Action blueprint
Every action (`:CatX_N`) follows this exact structure:
```
:CatX_N
if "!BATCH_MODE!"=="0" cls
echo %C_CIANO%...header...
echo [%date% %time%] [INFO] ... >> "!LOG_PATH!"
<command>
echo %C_VERDE%[OK] ...%C_RESET%
if "!BATCH_MODE!"=="1" goto :EOF
echo Pressione qualquer tecla...
pause >nul
goto CatX_Menu
```

### BATCH_MODE flag
- **`_Todas` label**: `set "BATCH_MODE=1"`, then `echo %C_AMARELO%[1/N] ...%C_RESET% & call :CatX_N` for each step, then `set "BATCH_MODE=0"`
- **Each action**: `if "!BATCH_MODE!"=="0" cls` (skip clear in batch mode) and `if "!BATCH_MODE!"=="1" goto :EOF` (skip pause/loop)
- This lets actions work both standalone and as part of "Executar Todas"

### Menu pattern
```
choice /c T12345678V /n /m "..."
set "OPC=%errorlevel%"
if "%OPC%"=="1" goto CatX_Todas    (T)
if "%OPC%"=="2" goto CatX_1        (1)
if "%OPC%"=="9" goto CatX_8        (8)
if "%OPC%"=="10" goto MenuPrincipal (V)
```
`%errorlevel%` is 1-based; T=1, digits map 1→2, 2→3, ..., V=N+1.

## Critical batch-PowerShell rules

- **Embedded PS via inline**: `PowerShell -Command "..."` — never create separate .ps1 files EXCEPT CatI_9 which uses a temp file
- **String interpolation hazard**: Inside `PowerShell -Command "..."`, PS single-quoted strings `'$user\path'` do NOT expand variables. Use concatenation: `$user + '\' + $_` or `"$user\path"` (but batch `"` quoting is tricky)
- **Multi-line PS string**: `PowerShell -Command "& { ... }"` — batch preserves newlines inside double quotes; use this for readable scripts
- **Pipes in PS inside batch**: `|` inside `PowerShell -Command "..."` is fine (inside quotes). In `echo` lines, escape with `^|`
- **Parentheses inside `( )` blocks**: In batch `( )` blocks, `)` must be `^)`. Outside `( )`, `)` and `(` are literal

### Notable PS quoting gotcha (CatI_9 history)
Inline PowerShell with `$u+'\'+$d[$i]` syntax caused the script to crash (likely bad escaping). The working fix writes a .ps1 file line-by-line via `echo` and runs `PowerShell -File`. Only use this when inline fails.

## Category-specific conventions

| Cat | Scope | Key pattern |
|-----|-------|-------------|
| A | WinGet install | **No pre-check** (`winget list` removed per user). Exit codes: 0=OK, 2316632124=already present, -1978335189=up to date. Java (IDX=7) needs `--silent --override "/s"` |
| B | SFC/DISM | Uses `start "title" /wait cmd /c "command & pause>nul"` for a separate CMD window (PowerShell wrapping broke progress) |
| C | Cleanup | CatC_4 has internal `[1/4]` step display within a single action. Most others use `>nul 2>&1` for quiet execution |
| D/E/H | Perf/Privacy/Services | Latest pattern: `if "!BATCH_MODE!"=="0" cls` + `_Todas` has `[1/8]` step echoes |
| F | Bloatware | `CatF_Todas` uses **single PS call** with 17 patterns in array. Individual CatF_1-8 kept. `>nul 2>&1` suppresses output |
| G | Network | Fast commands, no `>nul` (show results). Same conditional-cls pattern |
| I | Diagnostics | CatI_9 uses temp `.ps1` file (only exception to inline rule). CatI_8 saved report includes folder sizes |
| J | Activation | `PowerShell -Command "irm https://get.activated.win ^| iex"` (pipe escaped for batch) |

## Language & styling

- UI labels, comments: **PT-BR (Portuguese)**
- Log tags: `[INFO]`, `[SUCCESS]`, `[ERROR]`, `[SKIPPED]` (English)
- `title`: `Windows Optimizer Toolkit - Notebooks MS`
- Colors: `%C_VERDE%` (green/OK), `%C_AMARELO%` (yellow/warning), `%C_VERMELHO%` (red/error), `%C_CIANO%` (cyan/headers), `%C_BRANCO%` (white), `%C_RESET%`
- Developer credit in main menu: `Desenvolvido por Notebooks MS | https://notebooksms.com.br`

## Adding a new category or action

1. Add menu lines in `:CatX_Menu` with T, 1-N, V
2. Add `choice` mapping entries (remember 1-based errorlevel)
3. Add step echoes + `call :CatX_N` in `:CatX_Todas`
4. Create `:CatX_N` label following the action blueprint above
5. Add `call :CatX_N` in `:CatX_Todas` with `[1/N]` progress echo

## Testing

Right-click script → "Executar como Administrador" on a test VM. No automated test framework exists. Must run as Admin (`net session` check at startup) or all commands fail silently.

## Git

Single commit. No branches. Commit conventions: `vX.Y - breve descricao`.
