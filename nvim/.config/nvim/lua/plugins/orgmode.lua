return {
  "nvim-orgmode/orgmode",
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-orgmode/telescope-orgmode.nvim',
    'nvim-orgmode/org-bullets.nvim',
    'Saghen/blink.cmp'},
  event = "VeryLazy",
  config = function()
    require("orgmode").setup({
      win_split_mode = 'float',
      org_agenda_files = "~/Notes/**/*.org",
      org_default_notes_file = "~/Notes/inbox.org",
      org_todo_keywords = {'TODO(t)', 'NEXT(n)', 'PROG(p)', 'URG(u)', '|', 'DONE(d)'},
      org_deadline_warning_days = 3,
      org_agenda_todo_ignore_scheduled = 'future',
      org_agenda_span = 'day',
      org_agenda_start_on_weekday = 1,
      org_agenda_custom_commands = {
      n = {
        description = 'Agenda with daily todos',
        types = {
          {
            type = 'agenda',
            org_agenda_span = 'day', 
            org_agenda_overriding_header = 'Agenda with daily todos',
            match = 'TODO="TODO|URG|PROG|NEXT"',
          },
          {
            type = 'tags_todo',
            match = 'TODO="URG"',
            org_agenda_overriding_header = 'Urgent',
          },
          {
            type = 'tags_todo',
            match = 'TODO="PROG"',
            org_agenda_overriding_header = 'In progress',
          },
          {
            type = 'tags_todo',
            match = 'TODO="NEXT"',
            org_agenda_overriding_header = 'Next up',
          },

        }

      }

      }
    })
    require('org-bullets').setup()
    require('blink.cmp').setup({
      sources = {
        per_filetype = {
          org = {'orgmode'}
        },
        providers = {
          orgmode = {
            name = 'Orgmode',
            module = 'orgmode.org.autocompletion.blink',
            fallbacks = { 'buffer' },
          },
        },
      },
    })

    require('telescope').setup()
    require('telescope').load_extension('orgmode')
    vim.keymap.set('n', '<leader>r', require('telescope').extensions.orgmode.refile_heading)
    vim.keymap.set('n', '<leader>fh', require('telescope').extensions.orgmode.search_headings)
    vim.keymap.set('n', '<leader>li', require('telescope').extensions.orgmode.insert_link)
  end,
}
