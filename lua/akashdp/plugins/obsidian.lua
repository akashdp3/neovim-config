return {
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    opts = {
        workspaces = {
            {
                name = "work",
                path = "~/projects/notes/work"
            }
        }
    }
}
