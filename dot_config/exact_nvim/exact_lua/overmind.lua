local commands = {
  echo = { term = true },
  quit = { message = 'Stopping Overmind server' },
  stop = { message = 'Stopping Overmind server' },
  kill = { message = 'Killing Overmind server' },
}

function Overmind (cmd)
  print('CMD: '..cmd)
  local opts = commands[cmd]

  if not opts then return end

  if not opts.term then
    print(opts.message)
    os.execute('overmind '..cmd)
  end
end

vim.cmd [[
command! -nargs=* OM lua Overmind(<f-args>)
]]
