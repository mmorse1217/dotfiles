
# Colorize the Terminalexport CLICOLOR=1;
CLICOLOR=1;

# Open OSX apps from commandline by name
function foomagick() {
    rm -f ~/.foomagick.tmp
    ls /Applications/ | grep "\.app" | grep -v iWork | while read APP; do
        # clean it up                                                           
        a=`echo $APP | sed s/\ //g`;
        a=`echo $a | sed s/\'//g`;
        echo alias ${a%.*}="'open -a \"${APP%.*}\"'" >> ~/.foomagick.tmp
    done
    source ~/.foomagick.tmp
    rm ~/.foomagick.tmp  
}
foomagick

export PATH=/opt/homebrew/bin:$PATH
[[ -s /Users/mattmors/.autojump/etc/profile.d/autojump.sh ]] && source /Users/mattmors/.autojump/etc/profile.d/autojump.sh
eval "$(/opt/homebrew/bin/brew shellenv)"
