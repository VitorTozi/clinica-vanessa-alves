@echo off
chcp 65001 >nul
title Enviar alteracoes (pull request) - Clinica Vanessa Alves
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
echo Buscando a versao mais nova do GitHub...
git fetch origin >nul 2>nul
git rev-parse --verify origin/main >nul 2>nul
if errorlevel 1 goto envia
git stash >nul 2>nul
git checkout main >nul 2>nul
git pull --ff-only origin main
git stash pop >nul 2>nul
if errorlevel 1 goto conflito

:envia
echo.
set /p DESC=Descreva em poucas palavras o que mudou: 
if "%DESC%"=="" set DESC=Atualizacao do site
for /f "tokens=1-3 delims=/" %%a in ("%date%") do set HOJE=%%c%%b%%a
set HORA=%time:~0,2%%time:~3,2%
set HORA=%HORA: =0%
set RAMO=atualizacao-%HOJE%-%HORA%
git checkout -b %RAMO% >nul 2>nul
git add -A
git commit -m "%DESC%"
if errorlevel 1 goto nadamudou
echo Enviando para o GitHub (pode abrir uma janela de login na primeira vez)...
git push -u origin %RAMO%
if errorlevel 1 goto falhou
git checkout main >nul 2>nul

echo.
echo ===============================================
echo  Enviado! O GitHub abre um PULL REQUEST sozinho.
echo  Revise e clique em "Merge pull request" para publicar.
echo ===============================================
start "" "https://github.com/VitorTozi/clinica-vanessa-alves/pulls"
pause
exit /b 0

:nadamudou
git checkout main >nul 2>nul
git branch -D %RAMO% >nul 2>nul
echo Nada mudou desde a ultima vez. Nada foi enviado.
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
