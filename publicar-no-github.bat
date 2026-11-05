@echo off
chcp 65001 >nul
title Publicar site - Clinica Vanessa Alves
cd /d "%~dp0"

where git >nul 2>nul
if errorlevel 1 goto semgit

if exist ".git" goto temrepo
echo Primeira vez: ligando esta pasta ao GitHub...
git init -b main >nul
git remote add origin https://github.com/VitorTozi/clinica-vanessa-alves.git
:temrepo

git config user.name >nul 2>nul
if errorlevel 1 goto pedenome
goto temnome
:pedenome
set /p GNOME=Seu nome (aparece nos commits): 
git config user.name "%GNOME%"
:temnome

git config user.email >nul 2>nul
if errorlevel 1 goto pedeemail
goto tememail
:pedeemail
set /p GMAIL=Seu e-mail do GitHub: 
git config user.email "%GMAIL%"
:tememail

echo.
echo Buscando atualizacoes do GitHub antes de enviar...
git fetch origin >nul 2>nul
git rev-parse --verify origin/main >nul 2>nul
if errorlevel 1 goto envia
git add -A
git commit -m "Alteracoes locais antes de atualizar" >nul 2>nul
git pull --rebase origin main
if errorlevel 1 goto conflito

:envia
git add -A
git commit -m "Atualiza site (%date% %time:~0,5%)" >nul 2>nul
echo Enviando para o GitHub (pode abrir uma janela de login na primeira vez)...
git push -u origin main
if errorlevel 1 goto falhou

echo.
echo ===============================================
echo  Publicado! Em 1 a 2 minutos o site atualiza em:
echo  https://vitortozi.github.io/clinica-vanessa-alves/
echo ===============================================
start "" "https://vitortozi.github.io/clinica-vanessa-alves/"
pause
exit /b 0

:semgit
echo O Git nao esta instalado. Baixe e instale em: https://git-scm.com/download/win
echo Depois rode este arquivo de novo.
start "" "https://git-scm.com/download/win"
pause
exit /b 1

:conflito
echo.
echo Houve conflito entre o que esta no PC e no GitHub.
echo Nada foi perdido. Chame o Claude ou rode: git status
pause
exit /b 1

:falhou
echo.
echo Nao foi possivel enviar. Confira se o repositorio existe:
echo https://github.com/VitorTozi/clinica-vanessa-alves.git
echo e se voce fez login no GitHub na janela que abriu.
pause
exit /b 1
