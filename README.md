vimconf
=======
My .vim setup, use the following commands to get started.

<img src="https://github.com/zfedoran/vimconf/raw/master/screenshot.png" alt="" />

`git clone https://github.com/zfedoran/vimconf.git ~/.vim` 

`chmod +x ~/.vim/init.sh && ~/.vim/init.sh`

You may need to add the following to your `~/.bashrc` file:

```
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi
```
