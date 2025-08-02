# Cybersecurity Module

This module provides a comprehensive collection of cybersecurity and penetration testing tools organized into logical categories. Each category can be enabled independently to customize your security toolkit.

## Usage

To enable the cybersecurity module, add the following to your `home.nix` configuration:

```nix
modules = {
    cybersecurity = {
        enable = true;

        # Enable specific categories (all optional)
        networkScanning.enable = true;
        webApplicationTesting.enable = true;
        vulnerabilityAssessment.enable = true;
        exploitationFrameworks.enable = true;
        passwordAttacks.enable = true;
        wirelessTesting.enable = true;
        forensics.enable = true;
        reverseEngineering.enable = true;
        socialEngineering.enable = true;
        postExploitation.enable = true;
        utilities.enable = true;
        osint.enable = true;
        cryptography.enable = true;
    };
};
```

## Tool Categories

### 🔍 Network Scanning

Essential tools for network discovery and port scanning:

-   **nmap** - Network discovery and security auditing
-   **masscan** - Fast port scanner
-   **zmap** - Internet-wide network scanner
-   **rustscan** - Modern port scanner
-   **unicornscan** - Distributed TCP/IP stack fingerprinting
-   **hping** - Network tool to send custom TCP/IP packets
-   **netdiscover** - Active/passive ARP reconnaissance tool
-   **arp-scan** - ARP scanner
-   **fping** - Send ICMP ECHO_REQUEST packets to network hosts

### 🌐 Web Application Testing

Tools for testing web applications and APIs:

-   **burpsuite** - Web vulnerability scanner and proxy
-   **zaproxy** - OWASP ZAP web application security scanner
-   **dirb** - Web content scanner
-   **dirbuster** - Multi-threaded java application to brute force directories
-   **gobuster** - Directory/file, DNS and VHost busting tool
-   **ffuf** - Fast web fuzzer
-   **wfuzz** - Web application fuzzer
-   **nikto** - Web server scanner
-   **whatweb** - Web scanner to identify technologies
-   **wafw00f** - Web Application Firewall fingerprinting tool
-   **sqlmap** - Automatic SQL injection and database takeover tool
-   **commix** - Command injection exploiter
-   **wpscan** - WordPress vulnerability scanner

### 🔒 Vulnerability Assessment

Comprehensive vulnerability scanning and assessment tools:

-   **openvas-scanner** - Vulnerability scanner
-   **nuclei** - Fast and customizable vulnerability scanner
-   **lynis** - Security auditing tool for Unix derivatives
-   **chkrootkit** - Rootkit checker
-   **rkhunter** - Rootkit Hunter
-   **clamav** - Antivirus engine
-   **yara** - Pattern matching engine for malware research
-   **cve-bin-tool** - Scan for vulnerable components

### 💥 Exploitation Frameworks

Frameworks and tools for exploitation:

-   **metasploit** - Penetration testing framework
-   **exploitdb** - Exploit database
-   **searchsploit** - Command line search tool for Exploit-DB
-   **armitage** - Graphical cyber attack management tool
-   **beef** - Browser Exploitation Framework
-   **powersploit** - PowerShell post-exploitation framework

### 🔐 Password Attacks

Password cracking and brute force tools:

-   **john** - John the Ripper password cracker
-   **hashcat** - Advanced password recovery
-   **hydra** - Network logon cracker
-   **medusa** - Speedy, parallel, and modular login bruter
-   **ncrack** - Network authentication cracking tool
-   **patator** - Multi-purpose brute-forcer
-   **brutespray** - Brute-forcing tool
-   **crunch** - Wordlist generator
-   **cewl** - Custom Word List generator
-   **wordlists** - Collection of wordlists

### 📡 Wireless Testing

Tools for wireless network security testing:

-   **aircrack-ng** - WiFi security auditing tools suite
-   **reaver-wps-fork** - WPS brute force attack tool
-   **wifite2** - Automated wireless attack tool
-   **hostapd-mana** - Rogue access point framework
-   **kismet** - Wireless network detector
-   **wireshark** - Network protocol analyzer
-   **bettercap** - Network attack and monitoring framework
-   **mdk4** - WiFi testing tool
-   **cowpatty** - WPA-PSK dictionary attack tool
-   **pixiewps** - WPS pixie dust attack tool

### 🕵️ Digital Forensics

Tools for digital forensics and incident response:

