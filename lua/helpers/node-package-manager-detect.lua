return {
  detectPackageManager = function()
    local lockfileMap = {
      ['pnpm-lock.yaml'] = 'pnpm',
      ['yarn.lock'] = 'yarn',
      ['package-lock.json'] = 'npm',
      ['bun.lockb'] = 'bun',
    }

    local path = vim.fn.expand '%:p:h'

    while path ~= '/' do
      for lockfile, pm in pairs(lockfileMap) do
        if vim.fn.filereadable(path .. '/' .. lockfile) == 1 then
          return pm
        end
      end
      path = vim.fn.fnamemodify(path, ':h')
    end
  end,
}
