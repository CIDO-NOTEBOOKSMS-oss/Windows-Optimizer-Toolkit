# Windows Optimizer Toolkit

Kit de otimização, manutenção e diagnóstico para Windows 10/11 em lote (batch), desenvolvido para técnicos de informática que precisam executar ações rápidas pós-formatação ou diagnóstico.

> Desenvolvido por **Notebooks MS** — https://notebooksms.com.br

---

## Funcionalidades

| Categoria | Descrição |
|-----------|-----------|
| **A** | Instalação automática de programas via WinGet |
| **B** | Verificação e reparo do sistema (SFC, DISM, Chkdsk, Bootrec) |
| **C** | Limpeza profunda (TEMP, Cache, Lixeira, CleanMgr, Hibernação) |
| **D** | Otimização de performance (energia, serviços, visual, rede) |
| **E** | Privacidade e telemetria (Cortana, Bing, localização, anúncios) |
| **F** | Remoção de bloatware (Xbox, Skype, Bing, pré-instalados) |
| **G** | Otimização de rede (DNS, TCP/IP, Winsock, firewall) |
| **H** | Desativação de serviços desnecessários (SysMain, Xbox, Search) |
| **I** | Ferramentas de diagnóstico (sistema, disco, bateria, eventos, drivers) |
| **J** | Ativação Windows/Office (MAS Script) |
| **Z** | Automação completa (A a I) com opção personalizada |

---

## Como usar

1. **Clique com o direito** no `Windows-Optimizer-Toolkit.bat` → **Executar como administrador**
2. O script verifica permissões de admin automaticamente
3. Navegue pelo menu principal com as teclas indicadas
4. Em cada categoria use:
   - **T** — Executar todas as ações em sequência
   - **1-8/9** — Executar ação individual
   - **P** — Personalizar (ex: `1-4`, `1,3,6-8`)
   - **V** — Voltar ao menu

### Exemplos de personalização

```
Digite os numeros (ex: 1-4, 1,3,6-8): 1-4
Digite os numeros (ex: 1-4, 1,3,6-8): 1,3,6-8
Digite os numeros (ex: 1-4, 1,3,6-8): 135
```

---

## Requisitos

- Windows 10 ou 11
- Execução como Administrador (obrigatório)
- PowerShell 5.1+ (já incluso no Windows)
- Acesso à internet (para WinGet e ativação)

---

## Logs

Todas as operações são registradas em:

```
C:\Logs\Optimizer-Toolkit.log
```

---

## Estrutura do projeto

```
Windows-Optimizer-Toolkit/
├── Windows-Optimizer-Toolkit.bat   # Script principal (~1850 linhas)
├── README.md                       # Este arquivo
├── LICENSE                         # Licença MIT
├── .gitignore                      # Arquivos ignorados
├── AGENTS.md                       # Instruções para IA
└── PLANO_WINDOWS_OPTIMIZER.md      # Documentação de planejamento
```

---

## Licença

Este projeto está licenciado sob a MIT License — veja o arquivo [LICENSE](LICENSE) para detalhes.