-   **sleuthkit** - Digital forensics tools
-   **autopsy** - Digital forensics platform
-   **volatility3** - Memory forensics framework
-   **binwalk** - Firmware analysis tool
-   **foremost** - File carving tool
-   **scalpel** - File carving tool
-   **ddrescue** - Data recovery tool
-   **testdisk** - Data recovery software
-   **exiftool** - Metadata extraction tool
-   **steghide** - Steganography tool
-   **outguess** - Steganographic tool
-   **stegsolve** - Steganography solving tool

### 🔧 Reverse Engineering

Binary analysis and reverse engineering tools:

-   **ghidra** - Software reverse engineering framework
-   **radare2** - Reverse engineering framework
-   **cutter** - Reverse engineering platform
-   **ida-free** - Interactive disassembler (free version)
-   **gdb** - GNU Debugger
-   **ltrace** - Library call tracer
-   **strace** - System call tracer
-   **hexedit** - Hex editor
-   **file** - File type identification
-   **upx** - Executable packer
-   **objdump** - Object file dumper
-   **strings** - Extract printable strings from files

### 🎭 Social Engineering

Information gathering and social engineering tools:

-   **theharvester** - E-mail, subdomain and people names harvester
-   **maltego** - Open source intelligence platform
-   **recon-ng** - Reconnaissance framework
-   **fierce** - Domain scanner
-   **dmitry** - Information gathering tool
-   **enum4linux** - SMB enumeration tool
-   **samba** - SMB client
-   **snmp** - SNMP tools

### ⚙️ Post-Exploitation

Tools for maintaining access and lateral movement:

-   **mimikatz** - Extract credentials from Windows
-   **powershell** - PowerShell Core
-   **bloodhound** - Active Directory attack path analysis
-   **crackmapexec** - Network penetration testing tool
-   **impacket** - Network protocols implementation
-   **evil-winrm** - WinRM shell
-   **ligolo-ng** - Tunneling tool
-   **chisel** - Fast TCP/UDP tunnel
-   **socat** - Multipurpose relay
-   **netcat-gnu** - Network utility
-   **pwncat** - Command and control framework

### 🛠️ Utilities

General cybersecurity utilities:

-   **tor** - Anonymity network
-   **proxychains** - Proxy chains
-   **macchanger** - MAC address changer
-   **ethtool** - Ethernet tool
-   **tcpdump** - Packet analyzer
-   **wireshark-cli** - Wireshark command line
-   **tcpflow** - TCP flow recorder
-   **dsniff** - Network auditing tools
-   **ettercap** - Network sniffer/interceptor
-   **mitmproxy** - Interactive HTTPS proxy
-   **sslscan** - SSL/TLS scanner
-   **sslyze** - SSL configuration scanner
-   **testssl** - SSL/TLS tester
-   **gitleaks** - Detect secrets in git repos
-   **trufflehog** - Search for secrets in git repositories
-   **semgrep** - Static analysis tool

### 🔎 OSINT (Open Source Intelligence)

Tools for gathering intelligence from public sources:

-   **sherlock** - Find usernames across social networks
-   **photon** - Web crawler for OSINT
-   **spiderfoot** - OSINT automation tool
-   **theHarvester** - E-mail, subdomain and people names harvester
-   **recon-ng** - Reconnaissance framework
-   **sublist3r** - Subdomain enumeration tool
-   **amass** - In-depth attack surface mapping
-   **subfinder** - Subdomain discovery tool

### 🔐 Cryptography

Cryptography, encryption, and encoding tools:

-   **hashcat** - Advanced password recovery
-   **john** - John the Ripper password cracker
-   **openssl** - SSL/TLS toolkit
-   **age** - Simple, modern file encryption tool
-   **gnupg** - GNU Privacy Guard
-   **cryptsetup** - Setup cryptographic volumes
-   **veracrypt** - Disk encryption software
-   **steghide** - Steganography tool

## Built-in Features

### Aliases

Common aliases are provided for quick access:

-   `nmap-quick` - Quick nmap scan
-   `nmap-full` - Comprehensive nmap scan
-   `gobuster-dir` - Directory busting with gobuster
-   `ffuf-dir` - Directory fuzzing with ffuf
-   `burp` - Launch Burp Suite
-   `zap` - Launch OWASP ZAP

## Example Configurations

### Complete Pentesting Setup

```nix
modules = {
    cybersecurity = {
        enable = true;
        networkScanning.enable = true;
        webApplicationTesting.enable = true;
        vulnerabilityAssessment.enable = true;
        passwordAttacks.enable = true;
        utilities.enable = true;
        osint.enable = true;
    };
};
```

