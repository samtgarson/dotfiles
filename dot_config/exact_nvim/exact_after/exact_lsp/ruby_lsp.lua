return {
  cmd = { "ruby-lsp" },
  init_options = {
    formatter = "none",
    enabledFeatures = {
      'codeActions',
      'codeLens',
      'completion',
      'definition',
      'documentHighlights',
      'documentLink',
      'documentSymbols',
      'foldingRanges',
      'hover',
      'inlayHint',
      'onTypeFormatting',
      'selectionRanges',
      'signatureHelp',
      'workspaceSymbol'
      -- 'diagnostics',
      -- 'formatting',
      -- 'semanticHighlighting',
    },
  }
}
