local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup {
  adapters = {
    require "neotest-go" {
      experimental = {
        test_table = true,
      },
      args = { "-count=1", "-timeout=60s" }
    },
  },
}
