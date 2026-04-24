return {
  "nvim-orgmode/orgmode",
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-orgmode/telescope-orgmode.nvim',
    'Saghen/blink.cmp',
  },
  event = "VeryLazy",
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'org',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })

    require("orgmode").setup({
      win_split_mode = 'float',
      org_hide_leading_stars = true,
      org_agenda_files = "~/notes/**/*.org",
      org_default_notes_file = "~/notes/inbox.org",
      org_todo_keywords = {'TODO(t)', 'NEXT(n)', 'PROG(p)', 'URG(u)', '|', 'DONE(d)'},
      org_deadline_warning_days = 3,
      org_agenda_todo_ignore_scheduled = 'future',
      org_agenda_span = 'day',
      org_agenda_start_on_weekday = 1,
      org_archive_location = '~/notes/archive/%s::',
      org_capture_templates = {
        t = {
          description = 'Task',
          template = '* TODO %?\n  %U',
          target = '~/notes/inbox.org'
        },
        m = {
          description = 'Meeting',
          template = '* Meeting notes: %^{Meeting title}\n  %^{Date}t\n  ** Attendees: %^{Attendees}\n  ** Notes:\n  %?',
          target = '~/notes/inbox.org'
        },
        i = {
          description = 'Idea',
          template = '* TODO Project idea: %?\n  %U',
          target = '~/notes/inbox.org'
        },
        d = {
          description = 'Datateam',
          template = '* TODO %?\n  %U',
          target = '~/notes/areas/datateam.org'
        },
        a = {
          description = 'Acquisition',
          template = '* TODO %?\n  %U',
          target = '~/notes/areas/acquisitie.org'
        },
        o = {
          description = 'Maintenance',
          template = '* TODO %?\n  %U',
          target = '~/notes/areas/onderhoud.org'
        },
        p = {
          description = 'PVT',
          template = '* TODO %?\n  %U',
          target = '~/notes/areas/pvt.org'
        }
      },
      mappings = {
        org = {
          org_toggle_checkbox = '<leader>of',
        },
      },
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

    require('telescope').setup()
    require('telescope').load_extension('orgmode')
    vim.keymap.set('n', '<leader>r', require('telescope').extensions.orgmode.refile_heading)
    vim.keymap.set('n', '<leader>fh', require('telescope').extensions.orgmode.search_headings)
    vim.keymap.set('n', '<leader>li', require('telescope').extensions.orgmode.insert_link)
  end,
}
