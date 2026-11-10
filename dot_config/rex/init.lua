rex.bind("cmd+k", "com.superlogical.terminal.clear")
rex.bind("shift+cmd+k", "session.switch")

rex.bind("shift+left", "client.tab.previous")
rex.bind("shift+right", "client.tab.next")
rex.bind("ctrl+b>r", "client.config.reload")
rex.bind("ctrl+b>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+b>shift+5", "pane.split", { direction = "right" })
rex.bind("ctrl+b>c", "client.tab.new")
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

rex.bind("ctrl+shift+6", "pane.send_key", { key = "ctrl+shift+6" })
