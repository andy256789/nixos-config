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
                    zmap
                    rustscan
                    hping
                    netdiscover
                    arp-scan
                    fping
                    unicornscan
                ];
                description = "Network scanning and discovery tools";
            };
        };

        webApplicationTesting = {
            enable = mkEnableOption "Enable web application testing tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    burpsuite
                    zaproxy
                    dirb
                    dirbuster
                    gobuster
                    ffuf
                    wfuzz
                    nikto
                    whatweb
                    wafw00f
                    sqlmap
                    commix
                    wpscan
                ];
                description = "Web application testing and vulnerability scanning tools";
            };
        };

        vulnerabilityAssessment = {
            enable = mkEnableOption "Enable vulnerability assessment tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    openvas-scanner
                    nuclei
                    lynis
                    chkrootkit
                    rkhunter
                    clamav
                    yara
                    cve-bin-tool
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
                    searchsploit
                    armitage
                    beef
                    powersploit
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
                    ncrack
                    patator
                    brutespray
                    crunch
                    cewl
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
                    reaver-wps-fork
                    wifite2
                    hostapd-mana
                    kismet
                    wireshark
                    bettercap
                    mdk4
                    cowpatty
                    pixiewps
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
                    autopsy
                    volatility3
                    binwalk
                    foremost
                    scalpel
                    ddrescue
                    testdisk
                    exiftool
                    steghide
                    outguess
                    stegsolve
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
                    cutter
                    ida-free
                    gdb
                    ltrace
                    strace
                    hexedit
                    file
                    upx
                    objdump
                    strings
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
                    maltego
                    recon-ng
                    fierce
                    dmitry
                    enum4linux
                    samba
                    snmp
                ];
                description = "Social engineering and information gathering tools";
            };
        };

        postExploitation = {
            enable = mkEnableOption "Enable post-exploitation tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    mimikatz
                    powershell
                    bloodhound
                    crackmapexec
                    impacket
                    evil-winrm
                    ligolo-ng
                    chisel
                    socat
                    netcat-gnu
                    pwncat
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
                    macchanger
                    ethtool
                    tcpdump
                    wireshark-cli
                    tcpflow
                    dsniff
                    ettercap
                    mitmproxy
                    sslscan
                    sslyze
                    testssl
                    gitleaks
                    trufflehog
                    semgrep
                ];
                description = "General cybersecurity utilities and tools";
            };
        };

        osint = {
            enable = mkEnableOption "Enable OSINT (Open Source Intelligence) tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    sherlock
                    photon
                    spiderfoot
                    theHarvester
                    recon-ng
                    sublist3r
                    amass
                    subfinder
                ];
                description = "Open Source Intelligence gathering tools";
            };
        };

        cryptography = {
            enable = mkEnableOption "Enable cryptography and encoding tools";
            packages = mkOption {
                type = types.listOf types.package;
                default = with pkgs; [
                    hashcat
                    john
                    openssl
                    age
                    gnupg
                    cryptsetup
                    veracrypt
                    steghide
                ];
                description = "Cryptography, encryption, and encoding tools";
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
            ++ (if cfg.utilities.enable then cfg.utilities.packages else [])
            ++ (if cfg.osint.enable then cfg.osint.packages else [])
            ++ (if cfg.cryptography.enable then cfg.cryptography.packages else []);

        # Add useful aliases for common pentesting tasks
        programs.bash.shellAliases = mkIf cfg.enable {
            nmap-quick = "nmap -sS -O -F";
            nmap-full = "nmap -sS -sU -T4 -A -v -PE -PP -PS80,443 -PA3389 -PU40125 -PY -g 53 --script='default or (discovery and safe)'";
            gobuster-dir = "gobuster dir -u";
            ffuf-dir = "ffuf -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -u";
            burp = "burpsuite &";
            zap = "zaproxy &";
        };
    };
}