### Focused Web Application Testing

```nix
modules = {
    cybersecurity = {
        enable = true;
        webApplicationTesting.enable = true;
        utilities.enable = true;
    };
};
```

### Digital Forensics Workstation

```nix
modules = {
    cybersecurity = {
        enable = true;
        forensics.enable = true;
        reverseEngineering.enable = true;
        cryptography.enable = true;
        utilities.enable = true;
    };
};
```

## Important Notes

1. **Legal Usage**: These tools should only be used on systems you own or have explicit permission to test.

2. **Some tools may require additional setup**: Tools like commercial versions may require licenses.

3. **Root Privileges**: Some tools may require root privileges to function properly.

4. **Dependencies**: Some tools may need additional system configurations or kernel modules (especially wireless tools).

-   **masscan** - Fast port scanner
-   **zmap** - Internet-wide network scanner
-   **rustscan** - Modern port scanner
-   **unicornscan** - Distributed TCP/IP stack fingerprinting
-   **hping** - Network tool to send custom TCP/IP packets
-   **netdiscover** - Active/passive ARP reconnaissance tool
-   **arp-scan** - ARP scanner
-   **fping** - Send ICMP ECHO_REQUEST packets to network hosts

### Web Application Testing

Tools for testing web applications and APIs:

-   **burpsuite** - Web vulnerability scanner and proxy
-   **zaproxy** - OWASP ZAP web application security scanner
-   **dirb** - Web content scanner
-   **dirbuster** - Multi-threaded java application to brute force directories
-   **gobuster** - Directory/file, DNS and VHost busting tool
-   **ffuf** - Fast web fuzzer
-   **wfuzz** - Web application fuzzer
-   **nikto** - Web server scanner
-   **whatweb** - Web scanner to identify technologies
-   **wafw00f** - Web Application Firewall fingerprinting tool
-   **sqlmap** - Automatic SQL injection and database takeover tool
-   **commix** - Command injection exploiter
-   **xsser** - Cross Site Scripting detection tool
-   **wpscan** - WordPress vulnerability scanner

### Vulnerability Assessment

Comprehensive vulnerability scanning and assessment tools:

-   **openvas-scanner** - Vulnerability scanner
-   **nuclei** - Fast and customizable vulnerability scanner
-   **lynis** - Security auditing tool for Unix derivatives
-   **chkrootkit** - Rootkit checker
-   **rkhunter** - Rootkit Hunter
-   **clamav** - Antivirus engine
-   **yara** - Pattern matching engine for malware research
-   **cve-bin-tool** - Scan for vulnerable components

### Exploitation Frameworks

Frameworks and tools for exploitation:

-   **metasploit** - Penetration testing framework
-   **exploitdb** - Exploit database
-   **searchsploit** - Command line search tool for Exploit-DB
-   **armitage** - Graphical cyber attack management tool
-   **beef** - Browser Exploitation Framework
-   **empire** - PowerShell post-exploitation framework
-   **powersploit** - PowerShell post-exploitation framework

### Password Attacks

Password cracking and brute force tools:

-   **john** - John the Ripper password cracker
-   **hashcat** - Advanced password recovery
-   **hydra** - Network logon cracker
-   **medusa** - Speedy, parallel, and modular login bruter
-   **ncrack** - Network authentication cracking tool
-   **patator** - Multi-purpose brute-forcer
-   **brutespray** - Brute-forcing tool
-   **crunch** - Wordlist generator
-   **cupp** - Common User Passwords Profiler
-   **cewl** - Custom Word List generator
-   **wordlists** - Collection of wordlists

### Wireless Testing

Tools for wireless network security testing:

-   **aircrack-ng** - WiFi security auditing tools suite
-   **reaver** - WPS brute force attack tool
-   **wifite2** - Automated wireless attack tool
-   **hostapd-mana** - Rogue access point framework
-   **kismet** - Wireless network detector
-   **wireshark** - Network protocol analyzer
-   **bettercap** - Network attack and monitoring framework
-   **wifiphisher** - Rogue access point framework
-   **mdk4** - WiFi testing tool
-   **cowpatty** - WPA-PSK dictionary attack tool
-   **pyrit** - WPA/WPA2-PSK attacking tool

### Digital Forensics

Tools for digital forensics and incident response:

