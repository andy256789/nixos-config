{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.modules.cybersecurity;
in {
    options.modules.cybersecurity = {
        enable = mkEnableOption "Enable cybersecurity packages";

        networkScanning = {
            enable = mkEnableOption "Enable network scanning tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    nmap
                    masscan
                    rustscan
                    hping
                    fping
                ];
                description = "Network scanning and discovery tools";
            };
        };

        webApplicationTesting = {
            enable = mkEnableOption "Enable web application testing tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    gobuster
                    ffuf
                    nikto
                    sqlmap
                ];
                description = "Web application testing and vulnerability scanning tools";
            };
        };

        vulnerabilityAssessment = {
            enable = mkEnableOption "Enable vulnerability assessment tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    nuclei
                    lynis
                    clamav
                    yara
                ];
                description = "Vulnerability assessment and scanning tools";
            };
        };

        exploitationFrameworks = {
            enable = mkEnableOption "Enable exploitation frameworks";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    metasploit
                    exploitdb
                ];
                description = "Exploitation frameworks and payload generators";
            };
        };

        passwordAttacks = {
            enable = mkEnableOption "Enable password attack tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    john
                    hashcat
                    hydra
                    medusa
                    crunch
                    wordlists
                ];
                description = "Password cracking and brute force tools";
            };
        };

        wirelessTesting = {
            enable = mkEnableOption "Enable wireless testing tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    aircrack-ng
                    kismet
                    wireshark
                ];
                description = "Wireless network testing and attack tools";
            };
        };

        forensics = {
            enable = mkEnableOption "Enable digital forensics tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    sleuthkit
                    binwalk
                    foremost
                    testdisk
                    exiftool
                    steghide
                ];
                description = "Digital forensics and data recovery tools";
            };
        };

        reverseEngineering = {
            enable = mkEnableOption "Enable reverse engineering tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    ghidra
                    radare2
                    gdb
                    strace
                    hexedit
                    file
                ];
                description = "Reverse engineering and binary analysis tools";
            };
        };

        socialEngineering = {
            enable = mkEnableOption "Enable social engineering tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    theharvester
                    recon-ng
                    enum4linux
                    samba
                ];
                description = "Social engineering and information gathering tools";
            };
        };

        postExploitation = {
            enable = mkEnableOption "Enable post-exploitation tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    powershell
                    socat
                    netcat-gnu
                ];
                description = "Post-exploitation and lateral movement tools";
            };
        };

        utilities = {
            enable = mkEnableOption "Enable cybersecurity utilities";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    tor
                    proxychains
                    tcpdump
                    wireshark-cli
                    sslscan
                    gitleaks
                ];
                description = "General cybersecurity utilities and tools";
            };
        };
    };

    config = mkIf cfg.enable {
        home.packages = with pkgs; []
            ++ (if cfg.networkScanning.enable then cfg.networkScanning.packages else [])
            ++ (if cfg.webApplicationTesting.enable then cfg.webApplicationTesting.packages else [])
            ++ (if cfg.vulnerabilityAssessment.enable then cfg.vulnerabilityAssessment.packages else [])
            ++ (if cfg.exploitationFrameworks.enable then cfg.exploitationFrameworks.packages else [])
            ++ (if cfg.passwordAttacks.enable then cfg.passwordAttacks.packages else [])
            ++ (if cfg.wirelessTesting.enable then cfg.wirelessTesting.packages else [])
            ++ (if cfg.forensics.enable then cfg.forensics.packages else [])
            ++ (if cfg.reverseEngineering.enable then cfg.reverseEngineering.packages else [])
            ++ (if cfg.socialEngineering.enable then cfg.socialEngineering.packages else [])
            ++ (if cfg.postExploitation.enable then cfg.postExploitation.packages else [])
            ++ (if cfg.utilities.enable then cfg.utilities.packages else []);

        # Add useful aliases for common pentesting tasks
        programs.bash.shellAliases = mkIf cfg.enable {
            nmap-quick = "nmap -sS -O -F";
            nmap-full = "nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 --script='default or (discovery and safe)'";
            gobuster-dir = "gobuster dir -u";
            ffuf-dir = "ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u";
            burp = "burpsuite &";
        };
    };
}
