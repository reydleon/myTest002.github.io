@echo off
setlocal EnableExtensions

title Publish Local KMZ Map Viewer to GitHub

set "REPO_URL=https://github.com/reydleon/myTest002.github.io.git"
set "BRANCH=main"
set "COMMIT_MESSAGE=Publish Local KMZ Map Viewer 013"

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
    git remote set-url origin "%REPO_URL%"
    if errorlevel 1 goto :error
)

echo.
echo Adding all project files...
git add -A
if errorlevel 1 goto :error

git diff --cached --quiet
if errorlevel 1 (
    echo Creating commit...
    git commit -m "%COMMIT_MESSAGE%"
    if errorlevel 1 goto :error
) else (
    echo No new local file changes to commit.
)

echo.
echo Reading the current GitHub branch...
git fetch origin %BRANCH%
if errorlevel 1 (
    echo The remote branch may not exist yet. Continuing...
)

echo.
echo Uploading this folder as the GitHub repository contents...
echo Existing remote history will be replaced only if it has changed
echo since the fetch above.
git push -u origin %BRANCH% --force-with-lease
if errorlevel 1 goto :pusherror

echo.
echo ============================================
echo Upload completed successfully.
echo ============================================
echo Repository:
echo https://github.com/reydleon/myTest002.github.io
echo.
echo Website:
echo https://reydleon.github.io/myTest002.github.io/
echo.
pause
exit /b 0

:pusherror
echo.
echo ERROR: GitHub rejected the upload.
echo Another change may have been pushed after this script fetched the branch.
echo Run the script again after checking the repository.
pause
exit /b 1

:error
echo.
echo ERROR: A Git command failed.
echo Review the message above.
pause
exit /b 1
