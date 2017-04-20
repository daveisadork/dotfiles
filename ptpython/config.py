"""
Configuration example for ``ptpython``.

Copy this file to ~/.ptpython/config.py
"""
from __future__ import unicode_literals
from prompt_toolkit.filters import ViInsertMode
from prompt_toolkit.key_binding.input_processor import KeyPress
from prompt_toolkit.keys import Keys
from pygments.token import Token

from ptpython.layout import CompletionVisualisation

__all__ = (
    'configure',
)


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = False

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = False

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Highlight matching parethesis.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = True

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = True

    # Vi mode.
    repl.vi_mode = True

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = 'classic'  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = False

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = False

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = False

    # Enable open-in-editor. Pressing C-X C-E in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = False

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    repl.use_code_colorscheme('solarizeddark')
    repl.use_code_colorscheme("solarizeddark")
    # Enable 24bit True color. (Not all terminals support this. -- maybe check
    # $TERM before changing.)
    repl.true_color = False

    # Install custom colorscheme named 'my-colorscheme' and use it.
    """
    repl.install_ui_colorscheme('my-colorscheme', _custom_ui_colorscheme)
    repl.use_ui_colorscheme('my-colorscheme')
    """

    # Add custom key binding for PDB.
    @repl.add_key_binding(Keys.ControlB)
    def _(event):
        ' Pressing Control-B will insert "pdb.set_trace()" '
        event.cli.current_buffer.insert_text('\nimport pdb; pdb.set_trace()\n')

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    @repl.add_key_binding(Keys.ControlE, Keys.ControlE)
    def _(event):
        b = event.current_buffer
        if b.accept_action.is_returnable:
            b.accept_action.validate_and_handle(event.cli, b)

    # Typing 'jj' in Vi Insert mode, should send escape. (Go back to navigation
    # mode.)
    @repl.add_key_binding('j', 'j', filter=ViInsertMode())
    def _(event):
        " Map 'jj' to Escape. "
        event.cli.input_processor.feed(KeyPress(Keys.Escape))

    """
    # Custom key binding for some simple autocorrection while typing.
    corrections = {
        'impotr': 'import',
        'pritn': 'print',
    }

    @repl.add_key_binding(' ')
    def _(event):
        ' When a space is pressed. Check & correct word before cursor. '
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()

        if w is not None:
            if w in corrections:
                b.delete_before_cursor(count=len(w))
                b.insert_text(corrections[w])

        b.insert_text(' ')
    """


solarized_ui_style = {
    # Classic prompt.
    Token.Prompt:                                 'bold',
    Token.Prompt.Dots:                            'noinherit',

    # (IPython <5.0) Prompt: "In [1]:"
    Token.In:                                     'bold #008800',
    Token.In.Number:                              '',

    # Return value.
    Token.Out:                                    '#ff0000',
    Token.Out.Number:                             '#ff0000',

    # Separator between windows. (Used above docstring.)
    Token.Separator:                              '#bbbbbb',

    # Search toolbar.
    Token.Toolbar.Search:                         '#22aaaa noinherit',
    Token.Toolbar.Search.Text:                    'noinherit',

    # System toolbar
    Token.Toolbar.System:                         '#22aaaa noinherit',

    # "arg" toolbar.
    Token.Toolbar.Arg:                            '#22aaaa noinherit',
    Token.Toolbar.Arg.Text:                       'noinherit',

    # Signature toolbar.
    Token.Toolbar.Signature:                      'bg:#44bbbb #000000',
    Token.Toolbar.Signature.CurrentName:          'bg:#008888 #ffffff bold',
    Token.Toolbar.Signature.Operator:             '#000000 bold',

    Token.Docstring:                              '#888888',

    # Validation toolbar.
    Token.Toolbar.Validation:                     'bg:#440000 #aaaaaa',

    # Status toolbar.
    Token.Toolbar.Status:                         'bg:#222222 #aaaaaa',
    Token.Toolbar.Status.Title:                   'underline',
    Token.Toolbar.Status.InputMode:               'bg:#222222 #ffffaa',
    Token.Toolbar.Status.Key:                     'bg:#000000 #888888',
    Token.Toolbar.Status.PasteModeOn:             'bg:#aa4444 #ffffff',
    Token.Toolbar.Status.PythonVersion:           'bg:#222222 #ffffff bold',

    # When Control-C has been pressed. Grayed.
    Token.Aborted:                                '#888888',

    # The options sidebar.
    Token.Sidebar:                                'bg:#bbbbbb #000000',
    Token.Sidebar.Title:                          'bg:#668866 #ffffff',
    Token.Sidebar.Label:                          'bg:#bbbbbb #222222',
    Token.Sidebar.Status:                         'bg:#dddddd #000011',
    Token.Sidebar.Selected.Label:                 'bg:#222222 #eeeeee',
    Token.Sidebar.Selected.Status:                'bg:#444444 #ffffff bold',

    Token.Sidebar.Separator:                      'bg:#bbbbbb #ffffff underline',
    Token.Sidebar.Key:                            'bg:#bbddbb #000000 bold',
    Token.Sidebar.Key.Description:                'bg:#bbbbbb #000000',
    Token.Sidebar.HelpText:                       'bg:#fdf6e3 #000011',

    # Styling for the history layout.
    Token.History.Line:                          '',
    Token.History.Line.Selected:                 'bg:#008800  #000000',
    Token.History.Line.Current:                  'bg:#ffffff #000000',
    Token.History.Line.Selected.Current:         'bg:#88ff88 #000000',
    Token.History.ExistingInput:                  '#888888',

    # Help Window.
    Token.Window.Border:                          '#bbbbbb',
    Token.Window.Title:                           'bg:#bbbbbb #000000',

    # Meta-enter message.
    Token.AcceptMessage:                          'bg:#ffff88 #444444',

    # Exit confirmation.
    Token.ExitConfirmation:                       'bg:#884444 #ffffff',
}
