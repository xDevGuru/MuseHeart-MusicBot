@echo off
del /q /f Lavalink.jar

rmdir /q /s "venv" ".app_commands_sync_data" ".java" ".jabba" ".db_cache" "plugins"

echo Files deleted successfully!
pause
