# The Kali linux base image
FROM kalilinux/kali-linux-docker

# Update all the things, then install my personal faves
RUN apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get install -y \
 cadaver \
 dirb \
 exploitdb \
 exploitdb-bin-sploits \
 git \
 gdb \
 gobuster \
 hashcat \
 hydra \
 man-db \
 medusa \
 minicom \
 nasm \
 nikto \
 nmap \
 sqlmap \
 sslscan \
 webshells \
 wpscan \
 wordlists \
 python-pip

# Create known_hosts for git cloning things I want
RUN mkdir /root/.ssh
RUN touch /root/.ssh/known_hosts
# Add host keys
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone git repos
RUN git clone https://github.com/danielmiessler/SecLists.git /opt/seclists
RUN git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit
RUN git clone https://github.com/hashcat/hashcat /opt/hashcat
RUN git clone https://github.com/rebootuser/LinEnum /opt/linenum

# pip install-ing some things
RUN pip install pwntools

# Update ENV
ENV PATH=$PATH:/opt/powersploit
ENV PATH=$PATH:/opt/hashcat

# Set entrypoint and working directory (Mac specific)
WORKDIR /home/user/kali/

# Expose ports 80 and 443
EXPOSE 80/tcp 443/tcp
