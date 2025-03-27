return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    settings = {
        init_options = {
            settings = {
                args = {
                    "--extend-select",
                    "A,ARG,B,C4,DTZ,F,FBT,FURB,G,I,N,PT,S,UP",
                    "--unfixable",
                    "F401,F841",
                },
            },
        },
    },
}
