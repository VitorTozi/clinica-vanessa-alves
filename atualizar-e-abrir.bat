@echo off
chcp 65001 >nul
title Atualizar e abrir - Clinica Vanessa Alves
cd /d "%~dp0"

where git >nul 2>nul
if errorlevel 1 goto abre
if not exist ".git" goto abre

echo Baixando a versao mais nova do GitHub (main)...
git checkout main >nul 2>nul
git pull --ff-only origin main
if errorlevel 1 echo Nao deu para atualizar agora (sem internet ou alteracoes locais). Abrindo a versao do PC.

:abre
start "" "%~dp0index.html"
exit /b 0
