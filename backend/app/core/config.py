from pathlib import Path
from fastapi.templating import Jinja2Templates

# Ordner berechnen
APP_DIR = Path(__file__).resolve().parent.parent
FRONTEND_DIR = APP_DIR.parent.parent / "frontend"

TEMPLATES_DIR = FRONTEND_DIR / "templates"
STATIC_DIR = FRONTEND_DIR / "static"

# Jinja2 Templates
templates = Jinja2Templates(directory=str(TEMPLATES_DIR))
