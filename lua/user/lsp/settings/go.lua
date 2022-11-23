return {
  settings = {
    gopls = {
      gofumpt = true, -- disable gofumpt etc,

      codelenses = {
        generate = false, -- Don't show the `go generate` lens.
        gc_details = true, -- Show a code lens toggling the display of gc's choices.
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
        run_vulncheck_exp = false,
        test = true
      },

      analyses = {
        nilness = true, -- Check for redundant or impossible nil comparisons.
        shadow = true,
        useany = true -- Check for constraints that could be simplified to "any".
      },

      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
        tests = true
      },
    },
    experimentalPostfixCompletions = true,
  },
}
