{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.cybersecurity;
in {
    options.modules.cybersecurity = {
        enable = mkEnableOption "Enable cybersecurity packages";
        
        packages = mkOption {
            type = types.listOf types.package;
            default = with pkgs; [
                aircrack-ng
                ffuf
                ghidra
                gobuster
                john
                metasploit
                netcat-openbsd
                nmap
                ropgadget
                sqlmap
                thc-hydra
                social-engineer-toolkit
                wireshark
                wordlists
                theharvester
            ];
            description = "Cybersecurity and penetration testing tools";
        };
    };

    config = mkIf cfg.enable {
        home.packages = cfg.packages;
    };
}
