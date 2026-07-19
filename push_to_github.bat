@echo off
setlocal

echo Local KMZ Map Viewer 013 - GitHub Push
echo.

git add .
if errorlevel 1 goto error

git commit -m "Publish Local KMZ Map Viewer 013"
if errorlevel 1 (
  echo No new changes to commit, or Git requires configuration.
)

git push
if errorlevel 1 goto error

echo.
echo Push complete.
pause
exit /b 0

:error
echo.
echo The Git command failed. Review the message above.
pause
exit /b 1
