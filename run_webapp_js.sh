
npm list -g
npm list -g flatiron

# removes all npm modules globally
#npm -g ls | grep -v 'npm@' | awk '/@/ {print $2}' | awk -F@ '{print $1}' | xargs npm -g rm
grunt --force