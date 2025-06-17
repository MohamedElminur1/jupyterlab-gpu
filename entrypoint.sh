#!/bin/bash
set -e

# Use virtual environment Python
PYTHON_INTERPRETER="/opt/venv/bin/python"

# Generate hashed password
if [ -n "$JUPYTER_PASSWORD" ]; then
    HASHED_PWD=$($PYTHON_INTERPRETER -c "from jupyter_server.auth import passwd; print(passwd('${JUPYTER_PASSWORD}', 'sha256'))")
else
    HASHED_PWD=""
fi

# Generate Jupyter config
cat > ${JUPYTER_CONFIG_DIR}/jupyter_server_config.py << EOL
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.open_browser = False
c.ServerApp.allow_root = True
c.IdentityProvider.token = ''
c.PasswordIdentityProvider.password_required = True
c.PasswordIdentityProvider.hashed_password = '${HASHED_PWD}'
c.ServerApp.root_dir = '${WORKDIR}'
c.ServerApp.allow_remote_access = True
c.ServerApp.disable_check_xsrf = False
c.ServerApp.terminado_settings = {'shell_command': ['/bin/bash', '-l']}
c.TerminalInteractiveShell.autoindent = True
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.term_title = True
c.TerminalInteractiveShell.confirm_exit = False
c.ServerApp.disable_check_xsrf = False
c.ServerApp.terminado_settings = {'shell_command': ['/bin/bash', '-l']}
EOL

# Start Jupyter Lab
exec jupyter lab
