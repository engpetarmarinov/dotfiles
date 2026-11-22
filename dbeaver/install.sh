#!/bin/sh
#
# DBeaver: apply JetBrains/DataGrip-style shortcuts (macOS).
# Writes user key bindings into the workspace prefs. User bindings take
# precedence over DBeaver defaults. Idempotent; DBeaver must be closed.

PREFS="$HOME/Library/DBeaverData/workspace6/.metadata/.plugins/org.eclipse.core.runtime/.settings/org.eclipse.ui.workbench.prefs"

[ "$(uname -s)" = "Darwin" ] || exit 0
if [ ! -f "$PREFS" ]; then
  echo "DBeaver: no workspace prefs yet; launch DBeaver once, quit it, then re-run."
  exit 0
fi
if pgrep -qi dbeaver; then
  echo "DBeaver: quit DBeaver first (it overwrites prefs on exit)."
  exit 1
fi

echo "Installing DBeaver JetBrains-style keybindings..."
python3 -I - "$PREFS" <<'EOF'
import sys
prefs = sys.argv[1]
SQL, TEXT, WIN = "org.jkiss.dbeaver.ui.editors.sql", "org.eclipse.ui.textEditorScope", "org.eclipse.ui.contexts.window"
# (keySequence, commandId, context)   M1=Cmd M2=Shift M3=Alt M4=Ctrl
BINDINGS = [
    ("M1+M3+L",          "org.jkiss.dbeaver.ui.editors.text.content.format",          WIN),   # Reformat code
    ("M1+D",             "org.eclipse.ui.edit.text.copyLineDown",                     TEXT),  # Duplicate line
    ("M1+BS",            "org.eclipse.ui.edit.text.delete.line",                      TEXT),  # Delete line
    ("M2+M3+ARROW_UP",   "org.eclipse.ui.edit.text.moveLineUp",                       TEXT),  # Move line up
    ("M2+M3+ARROW_DOWN", "org.eclipse.ui.edit.text.moveLineDown",                     TEXT),  # Move line down
    ("M1+M3+/",          "org.jkiss.dbeaver.ui.editors.sql.comment.multi",            SQL),   # Block comment
    ("M4+SPACE",         "org.eclipse.ui.edit.text.contentAssist.proposals",          SQL),   # Basic completion
    ("M1+B",             "org.jkiss.dbeaver.ui.editors.sql.navigate.object",          SQL),   # Go to declaration
    ("M2+F6",            "org.jkiss.dbeaver.ui.editors.sql.rename",                   SQL),   # Rename
    ("M1+M2+A",          "org.eclipse.ui.window.quickAccess",                         WIN),   # Find action
    ("M1+O",             "org.jkiss.dbeaver.core.object.goto",                        WIN),   # Go to table/object
    ("M1+M2+F",          "org.eclipse.text.quicksearch.commands.quicksearchCommand",  WIN),   # Find in files
    ("M1+[",             "org.eclipse.ui.navigate.backwardHistory",                   WIN),   # Back
    ("M1+]",             "org.eclipse.ui.navigate.forwardHistory",                    WIN),   # Forward
    ("M1+M3+ARROW_LEFT", "org.eclipse.ui.navigate.backwardHistory",                   WIN),   # Back
    ("M1+M3+ARROW_RIGHT","org.eclipse.ui.navigate.forwardHistory",                    WIN),   # Forward
]
xml = '<?xml version="1.0" encoding="UTF-8"?>\n<org.eclipse.ui.commands>'
for seq, cmd, ctx in BINDINGS:
    xml += (f'<keyBinding commandId="{cmd}" contextId="{ctx}" '
            f'keyConfigurationId="org.eclipse.ui.defaultAcceleratorConfiguration" '
            f'keySequence="{seq}" locale="" platform="cocoa"/>')
xml += '</org.eclipse.ui.commands>'
value = xml.replace("\\", "\\\\").replace("\n", "\\n").replace("=", "\\=").replace(":", "\\:")
lines = [l for l in open(prefs).read().splitlines() if not l.startswith("org.eclipse.ui.commands=")]
lines.append("org.eclipse.ui.commands=" + value)
open(prefs, "w").write("\n".join(lines) + "\n")
print(f"  {len(BINDINGS)} bindings written")
EOF
echo "DBeaver keybindings installed!"
