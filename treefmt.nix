{
    # Used to find the project root
    projectRootFile = "flake.nix";

    programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        typstyle.enable = true;
    };

    settings = {
        formatter = {
            # nix
            alejandra.priority = 3;
            deadnix.priority = 1;
            statix.priority = 2;

            # typst
            typstyle.options = ["--indent-width" "4"];
        };
    };
}
