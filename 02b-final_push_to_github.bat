@echo off
setlocal EnableExtensions

title Publish Local KMZ Map Viewer to GitHub

set "REPO_URL=https://github.com/reydleon/myTest002.github.io.git"
set "BRANCH=main"
set "COMMIT_MESSAGE=Update Local KMZ Map Viewer"

echo ============================================
echo Publish Local KMZ Map Viewer to GitHub
echo ============================================
echo Repository:
echo %REPO_URL%
echo.

cd /d "%~dp0"

where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git is not installed or is not available in PATH.
    echo Install Git for Windows, then run this file again.
    pause
    exit /b 1
)

if not exist ".git" (
    echo Initializing Git repository...
    git init
    if errorlevel 1 goto :error
)

git branch -M %BRANCH%
if errorlevel 1 goto :error

git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo Adding GitHub remote...
    git remote add origin "%REPO_URL%"
    if errorlevel 1 goto :error
) else (
    for /f "delims=" %%R in ('git remote get-url origin') do set "CURRENT_REMOTE=%%R"
    if /I not "%CURRENT_REMOTE%"=="%REPO_URL%" (
        echo Updating GitHub remote...
        git remote set-url origin "%REPO_URL%"
        if errorlevel 1 goto :error
    )
)

echo.
echo Adding project files...
git add -A
if errorlevel 1 goto :error

git diff --cached --quiet
if not errorlevel 1 (
    echo No file changes were found.
) else (
    echo Creating commit...
    git commit -m "%COMMIT_MESSAGE%"
    if errorlevel 1 goto :error
)

echo.
echo Uploading to GitHub...
git push -u origin %BRANCH%
if errorlevel 1 (
    echo.
    echo Push failed. The remote repository may already contain files
    echo that are not in this local folder.
    echo.
    echo To combine the remote history, run:
    echo git pull origin %BRANCH% --allow-unrelated-histories
    echo.
    echo Resolve any conflicts, then run this batch file again.
    pause
    exit /b 1
)

echo.
echo ============================================
echo Upload completed successfully.
echo ============================================
echo GitHub repository:
echo https://github.com/reydleon/myTest002.github.io
echo.
echo GitHub Pages:
echo https://reydleon.github.io/myTest002.github.io/
echo.
pause
exit /b 0

:error
echo.
echo ERROR: A Git command failed.
echo Review the message above and try again.
pause
exit /b 1
