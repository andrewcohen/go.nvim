local eq = assert.are.same
local cur_dir = vim.fn.expand("%:p:h")
local busted = require("plenary/busted")

describe("should run test", function()
  -- vim.fn.readfile('minimal.vim')
  -- vim.fn.writefile(vim.fn.readfile('fixtures/fmt/hello.go'), name)
  status = require("plenary.reload").reload_module("go.nvim")
  it("should test function", function()
    --
    -- go.nvim may not auto loaded
    vim.cmd([[packadd go.nvim]])

    local path = cur_dir .. "/lua/tests/fixtures/coverage/branch_test.go" -- %:p:h ? %:p
    require("go").setup({
      trace = true,
      lsp_cfg = true,
      log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    })
    vim.cmd("silent exe 'e " .. path .. "'")
    vim.fn.setpos(".", { 0, 5, 11, 0 })
    local cmd = require("go.gotest").test_fun()

    eq({ "go", "test", "-v", "-run", "^Test_branch", "./lua/tests/fixtures/coverage" }, cmd)
  end)
end)

describe("should run test file", function()
  -- vim.fn.readfile('minimal.vim')
  -- vim.fn.writefile(vim.fn.readfile('fixtures/fmt/hello.go'), name)
  status = require("plenary.reload").reload_module("go.nvim")
  it("should test function", function()
    --
    -- go.nvim may not auto loaded
    vim.cmd([[packadd go.nvim]])

    local path = cur_dir .. "/lua/tests/fixtures/coverage/branch_test.go" -- %:p:h ? %:p
    require("go").setup({
      trace = true,
      lsp_cfg = true,
      log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    })
    vim.cmd("silent exe 'e " .. path .. "'")
    vim.fn.setpos(".", { 0, 5, 11, 0 })
    local cmd = require("go.gotest").test_file()

    eq({ "go", "test", "-v", "-run", "Test_branch|TestBranch", "./lua/tests/fixtures/coverage" }, cmd)
  end)
end)

describe("should run test package", function()
  -- vim.fn.readfile('minimal.vim')
  -- vim.fn.writefile(vim.fn.readfile('fixtures/fmt/hello.go'), name)
  status = require("plenary.reload").reload_module("go.nvim")
  it("should test function", function()
    --
    -- go.nvim may not auto loaded
    vim.cmd([[packadd go.nvim]])

    local path = cur_dir .. "/lua/tests/fixtures/coverage/branch_test.go" -- %:p:h ? %:p
    require("go").setup({
      trace = true,
      lsp_cfg = true,
      log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    })
    vim.cmd("silent exe 'e " .. path .. "'")
    vim.fn.setpos(".", { 0, 1, 1, 0 })
    local cmd = require("go.gotest").test_package()

    eq({ "go", "test", "-v", "./lua/tests/fixtures/coverage/..." }, cmd)
  end)
end)

-- test passed but the exit code is not 0
describe("should allow select test func", function()
  -- vim.fn.readfile('minimal.vim')
  -- vim.fn.writefile(vim.fn.readfile('fixtures/fmt/hello.go'), name)
  status = require("plenary.reload").reload_module("go.nvim")
  it("should test function", function()
    --
    -- go.nvim may not auto loaded
    vim.cmd([[packadd go.nvim]])

    local path = cur_dir .. "/lua/tests/fixtures/coverage/branch_test.go" -- %:p:h ? %:p
    require("go").setup({
      trace = true,
      lsp_cfg = true,
      log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
    })
    vim.cmd("silent exe 'e " .. path .. "'")
    vim.fn.setpos(".", { 0, 1, 1, 0 })
    local cmd = require("go.gotest").get_testfunc()

    eq({ "Test_branch", "TestBranch" }, cmd)
  end)
end)
