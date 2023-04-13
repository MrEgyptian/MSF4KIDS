#!/bin/env bash
# Ver: 0.1
# By : @MrEgyptian
# GitHub :Github.com/MrEgyptian
# Website : https://www.MrEgyptian.codes
# Contact : Me@MrEgyptian.com

# Proudly written in nano :)
r='\x1b[91m' #For red Color
g='\x1b[92m' #For green Color
y='\x1b[93m' #For yellow Color
b='\x1b[94m' #For blue Color
m='\x1b[95m' #For blue Color
port='4444'  #NetWork Port
banner(){ 
#Defining banner function
banner='ChtbMTs5Mm0gIF9fICBfXyBfX18gX19fG1s5MW0gICAg4paE4paEIBtbOTRtICBfICBfX18gICAgXyAgICAKG1s5Mm0gfCAgXC8gIC8gX198IF9fG1s5MW0gICDiloTiloDiloggG1s5NG18IHwvIChfKV9ffCB8X19fChtbOTJtIHwgfFwvfCBcX18gXCBffBtbOTFtICDilojiloAg4paIIBtbOTRtfCBcJyA8fCAvIF9gIChfLTwKG1s5Mm0gfF98ICB8X3xfX18vX3wgG1s5MW0g4paI4paE4paE4paE4paI4paEG1s5NG18X3xcX1xfXF9fLF8vX18vChtbOTFtICAgICAgICAgICAgICAgICAgICAg4paIIAobWzkzbSAgICAgICAgICAgICBCeTobWzk0bU1yRWd5cHRpYW4KCg=='
echo $banner|base64 -d #Decoding the banner from base64 format
}
proc(){
echo -e $b $@
}
success(){
echo -e $g $@
}
update_sources(){
proc 'Updating sources..'
pkg update -y
success 'Sources updated.'
}
install_unstable_repo(){
proc 'Installing unstable-repo'
pkg install unstable-repo -y
update_sources
success 'Unstable repo installed'
}
install_termux_service(){
proc 'Installing termux-service'
pkg install termux-service -y
success 'termux-service installed'
}
install_deps(){
proc 'Installing ruby and build Dependencies'
pkg install -y git autoconf build-essential libpcap ruby postgresql postgresql-static iconv libxml2-utils openssh
success 'Dependencies installed'
}
add_pwd_to_path(){
export PATH=$PWD:$PATH
echo 'export PATH=$PWD:$PATH'>>~/.bashrc
}
install_pkg_config(){
pkg install pkg-config binutils -y && gem install pkg-config #p
pkg install gumbo-parser -y
}
postgres_fixes(){
mkdir -p $PREFIX/var/lib/postgresql
initdb $PREFIX/var/lib/postgresql

pg_ctl -D /data/data/com.termux/files/usr/var/lib/postgresql -l logfile start
}
install_msf(){
#Defining Metasploit installer script
update_sources #Updating sources to avoid Errors
#Repos installing
install_unstable_repo #Installing unstable-repo because some pkgs aren't existed in the standard repo
#termux service
install_termux_service #It's optional for postgres and openssh etc (to manage daemons ).
#Build things :)
install_deps #Installing necessary dependencies
proc 'Some configs ^_^'
install_pkg_config #to guide bandler for installing some pkgs
success 'pkg-config installed'
proc 'Getting PostgreSQL ready ...'
postgres_fixes
success 'PostgreSQL is now ready'
proc 'Downloading metasploit..'
git clone https://github.com/rapid7/metasploit-framework
success 'Metasploit Downloaded'
cd metasploit-framework
proc 'Installing metasploit framework'
gem install bundler
bundle update
bundle install
success 'Metasploit installed'
proc 'adding MSF to PATH..'
add_pwd_to_path
#./msfdb init
success 'now you should initialize webservice with' $y'./msfdb init'
success 'you can run metasploit using '$y'./msfconsole'
success 'GoodLuck ^^'
}
options(){
script_opts='Install metasploit\n'
#script_opts+='Install Extras \n' #not yet available
script_opts+='Exit'
echo -e $y
echo -e $script_opts|cat -n |sed -z 's|\t|'$g'\t|g;s|\n|'$y'\n|g'
read -p "$(echo -e ${b}'choose' ${r}'>'${g})" input #Reading input
case $input in
 1|'install'|'installmsf'|'Install metasploit'|'install metasploit')
 install_msf
 exit
 ;;
 2|'exit'|'Exit'|'Quit'|'q'|'bye')
 echo $PWD
 exit
 ;;
 *)
 echo -e $r 'Wrong input "'$m$input$r'"'
 ;;
 esac #Esac is the reverse of the word case and its for closing the function
}
banner
while true
 do
   options
 done
