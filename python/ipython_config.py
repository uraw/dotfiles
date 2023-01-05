## lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = [
    '%autoreload 2',
    'print("Warning: disable autoreload in ipython_config.py to improve performance.")'
]

## A list of dotted module names of IPython extensions to load.
c.InteractiveShellApp.extensions = ['autoreload']

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'Linux'
