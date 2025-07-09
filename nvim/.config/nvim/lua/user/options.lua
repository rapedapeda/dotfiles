require('lspconfig').pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- or "off" or "strict"
        diagnosticMode = "workspace", -- or "openFiles"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportUnusedVariable = "none",
          reportUnusedImport = "none",
          reportMissingImports = "warning"
        }
      }
    }
  }
})
