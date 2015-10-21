# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# you can use these commands:
# dir, ll, ls  ->  shows you the directory content (different views)
# findn <name> -> finds files with name (does search in subdirectories too)
# h -> shows history 
# psg <program-name> -> shows running processes
# wg <http-,ftp-url> -> wget download automatic in the background


# If running interactively, then:
if [ "$PS1" ]; then

    # don't put duplicate lines in the history. See bash(1) for more options
    # export HISTCONTROL=ignoredups

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    #shopt -s checkwinsize

 
    # some more ls aliases
    alias lll='ls -lGa'
    alias ll='ls -lG'
    alias la='ls -AG'
    alias l='ls -CFG'

# bash_completion
    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
      . /opt/local/etc/profile.d/bash_completion.sh
    fi
    
    # scpresume
    alias scpresume="rsync --partial --progress --rsh=ssh"

    # set a fancy prompt
    # PS1='\u@\h:\w\$ '
    if [ $TERM = "xterm" ] ||  [ $TERM = "xterm-color" ] || [ $TERM = "xterm-256color" ] || [ $TERM = "dtterm" ]; then
      # Prompt mit user@host:Pfad im xterm-Titel und user@host> als
      # bold-Prompt
      PS1="\[\033]2;\u@\h:\w [\$?]\007\033[1m\]\u@\h:\W>\[\033[m\] "
    else
      # Konsole etc., kein X
      PS1="\[\033[1m\]\u@\h[\$?]:\w>\[\033[m\] "
    fi
    export PS1

    function shortprompt () { PS1="\[\033]2;\u@\h:\w [\$?]\007\033[1m\]\u@\h:\W>\[\033[m\] " ; export PS1 ; }
    function longprompt () { PS1="\[\033]2;\u@\h:\w [\$?]\007\033[1m\]\u@\h:\w>\[\033[m\] " ; export PS1 ; }	

    # If this is an xterm set the title to user@host:dir
    #case $TERM in
    #xterm*)
    #    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    #    ;;
    #*)
    #    ;;
    #esac

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc).
    if [ -f /etc/bash_completion ]; then
      . /etc/bash_completion
    fi


    # dir listings
      #function ls           () { /bin/ls --color=auto $* ; }
      function ll 	    () { ls -Fla $* ; }
      function dir	    () { ls -Fla $* ; }

    # psg - shows running processes
      function psg          () {
        set -f
        ps auxww | egrep -i "$*|^ +UID" | grep -v egrep
        set +f ;  }

      function wg           () { wget -c -b -t99 -UMozila/4.0 $1 ;}


    # more misc
      #function cp           () { /bin/cp -i $* ; }
      #function mv           () { /bin/mv -i $* ; }
      function h	          () { history ; }
      function push         () { pushd $* ; cd . ; }
      function pop          () { popd  $* ; cd . ; }
      function findn        () {
        set -f
        local pattern=$1
        shift
        find . -name $pattern -print $*
        set +f ;  }


    ## set environment for locally installed software packages
    #  for i in /usr/sw/*/default/.bashenv; do
    #    . $i
    #    done

    ## Need to set JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home)
    #export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Home


    ## set PATH so it includes user's private bin if it exists
      if [ -d ~/bin ] ; then
        PATH="~/bin/:${PATH}"
      fi

    ## do the same with MANPATH
      if [ -d ~/man ]; then
        MANPATH="~/man/:${MANPATH}"
      fi

    
    # Don't set DISPLAY here, let XQuartz do it. See http://xquartz.macosforge.org/trac/wiki/X11-UsersFAQ#sshXforwardingdebugging
    #export DISPLAY=:0.0

    # HySpirit

    hyinstall=/usr/local/sw/hyspirit
    if [ -e $hyinstall ]
    then
       pushd $hyinstall > /dev/null
       if [ -e INSTALL.bash ]
       then
	   source INSTALL.bash
       fi
       popd > /dev/null
    fi

    # Tomcat
    alias start_tomcat="/Library/Tomcat/bin/startup.sh"
    alias stop_tomcat="/Library/Tomcat/bin/shutdown.sh"

    # environment (continued)
      #export PATH=$PATH:.
      export PAGER=less
      export LESS="-M -i"
      export LESSCHARSET=latin1
      export GZIP="--best"
      export CVS_RSH=ssh
      export CVSROOT=:ext:ingo@cvs.is.informatik.uni-duisburg.de:/services/cvsroot
      export TOILCVSROOT=:ext:frommhol@toil.dcs.qmul.ac.uk:/import/ir/CVS
      export EDITOR=vim
    # Language
      #export LANG=de_DE.UTF-8
fi


export PATH=/usr/local/bin:/usr/local/sbin:$PATH



# Oracle SQLPlus client
export ORACLE_HOME=/usr/local/instantclient_11_2
export TNS_ADMIN=$ORACLE_HOME/network/admin
PATH=$ORACLE_HOME:$PATH
export DYLD_LIBRARY_PATH=$ORACLE_HOME:$DYLD_LIBRARY_PATH

# MySQL
export PATH=/usr/local/mysql/bin:$PATH


# TeXCount
export PATH=/usr/local/TeXcount_3_0_alpha:$PATH


# Finished adapting your PATH environment variable for use with MacPorts.

# GPG always wants to know what TTY it's running on. 
export GPG_TTY=`tty`
##
# Your previous /Users/ingo/.profile file was backed up as /Users/ingo/.profile.macports-saved_2013-11-09_at_00:44:12
##


# MacPorts Installer addition on 2015-10-03_at_12:27:07: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