-   **sleuthkit** - Digital forensics tools
-   **autopsy** - Digital forensics platform
-   **volatility3** - Memory forensics framework
-   **binwalk** - Firmware analysis tool
-   **foremost** - File carving tool
-   **scalpel** - File carving tool
-   **ddrescue** - Data recovery tool
-   **testdisk** - Data recovery software
-   **photorec** - File recovery utility
-   **exiftool** - Metadata extraction tool
-   **steghide** - Steganography tool
-   **outguess** - Steganographic tool
-   **stegsolve** - Steganography solving tool

### Reverse Engineering

Binary analysis and reverse engineering tools:

-   **ghidra** - Software reverse engineering framework
-   **radare2** - Reverse engineering framework
-   **cutter** - Reverse engineering platform
-   **gdb** - GNU Debugger
-   **ida-free** - Interactive disassembler (free version)
-   **objdump** - Object file dumper
-   **strings** - Extract printable strings from files
-   **ltrace** - Library call tracer
-   **strace** - System call tracer
-   **hexedit** - Hex editor
-   **binutils** - Binary utilities
-   **file** - File type identification
-   **upx** - Executable packer

### Social Engineering

Information gathering and social engineering tools:

-   **theharvester** - E-mail, subdomain and people names harvester
-   **maltego** - Open source intelligence platform
-   **recon-ng** - Reconnaissance framework
-   **shodan** - Search engine for Internet-connected devices
-   **fierce** - Domain scanner
-   **dmitry** - Information gathering tool
-   **enum4linux** - SMB enumeration tool
-   **smbclient** - SMB client
-   **rpcclient** - RPC client
-   **snmpwalk** - SNMP application

### Post-Exploitation

Tools for maintaining access and lateral movement:

-   **mimikatz** - Extract credentials from Windows
-   **powershell** - PowerShell Core
-   **bloodhound** - Active Directory attack path analysis
-   **crackmapexec** - Network penetration testing tool
-   **impacket** - Network protocols implementation
-   **evil-winrm** - WinRM shell
-   **ligolo-ng** - Tunneling tool
-   **chisel** - Fast TCP/UDP tunnel
-   **socat** - Multipurpose relay
-   **netcat-gnu** - Network utility
-   **ncat** - Network tool
-   **pwncat** - Command and control framework

### Utilities

General cybersecurity utilities:

-   **tor** - Anonymity network
-   **proxychains** - Proxy chains
-   **macchanger** - MAC address changer
-   **ethtool** - Ethernet tool
-   **tcpdump** - Packet analyzer
-   **tcpflow** - TCP flow recorder
-   **dsniff** - Network auditing tools
-   **ettercap** - Network sniffer/interceptor
-   **mitmproxy** - Interactive HTTPS proxy
-   **sslscan** - SSL/TLS scanner
-   **sslyze** - SSL configuration scanner
-   **testssl** - SSL/TLS tester
-   **gitleaks** - Detect secrets in git repos
-   **truffleHog** - Search for secrets in git repositories
-   **semgrep** - Static analysis tool

## Environment Variables

The module sets up useful environment variables:

-   `WORDLISTS` - Path to wordlists collection
-   `SECLISTS` - Path to SecLists collection

## Aliases

Common aliases are provided for quick access:

-   `nmap-quick` - Quick nmap scan
-   `nmap-full` - Comprehensive nmap scan
-   `gobuster-dir` - Directory busting with gobuster
-   `ffuf-dir` - Directory fuzzing with ffuf
-   `burp` - Launch Burp Suite
-   `zap` - Launch OWASP ZAP

## Important Notes

1. **Legal Usage**: These tools should only be used on systems you own or have explicit permission to test.

2. **Some tools may require additional setup**: Tools like Nessus, Burp Suite Pro, or commercial versions may require licenses.

3. **Wireshark**: When wireless testing or utilities are enabled, Wireshark is automatically configured.

4. **Root Privileges**: Some tools may require root privileges to function properly.

5. **Dependencies**: Some tools may need additional system configurations or kernel modules (especially wireless tools).

## Example Configuration

For a complete pentesting setup:

```nix
modules = {
    cybersecurity = {
        enable = true;
        networkScanning.enable = true;
        webApplicationTesting.enable = true;
        vulnerabilityAssessment.enable = true;
        passwordAttacks.enable = true;
        utilities.enable = true;
        # Enable other categories as needed
    };
};
```

For a focused web application testing setup:

```nix
modules = {
    cybersecurity = {
        enable = true;
        webApplicationTesting.enable = true;
        utilities.enable = true;
    };
};
```
