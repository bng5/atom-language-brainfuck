LanguageBrainfuckView = require './language-brainfuck-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageBrainfuck =
  languageBrainfuckView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageBrainfuckView = new LanguageBrainfuckView(state.languageBrainfuckViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageBrainfuckView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-brainfuck:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageBrainfuckView.destroy()

  serialize: ->
    languageBrainfuckViewState: @languageBrainfuckView.serialize()

  toggle: ->
    console.log 'LanguageBrainfuck was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
